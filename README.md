# Neovim Configuration

Personal Neovim configuration built on [NvChad v2.5](https://github.com/NvChad/NvChad) with full support for Go, Rust, and TypeScript development.

## Prerequisites

Install these before cloning:

| Dependency | Purpose | Install |
|------------|---------|---------|
| **Neovim >= 0.11** | Editor | `brew install neovim` or [download](https://github.com/neovim/neovim/releases/latest) |
| **Git** | Plugin manager | `brew install git` |
| **Node.js >= 18** | LSPs (jsonls, yamlls, bashls, ts_ls) + prettier | `brew install node` |
| **Go >= 1.24** | LSP (gopls) + formatters (gofumpt, golines) + debugger (delve) | [go.dev/dl](https://go.dev/dl/) |
| **Rust toolchain** | rust-analyzer + rustfmt + codelldb debugger | `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \| sh` |
| **Nerd Font** | Icons | [nerdfonts.com](https://www.nerdfonts.com/) |
| **ripgrep** | Telescope live grep | `brew install ripgrep` |

## Install

```bash
# Back up existing config if needed
mv ~/.config/nvim ~/.config/nvim.bak

# Clone
git clone https://github.com/Dzonixy/NvChad ~/.config/nvim

# Launch — everything installs automatically on first run
nvim
```

First launch will auto-install:
- All plugins (via lazy.nvim)
- All LSP servers (via mason-lspconfig)
- All formatters (via mason-conform)
- All DAP adapters (via mason-nvim-dap)
- All treesitter parsers

## Language Support

| Language | LSP | Formatter | Debugger | Treesitter |
|----------|-----|-----------|----------|------------|
| **Go** | gopls | gofumpt, goimports-reviser, golines | delve | go, gomod, gosum, gotmpl, gowork |
| **Rust** | rust-analyzer (via rustup) | rustfmt | codelldb | rust |
| **TypeScript/JS** | ts_ls | prettier | js-debug-adapter (pwa-node, pwa-chrome) | typescript, javascript, tsx |
| **TOML** | taplo | taplo | - | toml |
| **JSON** | jsonls (with SchemaStore) | prettier | - | json, jsonc |
| **YAML** | yamlls (with SchemaStore) | prettier | - | yaml |
| **SQL** | sqls | sql_formatter | - | sql |
| **Bash** | bashls | shfmt | - | bash |
| **Lua** | lua_ls | stylua | - | lua, luadoc |
| **HTML/CSS** | html, cssls | prettier | - | html, css |
| **Markdown** | - | prettier | - | markdown, markdown_inline |

All formatters run on save with a 3000ms timeout. LSP formatting is used as fallback for JSON, YAML, and Rust.

## Structure

```
lua/
├── plugins/              # Plugin specs (one file per plugin/group)
│   ├── cmp.lua           # nvim-cmp + completion sources
│   ├── conform.lua       # Formatting
│   ├── copilot.lua       # Copilot + CopilotChat
│   ├── dap.lua           # Debug adapters (Go, Rust, JS/TS)
│   ├── lsp.lua           # LSP, Mason, linting
│   ├── misc.lua          # Fugitive, devicons
│   ├── neotest.lua       # Test runner (Go + Rust)
│   ├── rustaceanvim.lua  # Rust tooling
│   ├── telescope.lua     # Telescope + Trouble integration
│   ├── treesitter.lua    # Syntax highlighting
│   ├── trouble.lua       # Diagnostics/references viewer
│   ├── todo-comments.lua # TODO/FIXME/HACK highlighting
│   ├── crates.lua        # Cargo.toml crate management
│   ├── surround.lua      # Add/change/delete surroundings
│   ├── flash.lua         # Fast cursor movement
│   ├── ts-autotag.lua    # Auto close/rename HTML/JSX tags
│   ├── diffview.lua      # Git diff viewer
│   ├── harpoon.lua       # Quick file bookmarks
│   └── render-markdown.lua # Pretty markdown rendering
├── configs/              # Plugin configuration
│   ├── conform.lua       # Formatters by filetype
│   ├── copilot.lua       # Copilot settings
│   ├── copilot-chat.lua  # CopilotChat settings
│   ├── cmp.lua           # Completion settings
│   ├── dap.lua           # DAP adapter + debug configs
│   ├── dapui.lua         # DAP UI settings
│   ├── json-schemas.lua  # JSON schemas (package.json, tsconfig, etc.)
│   ├── lazy.lua          # lazy.nvim settings
│   ├── lspconfig.lua     # LSP server configurations
│   ├── mason-lspconfig.lua
│   ├── mason-lint.lua
│   ├── neotest.lua       # Test adapter settings
│   ├── rustaceanvim.lua  # rust-analyzer settings + keymaps
│   └── treesitter.lua    # Parser list
├── chadrc.lua            # NvChad theme + UI config
├── mappings.lua          # Custom keymaps
└── options.lua           # Neovim options
```

## Key Bindings

### General
| Key | Action |
|-----|--------|
| `<leader>` | Space |
| `;` | Enter command mode |
| `jk` | Escape (insert mode) |

### Diagnostics (Trouble)
| Key | Action |
|-----|--------|
| `<leader>tx` | Toggle all diagnostics |
| `<leader>tX` | Toggle buffer diagnostics |
| `<leader>td` | LSP definitions |
| `<leader>tr` | LSP references |
| `<leader>ti` | LSP implementations |
| `<leader>tt` | LSP type definitions |
| `<leader>cs` | Document symbols |
| `<leader>cl` | LSP defs/refs/impl (combined) |
| `<leader>tQ` | Quickfix list |
| `<leader>tL` | Location list |
| `]t` / `[t` | Next/prev Trouble item |

### Debugging (DAP)
| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dc` | Continue |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dO` | Step over |
| `<leader>dt` | Terminate |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Evaluate expression |

### Rust (`<leader>r` prefix)
| Key | Action |
|-----|--------|
| `<leader>rr` | Runnables |
| `<leader>rd` | Debuggables |
| `<leader>rt` | Testables |
| `<leader>re` | Expand macro |
| `<leader>rc` | Open Cargo.toml |
| `<leader>rp` | Parent module |
| `<leader>rf` | Run fly check |
| `<leader>rex` | Explain error |
| `<leader>rC` | Restart rust-analyzer |
| `K` | Hover actions (in Rust files) |

### Copilot
| Key | Action |
|-----|--------|
| `<leader>cb` | Open CopilotChat |
| `<leader>ce` | Explain code |
| `<leader>cf` | Fix code |

### Navigation
| Key | Action |
|-----|--------|
| `s` | Flash jump |
| `S` | Flash treesitter select |
| `<leader>ha` | Harpoon add file |
| `<leader>hh` | Harpoon menu |
| `<leader>1-4` | Harpoon file 1-4 |
| `<leader>hn` / `<leader>hp` | Harpoon next/prev |

### Git
| Key | Action |
|-----|--------|
| `<leader>gd` | Git diff (Diffview) |
| `<leader>gh` | File history |
| `<leader>gH` | Branch history |
| `<leader>gq` | Close Diffview |

### TODO Comments
| Key | Action |
|-----|--------|
| `<leader>tT` | TODOs in Trouble |
| `<leader>ft` | Find TODOs (Telescope) |
| `]T` / `[T` | Next/prev TODO |

### Crates (in Cargo.toml)
| Key | Action |
|-----|--------|
| `<leader>ci` | Crate info |
| `<leader>cv` | Crate versions |
| `<leader>cu` | Update all crates |
| `<leader>cU` | Update crate under cursor |

### Surround
| Key | Action |
|-----|--------|
| `ys{motion}{char}` | Add surrounding |
| `cs{old}{new}` | Change surrounding |
| `ds{char}` | Delete surrounding |

### Telescope
| Key | Action |
|-----|--------|
| `<c-t>` | Send results to Trouble |

## Theme

**tokyonight** with:
- Italic comments
- Atom-colored completion menu
- Bordered Telescope
- Minimal statusline with round separators
- NvDash startup screen

Toggle light/dark with `<leader>th`.

## Notes

- **Rust-analyzer** is sourced from `rustup` (not Mason) so it always matches your active toolchain
- **Format-on-save** is enabled globally via conform.nvim with LSP fallback
- **Cargo.toml** changes automatically trigger rust-analyzer workspace reload
- Treesitter parsers auto-install on first encounter with a new filetype

## Credits

- [NvChad](https://github.com/NvChad/NvChad) for the base framework
- [LazyVim starter](https://github.com/LazyVim/starter) for inspiration
