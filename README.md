<h1 align="center">🟩 Neovim Customization 🟩</h1>

<p align="center">
A personal <a href="https://nvchad.com/">NvChad v2.5</a> based Neovim configuration,
tuned for web development (TypeScript/React), Go, and a Git-heavy workflow.
</p>

---

## ✨ Highlights

- **Base framework:** [NvChad v2.5](https://nvchad.com/) — provides the UI, theming (base46), completion (nvim-cmp), treesitter, which-key and sane defaults.
- **Theme:** `decay` with an arrow-style custom statusline (shows file path, git, diagnostics and cursor position percentage).
- **Leader key:** `,` (comma).
- **AI completion:** inline suggestions via [Supermaven](https://github.com/supermaven-inc/supermaven-nvim).
- **Git inside Neovim:** full [Neogit](https://github.com/NeogitOrg/neogit) UI + [Gitsigns](https://github.com/lewis6991/gitsigns.nvim) hunk actions and inline blame.
- **GitHub from the dashboard:** browse your assigned issues and PRs through [snacks.nvim](https://github.com/folke/snacks.nvim).
- **Claude Code integration:** [claudecode.nvim](https://github.com/coder/claudecode.nvim) — speaks the same WebSocket protocol as the official VS Code/JetBrains extensions, so Claude sees your selection, can open files, and proposes changes as diffs you accept or reject without leaving Neovim.

---

## 📋 Prerequisites

Make sure these are installed on your machine before setting up the config:

| Requirement | Why |
| --- | --- |
| **Neovim ≥ 0.10** | Required by NvChad v2.5. |
| **Git** | Bootstrapping lazy.nvim and Neogit. |
| **A [Nerd Font](https://www.nerdfonts.com/)** | Icons in the UI, file tree and statusline. |
| **[ripgrep](https://github.com/BurntSushi/ripgrep)** (`rg`) | Powers live grep / file pickers. |
| **Node.js** | Needed by web LSP servers and `prettierd` / `biome`. |
| **Go** | Needed for the `gopls` language server. |
| **[GitHub CLI](https://cli.github.com/)** (`gh`), authenticated | Required by the snacks GitHub issue/PR pickers. |
| **A C compiler** (`gcc`/`clang`) | Building treesitter parsers. |
| **[Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code)** | Required by the claudecode.nvim integration. The spec points at `~/.local/bin/claude` — see below. |

---

## 🚀 Installation (fresh Neovim)

> ⚠️ This **replaces** your existing Neovim config. Back it up first.

1. **Back up any existing configuration and data:**

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   mv ~/.local/state/nvim ~/.local/state/nvim.bak
   mv ~/.cache/nvim ~/.cache/nvim.bak
   ```

2. **Clone this repository into the Neovim config path:**

   ```bash
   git clone https://github.com/nox456/neovim-config ~/.config/nvim
   ```

3. **Launch Neovim:**

   ```bash
   nvim
   ```

   On first launch, `init.lua` bootstraps [lazy.nvim](https://github.com/folke/lazy.nvim), installs every plugin from `lazy-lock.json`, and compiles the base46 theme cache. Let it finish, then **restart Neovim**.

4. **Install LSP servers, formatters and tools** via Mason:

   ```vim
   :Mason
   ```

   Install the tools you need (see the [LSP & Formatting](#-lsp--formatting) section). Treesitter parsers install automatically as you open files; you can also run `:TSInstall <lang>`.

5. **Authenticate the GitHub CLI** (only if you want the issue/PR pickers):

   ```bash
   gh auth login
   ```

That's it — open a project and start working.

---

## 🗂️ Project Structure

```
~/.config/nvim
├── init.lua                  # Entry point: bootstraps lazy.nvim, loads theme, options, autocmds, mappings
├── lazy-lock.json            # Pinned plugin versions (commit lockfile)
├── .stylua.toml              # Lua formatter (stylua) settings
└── lua/
    ├── chadrc.lua            # NvChad overrides: theme, dashboard (nvdash) buttons, custom statusline
    ├── options.lua           # Vim options (folds, undofile, …)
    ├── autocmds.lua          # Autocommands (dashboard on empty buffer, snacks main-window fix)
    ├── mappings.lua          # All custom keymaps
    ├── plugins/
    │   └── init.lua          # Plugin specs added on top of NvChad
    ├── configs/
    │   ├── lazy.lua          # lazy.nvim settings (UI, disabled built-ins)
    │   ├── lspconfig.lua     # Enabled LSP servers
    │   └── conform.lua       # Formatters per filetype
    └── nvchad/
        └── configs/
            └── nvimtree.lua  # nvim-tree (file explorer) overrides
```

**How it loads:** `init.lua` clones lazy.nvim if missing, loads `NvChad/NvChad` (which imports `nvchad.plugins`), then imports everything under `lua/plugins/`. The theme cache is sourced from `base46`, then `options` → `autocmds` → `mappings` run in order.

---

## 🔌 Installed Plugins

### Added in this config (`lua/plugins/init.lua`)

| Plugin | Purpose |
| --- | --- |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting (format-on-save is available but commented out). |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Language Server configuration. |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) + [telescope-project.nvim](https://github.com/nvim-telescope/telescope-project.nvim) | Fuzzy finder and project switcher (opens in **normal** mode by default). |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer (shows dotfiles, syncs root with cwd, quits on open). |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | File/grep pickers + GitHub issue/PR integration. |
| [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | Better code folding (treesitter + indent). |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | Installer for LSP servers, formatters and linters. |
| [bufdelete.nvim](https://github.com/famiu/bufdelete.nvim) | Delete buffers without wrecking the window layout. |
| [supermaven-nvim](https://github.com/supermaven-inc/supermaven-nvim) | AI inline completion. |
| [neogit](https://github.com/NeogitOrg/neogit) | Magit-style Git interface (commit editor shows staged diff). |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git gutter signs, hunk actions and inline blame. |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Async linting — **currently disabled** (eslint for TS is preconfigured). |
| [yanky.nvim](https://github.com/gbprod/yanky.nvim) | Yank ring / clipboard history. |
| [claudecode.nvim](https://github.com/coder/claudecode.nvim) | Claude Code integration — selection/buffer context, diffs reviewed in-editor. |

### Provided by NvChad (managed automatically)

`base46` (theming) · `nvim-cmp` + cmp sources · `LuaSnip` + `friendly-snippets` · `nvim-treesitter` · `nvim-autopairs` · `nvim-web-devicons` · `which-key.nvim` · `indent-blankline.nvim` · `menu` · `minty` · `volt` · `ui` · `plenary.nvim`.

---

## ⌨️ Keybindings

Leader is **`,`**. The full list of custom maps lives in **[lua/KEYBINDINGS.md](lua/KEYBINDINGS.md)** — covering general editing, buffers/tabs, files & search, folds, terminals, Git, Claude Code (`<leader>c*`) and the yank ring.

> The NvChad defaults still apply on top of these — press `,` and wait for the [which-key](https://github.com/folke/which-key.nvim) popup to discover everything else.

---

## 🧠 LSP & Formatting

**Language servers** (`lua/configs/lspconfig.lua`) — install these via `:Mason`:

`ts_ls` · `eslint` · `cssls` · `html` · `hyprls` · `jsonls` · `biome` · `prismals` · `gh_actions_ls` · `astro` · `gopls`

**Formatters** (`lua/configs/conform.lua`):

| Filetype | Formatter |
| --- | --- |
| Lua | `stylua` |
| CSS / HTML / JSON | `prettierd`, `biome` |
| JavaScript / TypeScript (+ React) | `prettierd`, `biome` |

Format manually with `<leader>i`. To enable **format on save**, uncomment the `format_on_save` block in `lua/configs/conform.lua`.

---

## 🎨 Customization Tips

- **Change the theme:** edit `M.base46.theme` in `lua/chadrc.lua`, or pick one live with `:lua require('nvchad.themes').open()` (also on the dashboard via `th`).
- **Dashboard buttons:** edit `M.nvdash.buttons` in `lua/chadrc.lua`.
- **Add a plugin:** add a spec to `lua/plugins/init.lua`, then run `:Lazy sync`.
- **Add an LSP:** append the server name to the `servers` list in `lua/configs/lspconfig.lua` and install it via `:Mason`.
- **Point Claude Code at your own binary:** the spec in `lua/plugins/init.lua` hardcodes `terminal_cmd = "~/.local/bin/claude"`. If yours lives elsewhere (check with `which claude`), edit that path — or delete the line entirely to fall back to whatever `claude` is on your `$PATH`.

---

## 🛠️ Handy Commands

| Command | Description |
| --- | --- |
| `:Lazy` | Plugin manager UI (install / update / clean) |
| `:Mason` | Install/manage LSP servers, formatters, linters |
| `:Nvdash` | Open the NvChad dashboard |
| `:Telescope project` | Switch between projects |
| `:checkhealth` | Diagnose missing dependencies |
