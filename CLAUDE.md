# CLAUDE.md — AI Assistant Guide for `configs` Repository

## Overview

This is a **personal developer dotfiles and configuration repository**. It contains editor, terminal, and IDE configurations for a single developer's environment. There is no application code, build pipeline, or test suite — the "source of truth" is the collection of config files themselves.

**Primary tools configured:**
- Neovim (main editor, most extensively configured)
- Tmux (terminal multiplexer)
- Vim (minimal fallback config)
- VS Code (secondary editor)
- IntelliJ IDEA (archived settings)
- iTerm2 (macOS terminal emulator)
- Bash shell

---

## Repository Structure

```
configs/
├── CLAUDE.md                    # This file
├── README.md                    # Minimal install reference
├── .bash_profile                # Bash shell init: PATH, NVM, Ruby, Python
├── .prettierrc                  # Prettier formatter defaults
├── .tmux.conf                   # Tmux config (prefix: Ctrl+S, Catppuccin theme)
├── .vimrc                       # Minimal Vim config (fallback to Neovim)
├── vscode_settings.json         # VS Code editor settings
├── vs-code-debugger             # VS Code Node.js debug launch config
├── iterm2-default.json          # iTerm2 terminal profile
├── iterm-default.itermkeymap    # iTerm2 key bindings
├── intellij-settings.zip        # IntelliJ IDE settings archive
└── nvim/                        # Neovim configuration (primary editor)
    ├── init.lua                 # Entry point: bootstraps Lazy.nvim, loads modules
    ├── lazy-lock.json           # Plugin version lockfile (do not edit manually)
    └── lua/
        ├── plugins.lua          # Plugin loader (minimal — delegates to plugins/)
        ├── vim-bindings.lua     # Core vim options and keymaps
        └── plugins/             # One file per plugin
            ├── alpha.lua        # Dashboard/startup screen
            ├── autoclose.lua    # Auto-close brackets/quotes
            ├── catppuccin.lua   # Color scheme
            ├── codeium.lua      # AI code completion (Ctrl+G to accept)
            ├── colorizer.lua    # Inline color preview
            ├── colortils.lua    # Color manipulation tools
            ├── comment.lua      # Toggle comments
            ├── completions.lua  # nvim-cmp completion engine
            ├── debugging.lua    # nvim-dap debugger
            ├── folding.lua      # Code folding (nvim-ufo)
            ├── lsp-config.lua   # LSP: lua_ls + ts_ls via Mason
            ├── lualine.lua      # Status line (Dracula theme)
            ├── marks.lua        # Vim marks
            ├── neotree.lua      # File explorer (Ctrl+N)
            ├── none-ls.lua      # Formatting/linting (Prettier, Stylua, ESLint)
            ├── nvim-tmux-nav.lua# Tmux pane navigation
            ├── telescope.lua    # Fuzzy finder (Ctrl+P files, <leader>fg grep)
            ├── treesitter.lua   # Syntax highlighting (Lua, JS, TS)
            └── vim-test.lua     # Test runner via Tmux/Vimux
```

---

## Installation / Symlink Targets

To use these configs, symlink or copy files to the appropriate locations:

| File in repo | Target location |
|---|---|
| `nvim/` | `~/.config/nvim/` |
| `.tmux.conf` | `~/.tmux.conf` |
| `.vimrc` | `~/.vimrc` |
| `.bash_profile` | `~/.bash_profile` |
| `.prettierrc` | `~/.prettierrc` (or project root) |
| `vscode_settings.json` | VS Code `settings.json` |

> Note: The README.md has a typo — `.tmux.confg` should be `.tmux.conf`.

---

## Neovim Configuration Details

### Entry Point

`nvim/init.lua` bootstraps Lazy.nvim (auto-installs if missing), then:
1. Loads `vim-bindings` (core options/keymaps)
2. Loads `lazy` with the `plugins` spec (auto-discovers `lua/plugins/*.lua`)

### Core Settings (`vim-bindings.lua`)

| Setting | Value |
|---|---|
| Indentation | 2 spaces (expandtab, tabstop=2, softtabstop=2, shiftwidth=2) |
| Line numbers | Absolute + relative |
| Leader key | `<Space>` |
| Clipboard | System clipboard (`unnamed`) |
| Scroll behavior | Cursor stays centered on Ctrl+U/D |
| Auto-comment | Disabled on new lines |

### Key Mappings

| Keybind | Action |
|---|---|
| `Ctrl+N` | Open Neo-tree file explorer |
| `Ctrl+P` | Telescope file finder |
| `<leader>fg` | Telescope live grep |
| `Ctrl+h/j/k/l` | Navigate between vim splits and tmux panes |
| `Ctrl+W =` | Increase vertical split width by 5 |
| `Ctrl+W -` | Decrease vertical split width by 5 |
| `Ctrl+U / Ctrl+D` | Half-page scroll (cursor centered) |
| `<leader>fm` | Format current file (none-ls / Prettier) |
| `<leader>1f` | Format visual selection |
| `Ctrl+G` | Accept Codeium AI suggestion |
| `<leader>t` | Run nearest test |
| `<leader>T` | Run all tests in file |
| `<leader>a` | Run full test suite |
| `<leader>l` | Rerun last test |
| `<leader>g` | Go to test file |

