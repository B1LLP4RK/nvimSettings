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

## Installing coc-snippets
Many coc-extensions contribute to snippets to [coc-snippets](https://github.com/neoclide/coc-snippets).
So coc-snippets should be installed to exploit the code snippets provided by other extensions.
coc-snippets require pynvim library. python from 3.12 blocks naive `pip install`. If that is the case, create a virtual environement.
```
python3 -m venv ~/.venv/nvim
```
Then activate the environment.
```
source ~/.venv/nvim/bin/activate
```
Install in that environment.
```
pip install pynvim
```
Add the following to the configuration(`.vimrc`, `init.vim`, or `init.lua` to designate vim/nvim which environment to use.
```
let g:python3_host_prog = expand('~/.venv/nvim/bin/python')
```

## Tips for coc-extensions
- `:CocList extensions` give list of extensions installed
- For java, install coc-java and add `"semanticTokens.enable": true,` to the configuration file which can be opened with `:CocConfig`



# Disclaimer
- Use extensions at your own risk, as they can have security issues
- Read through the setting to find what you can do with it
