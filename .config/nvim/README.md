# Neovim Configuration

Full-featured Neovim setup with LSP, DAP, Treesitter, formatting, linting, and git integration.

## Requirements

### Nerd Font

A [Nerd Font](https://www.nerdfonts.com/) must be installed and set as the terminal font.

## System Dependencies

These tools are **not managed by Mason** and must be installed at the OS level before opening Neovim.

### macOS

```bash
# Install Homebrew first: https://brew.sh
brew install wget neovim git node python3 go lazygit ripgrep fd tree-sitter-cli rust composer php mermaid-cli

# C compiler + make (required by Treesitter and LuaSnip)
xcode-select --install
```

### Arch Linux

```bash
sudo pacman -S wget neovim git nodejs npm python go lazygit ripgrep fd base-devel tree-sitter-cli rust composer php mermaid-cli
```

#### Clipboard

`clipboard = 'unnamedplus'` requires a clipboard provider. Install one based on your session type:

```bash
# Wayland (recommended):
sudo pacman -S wl-clipboard

# X11:
sudo pacman -S xsel
```

macOS uses `pbcopy`/`pbpaste` natively — no extra package needed.

## TypeScript / Node.js Debugging

The `tsx` runtime executor is used for TypeScript Node.js debugging. Install it globally via npm:

```bash
npm install -g tsx
```

Without `tsx`, the "Launch file (tsx)" debug configuration will not be available. The other Node.js debug configurations (native strip-types and attach) work without it.

## First Launch

1. Open Neovim — `lazy.nvim` bootstraps itself and installs all plugins automatically.
2. Wait for Mason to finish installing LSP servers and tools.
3. Run `:checkhealth` to verify the setup.
4. Run `:TSUpdate` to compile all Treesitter parsers.