### Plugin Management

Plugins are managed by **Lazy.nvim**. Each plugin has its own file under `nvim/lua/plugins/`. To add a plugin:
1. Create a new file in `nvim/lua/plugins/`
2. Return a Lazy.nvim plugin spec table
3. Run `:Lazy sync` inside Neovim

The `lazy-lock.json` file pins exact plugin versions for reproducibility. **Do not edit it manually** — it is updated by Lazy.nvim automatically.

### Language Servers

Configured via Mason + mason-lspconfig in `lsp-config.lua`:
- `lua_ls` — Lua
- `ts_ls` — TypeScript/JavaScript

Install additional servers with `:MasonInstall <server-name>`.

### Formatting & Linting (`none-ls.lua`)

| Tool | Language | Mode |
|---|---|---|
| Prettier | JS/TS/CSS/HTML/etc. | Format (print-width: 120) |
| Stylua | Lua | Format |
| ESLint-d | JavaScript/TypeScript | Diagnostics |

> Note: Neovim overrides Prettier print-width to **120** characters, while the repo's `.prettierrc` defaults to **80**. Respect the per-project `.prettierrc` when editing JS/TS files outside Neovim.

---

## Code Style Conventions

### General (from `.prettierrc`)

- **Single quotes** for strings
- **Semicolons** required
- **Trailing commas** in ES5 positions (objects, arrays — not function parameters)
- **4-space tab width** (Prettier default; Neovim overrides to 2 for Lua)
- **80-character line width** (`.prettierrc`; Neovim's none-ls uses 120)
- **Auto** line endings (platform-agnostic)

### Lua (Neovim config files)

- Follow existing 2-space indentation
- Use `vim.keymap.set` for keymaps, not `vim.api.nvim_set_keymap`
- Use `vim.cmd(...)` for legacy Vimscript options where no Lua API exists
- Plugin spec files return a single table (or array of tables for multi-plugin files)
- Keep each plugin in its own file under `nvim/lua/plugins/`

### VS Code Settings

VS Code uses a 120-character ruler and integrates with the same `.prettierrc`. CloudFormation YAML custom tags are configured — relevant if working on AWS infrastructure.

---

## Tmux Configuration

| Setting | Value |
|---|---|
| Prefix | `Ctrl+S` |
| Pane navigation | Vim-style `hjkl` (after prefix) |
| Theme | Catppuccin |
| Status bar | Top |

Neovim and Tmux pane navigation are unified via `vim-tmux-navigator` — `Ctrl+hjkl` works seamlessly across both.

---

## What AI Assistants Should and Should Not Do

### Do

- **Follow existing conventions** — 2-space indentation for Lua, single quotes, existing plugin file structure.
- **Add plugins as separate files** under `nvim/lua/plugins/` — one plugin (or tightly related set) per file.
- **Use descriptive commit messages** following the style in git history: imperative mood, plain English, specific to the change (e.g., "Add telescope-file-browser plugin", "Update lualine theme to catppuccin").
- **Preserve lazy-lock.json** — do not edit it manually.
- **Test Neovim changes conceptually** — there is no automated test for dotfiles; verify by reasoning about the config.

### Do Not

- **Do not add a build system** — this repo has no build step and does not need one.
- **Do not add CI/CD** — dotfiles repos typically don't need automated pipelines unless the owner requests it.
- **Do not create application-style abstractions** — no need for shared utilities, factories, or DI patterns in config files.
- **Do not change `lazy-lock.json` versions** — version bumps happen through Neovim itself.
- **Do not modify `.prettierrc` globally** to match Neovim's 120-char override — the file intentionally uses 80 as the project default.

---

## Git Workflow

- **Main branch:** `master`
- **Remote:** `http://local_proxy@127.0.0.1:57335/git/sungly/configs`
- Commits are small and file-focused (e.g., one config file per commit)
- No PR workflow is established; direct commits to `master` appear to be the norm

When making changes as an AI assistant, use a feature branch (e.g., `claude/<task-id>`) and push with:

```bash
git push -u origin <branch-name>
```

---

## Tech Stack Summary

| Layer | Technology |
|---|---|
| Primary editor | Neovim (Lua config, Lazy.nvim plugins) |
| Secondary editor | VS Code |
| Terminal | Tmux + iTerm2 |
| Shell | Bash (NVM for Node.js, Ruby/Python paths) |
| AI completion | Codeium |
| LSP | lua_ls, ts_ls (via Mason) |
| Formatter | Prettier, Stylua |
| Linter | ESLint-d |
| Debugger | nvim-dap (Neovim), Node.js attach (VS Code) |
| Plugin manager | Lazy.nvim |
