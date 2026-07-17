# ⌨️ Keybindings

Leader is **`,`**. The most useful custom maps (`lua/mappings.lua`):

## General
| Key | Action |
| --- | --- |
| `;` | Enter command mode (`:`) |
| `<leader>s` | Save file |
| `<leader>q` | Quit window |
| `<leader>w` | Delete current buffer (keeps layout) |
| `<leader>i` | Format file (conform, LSP fallback) |
| `<leader>k` | Toggle comment (normal & visual) |
| `<leader><Tab>` | Accept Supermaven suggestion |

## Buffers & Tabs
| Key | Action |
| --- | --- |
| `<A-2>` / `<A-3>` | Previous / next buffer |
| `<A-4>` / `<A-5>` | Previous / next tab |

## Files & Search
| Key | Action |
| --- | --- |
| `<leader>b` | Toggle file explorer (nvim-tree) |
| `<leader>F` | Find files (snacks picker) |
| `<leader>f` | Live grep (snacks picker) |
| `<C-CR>` (in tree) | Change root to the node under cursor |

## Folds (nvim-ufo)
| Key | Action |
| --- | --- |
| `<leader><` | Fold |
| `<leader>>` | Unfold |

## Terminals
| Key | Action |
| --- | --- |
| `<leader>th` | New horizontal terminal |
| `<leader>tv` | New vertical terminal |
| `<leader>tt` | New terminal in a new tab |
| `<leader>tf` | New floating terminal |
| `<ESC><ESC>` | Exit terminal mode |

## Claude Code (claudecode.nvim)
| Key | Action |
| --- | --- |
| `<leader>cc` | Toggle Claude |
| `<leader>cf` | Focus Claude |
| `<leader>cr` | Resume a previous session |
| `<leader>cm` | Select Claude model |
| `<leader>cb` | Add current buffer to the context |
| `<leader>cs` (visual) | Send selection to Claude |
| `<leader>ca` / `<leader>cd` | Accept / deny a diff |

## Git
| Key | Action |
| --- | --- |
| `<leader>g` | Open Neogit |
| `<leader>ng` / `<leader>pg` | Next / previous hunk |
| `<leader>gp` | Preview hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>ghi` | GitHub issues assigned to me |
| `<leader>ghp` | GitHub PRs assigned to me |

## Yank ring (yanky)
| Key | Action |
| --- | --- |
| `p` / `P` | Put after / before (via yanky) |
| `<C-p>` / `<C-n>` | Cycle to previous / next yank entry |
| `<leader>y` | Open yank ring history |
| `<leader>yr` | Clear yank history |

> The NvChad defaults still apply on top of these — press `,` and wait for the [which-key](https://github.com/folke/which-key.nvim) popup to discover everything else.
