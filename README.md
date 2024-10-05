# What is it?
The setting file for [vim](https://www.vim.org/) or [neovim](https://neovim.io/) which gives file explorer, code completion, color scheme, etc of my preference.

# How to use
1. `git clone https://github.com/B1LLP4RK/nvimSettings.git`
2. Install [vim-plug](https://github.com/junegunn/vim-plug) as in the installation section.
3. Install nodejs >= 16.18.0, which is the requirement of [coc](https://github.com/neoclide/coc.nvim)
4. For vim, copy the file to `~/.vimrc`. For neovim, copy the file to `~/.config/nvim/init.vim`
5. Open vim/neovim, and run `:PlugInstall` to install the vim extensions.
6. Install [coc-extension](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions) of your choice for static analysis
- run `:CocInstall coc-java`

# Disclaimer
- Use extensions at your own risk, as they can have security issues
- Read through the setting to find what you can do with it
