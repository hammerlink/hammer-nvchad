# Personal Neovim Configuration

My personal Neovim setup based on NvChad, customized for my development workflow.

## 👋 About

Hi! I'm Hendrik Hamerlinck ([@hammerlink](https://github.com/hammerlink)), and this is my personal Neovim configuration. It's built on top of NvChad with additional customizations and plugins to support my development needs.

## 🛠️ Features

- Built on [NvChad](https://github.com/NvChad/NvChad) as the base configuration
- Enhanced development workflow with:
  - [overseer.nvim](https://github.com/stevearc/overseer.nvim) for task management
  - [neotest](https://github.com/nvim-neotest/neotest) with [avant](https://github.com/avantgardnerio/avant) for testing
- Optimized for multiple languages:
  - TypeScript
  - Deno (with LSP support)
  - Rust
  - C/C++

## ⚡ Setup

This repository uses NvChad as a plugin. To use this configuration:

1. Clone this repository to your Neovim config directory
2. The main NvChad modules are imported via `require "nvchad.options"`, `require "nvchad.mappings"`, etc.

## 🙏 Credits

- [NvChad](https://github.com/NvChad/NvChad) - The awesome base configuration
- [NvChad Starter](https://github.com/NvChad/starter) - Configuration structure
- [LazyVim Starter](https://github.com/LazyVim/starter) - Original inspiration for the starter template structure
