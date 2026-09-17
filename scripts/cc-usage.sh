#!/usr/bin/env bash
#
# Fetches the account's usage windows and caches them for Neovim's Claude Code
# statusline section (lua/statusline/claude.lua), which spawns this script on a
# timer while the section is on screen.
#
# This is the same endpoint the CLI's `/usage` screen reads, called with the
# OAuth token Claude Code already keeps in ~/.claude/.credentials.json. The
# earlier version of this integration went through Claude Code's `statusLine`
# hook instead; that was dropped because configuring the hook makes Claude Code
# reserve a status-line row in its own UI, blank or not.
#
# Two things this script must not do: print the token (it is passed to curl
# through a config file on stdin, so it never reaches the process list), and
# clobber a good cache with a failed response. A failed run leaves the previous
# cache in place and exits 0 -- Neovim just keeps showing the last known figures
# until the window they belong to expires.

set -uo pipefail

creds="$HOME/.claude/.credentials.json"
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/claude-code"
cache_file="$cache_dir/usage.json"

for tool in jq curl date; do
  command -v "$tool" >/dev/null 2>&1 || exit 0
done
[ -r "$creds" ] || exit 0

token=$(jq -r '.claudeAiOauth.accessToken // empty' "$creds" 2>/dev/null) || exit 0
[ -n "$token" ] || exit 0

# Claude Code refreshes this token; we cannot. An expired one only earns a 401,
# so skip the call and keep whatever is already cached.
expires_at=$(jq -r '.claudeAiOauth.expiresAt // empty' "$creds" 2>/dev/null)
if [ -n "$expires_at" ] && [ "$expires_at" -le "$(($(date +%s) * 1000))" ] 2>/dev/null; then
  exit 0
fi

response=$(printf 'header = "Authorization: Bearer %s"\n' "$token" | curl -sS --max-time 10 -K - \
  -H "anthropic-beta: oauth-2025-04-20" \
  -H "Content-Type: application/json" \
  --url "https://api.anthropic.com/api/oauth/usage" 2>/dev/null) || exit 0
unset token

# `utilization` is already a percentage here (0-100), unlike the CLI's internal
# 0-1 form, and `resets_at` is an ISO 8601 string rather than epoch seconds.
used=$(printf '%s' "$response" | jq -r '.five_hour.utilization // empty' 2>/dev/null) || exit 0
[ -n "$used" ] || exit 0

resets_iso=$(printf '%s' "$response" | jq -r '.five_hour.resets_at // empty' 2>/dev/null)
resets_at=null
if [ -n "$resets_iso" ]; then
  if resets_epoch=$(date -d "$resets_iso" +%s 2>/dev/null); then
    resets_at="$resets_epoch"
  fi
fi

mkdir -p "$cache_dir" 2>/dev/null || exit 0

# Write through a temp file in the same directory so a rename is atomic and
# Neovim never reads a half-written cache.
tmp=$(mktemp "$cache_file.XXXXXX" 2>/dev/null) || exit 0
if jq -n --argjson used "$used" --argjson resets_at "$resets_at" \
  '{fetched_at: now | floor, five_hour: {used_percentage: $used, resets_at: $resets_at}}' >"$tmp" 2>/dev/null; then
  mv -f "$tmp" "$cache_file" 2>/dev/null || rm -f "$tmp"
else
  rm -f "$tmp"
fi

exit 0
