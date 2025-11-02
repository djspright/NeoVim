# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on LazyVim, customized for 42 School development (primarily C/C++) with additional support for Rust. The configuration uses lazy.nvim as the plugin manager and includes specialized 42 School tools.

## Architecture

### Plugin System
- **Plugin Manager**: lazy.nvim (bootstrapped in `lua/config/lazy.lua`)
- **Plugin Loading**: All plugins are defined in `lua/plugins/*.lua` files
- **LazyVim Integration**: Inherits LazyVim defaults and extends with custom plugins

### Configuration Structure
- `init.lua` - Main entry point, loads config modules and sets global options
- `lua/config/` - Core configuration (lazy.nvim setup, options, keymaps, autocmds)
- `lua/plugins/` - Individual plugin configurations (each file returns a plugin spec)
- `lua/user/` - User-specific options

### 42 School Specific Features
This configuration includes specialized tooling for 42 School development:

1. **42 Header** (`lua/plugins/42header.lua`)
   - Plugin: Diogo-ss/42-header.nvim
   - Trigger: F1 key or `:Stdheader` command
   - User: shkondo@student.42tokyo.jp

2. **42 C Formatter** (`lua/plugins/42formatter.lua`)
   - Plugin: Diogo-ss/42-C-Formatter.nvim
   - Auto-formats C/C++ files on save (configured in `init.lua:65-86`)
   - Manual formatting: F2 key or `:CFormat42` command
   - Applies to: *.c, *.h, *.cpp, *.hpp files

3. **Important**: LazyVim's global autoformat is DISABLED (`vim.g.autoformat = false` in `init.lua:91`)
   - Only 42 formatter runs on save for C/C++ files
   - LSP auto-formatting is commented out in `lua/plugins/lsp.lua:15-28`

### LSP Configuration
- Mason and mason-lspconfig handle LSP server installation
- Custom LSP attach autocmd in `lua/plugins/lsp.lua:2-30`
- Completion triggered on ALL printable ASCII characters (aggressive completion)
- Key LSP mappings in `lua/plugins/lsp.lua:47-62`:
  - `<C-space>`: Manual completion trigger (insert mode)
  - `gh`: Hover documentation
  - `gd`: Go to definition
  - `gD`: Go to declaration
  - Default LazyVim mappings: grn (rename), grr (references), gra (code action), gri (implementation), gO (document symbols)

### Build System
- **CMake Tools** (`lua/plugins/build.lua`)
  - Plugin: Civitasv/cmake-tools.nvim
  - Build directory: `build/`
  - Generates compile_commands.json for better LSP integration
  - Debug configuration for lldb (looks for `build/hello_world` executable)

### Navigation & UI
- **Telescope** (`lua/plugins/telescope.lua`)
  - Leader key mappings under `<leader>f`:
    - `<leader>ff`: Find files
    - `<leader>fg`: Live grep
    - `<leader>fb`: Buffers
    - `<leader>fr`: Recent files
    - `<leader>fd`: Diagnostics
    - `<leader>ft`: Type definitions
    - `<leader>fi`: Implementations
  - fzf-native extension for faster fuzzy finding

- **Buffer Navigation** (`lua/config/keymaps.lua`)
  - Tab: Next buffer
  - Shift+Tab: Previous buffer
  - `<leader>q`: Close buffer

- **ToggleTerm** (`lua/plugins/toggleterm.lua`)
  - Default shell: /usr/bin/fish
  - Toggle: `<leader>t`
  - Exit to normal mode: `<C-o>` (from terminal mode)
  - Direction: horizontal, size 20

### Custom Options
- `virtualedit = "onemore"` - Allow cursor one character past line end
- `clipboard = "unnamedplus"` - System clipboard integration
- Terminal transparency enabled for ToggleTerm and Telescope (autocmds in `init.lua:40-60`)

## Common Keybindings

### Insert Mode
- `jj` - Exit insert mode
- `<C-h/j/k/l>` - Move cursor left/down/up/right
- `<C-space>` - Trigger LSP completion

### Normal Mode
- `<Tab>` / `<S-Tab>` - Navigate buffers
- `<leader>q` - Close buffer
- `<leader>t` - Toggle terminal
- `F1` - Insert 42 header
- `F2` - Format with 42 formatter (C/C++ files)

### Terminal Mode
- `<C-o>` - Exit to normal mode

### LSP
- `gh` - Hover
- `gd` - Definition
- `gD` - Declaration
- `grn` - Rename
- `grr` - References
- `gra` - Code action

## Development Workflow

### Working with C/C++ (42 Projects)
1. Files auto-format on save using c_formatter_42
2. Use F1 to add 42 headers to new files
3. CMake projects: Build directory is `build/`, compile_commands.json auto-generated
4. Manual formatting available via F2

### Plugin Management
- Install plugins: Add to `lua/plugins/` directory (each file returns plugin spec)
- Update plugins: `:Lazy update`
- Plugin checker runs automatically but notifications disabled

### LSP Servers
- Manage via Mason: `:Mason`
- LSP servers auto-start on relevant file types
- Completion is aggressive (triggers on all printable characters)

## Important Notes

- Do NOT enable LazyVim's global autoformat - it conflicts with 42 formatter
- When modifying LSP auto-formatting behavior, edit the autocmd in `lua/plugins/lsp.lua:15-28`
- Custom clipboard configurations for pbcopy (macOS) and win32yank (WSL) are commented out in `init.lua`
- Some vim default plugins are disabled in `lua/config/lazy.lua:40-50` for performance
