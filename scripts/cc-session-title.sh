#!/usr/bin/env bash
#
# Claude Code UserPromptSubmit hook: prefixes the session's title with the
# project it was spawned in -- `[nvim] - plan issue 10` -- the format sessions
# used to be renamed to by hand. Neovim adds this hook to every Claude Code
# session it launches, through `claude --settings` (lua/configs/claude.lua). It
# is deliberately not in ~/.claude/settings.json, so sessions started from a
# shell keep their titles untouched.
#
# The title to prefix is the session's custom one (/rename, --name, or this
# hook), which Claude Code hands in as `session_title`. Its auto-generated title
# never reaches hooks, so until the session has a custom title it is read off
# the transcript's last `"type":"ai-title"` line -- an undocumented format, which
# is why a miss just leaves the title alone. That title only exists once the
# first reply is in, so the prefix lands from the second prompt on.
#
# A title that already opens with a `[...]` group is left as it is: that is this
# hook's own prefix on every later prompt, or one typed by hand
# (`[INFRA] - ENG-675`).
#
# The project is named the way the statusline's cwd section names it: the main
# repository, never a linked worktree. Keep `project_name` in step with
# `repo_name` in lua/statusline/cwd.lua.
#
# Claude Code feeds a UserPromptSubmit hook's plain stdout to the model and
# blocks the prompt on exit code 2, so this script prints either nothing or one
# JSON object, and exits 0 whatever happens.

set -uo pipefail

for tool in jq git; do
  command -v "$tool" >/dev/null 2>&1 || exit 0
done

input=$(cat)
jq -e 'type == "object"' <<<"$input" >/dev/null 2>&1 || exit 0

# A string field of the hook input, trimmed; empty when absent or not a string.
field() {
  jq -r --arg key "$1" '(.[$key] | strings | gsub("^\\s+|\\s+$"; "")) // ""' <<<"$input" 2>/dev/null
}

project_name() {
  local dir=$1 out gitdir root commondir name

  if ! out=$(git -C "$dir" rev-parse --absolute-git-dir --show-toplevel --path-format=absolute --git-common-dir 2>/dev/null); then
    basename -- "$dir"
    return
  fi
  { read -r gitdir; read -r root; read -r commondir; } <<<"$out"

  if [ "$commondir" = "$gitdir" ]; then
    basename -- "$root"
    return
  fi

  # `proj/.git`, `proj/.bare`: the repository is the directory holding it.
  name=$(basename -- "$commondir")
  case $name in
    .*) basename -- "$(dirname -- "$commondir")" ;;
    *) printf '%s\n' "${name%.git}" ;;
  esac
}

title=$(field session_title)
if [ -z "$title" ]; then
  transcript=$(field transcript_path)
  [ -n "$transcript" ] && [ -r "$transcript" ] || exit 0
  title=$(grep -F '"type":"ai-title"' -- "$transcript" 2>/dev/null | tail -n 1 |
    jq -r '(.aiTitle | strings | gsub("^\\s+|\\s+$"; "")) // ""' 2>/dev/null)
fi
[ -n "$title" ] || exit 0

prefixed='^\[[^]]+\]'
[[ $title =~ $prefixed ]] && exit 0

dir=${CLAUDE_PROJECT_DIR:-$(field cwd)}
[ -n "$dir" ] || exit 0
project=$(project_name "$dir")
[ -n "$project" ] || exit 0

jq -cn --arg project "$project" --arg title "$title" \
  '{hookSpecificOutput: {hookEventName: "UserPromptSubmit", sessionTitle: ("[\($project)] - \($title)" | .[0:200])}}' 2>/dev/null
exit 0
