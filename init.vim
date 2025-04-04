" General settings
" important settings
set gdefault
set mouse=a
set splitright
set splitbelow
set expandtab
set tabstop=4
set shiftwidth=4
set number
set relativenumber
set ignorecase
set smartcase
set incsearch
set diffopt+=vertical
set shortmess+=c
let mapleader = " "
nnoremap <leader>v :e $MYVIMRC<CR>
nnoremap <leader>cco :CopilotChatOpen<CR>

" Normal mode mappings
nnoremap <leader>cce :CopilotChatExplain<CR>
nnoremap <leader>ccr :CopilotChatReview<CR>
nnoremap <leader>ccf :CopilotChatFix<CR>
nnoremap <leader>ccO :CopilotChatOptimize<CR>
nnoremap <leader>ccd :CopilotChatDocs<CR>
nnoremap <leader>cct :CopilotChatTests<CR>
nnoremap <leader>ccc :CopilotChatCommit<CR>

" Visual mode mappings (same prompts, but preserve selection)
vnoremap <leader>cce :CopilotChatExplain<CR>
vnoremap <leader>ccr :CopilotChatReview<CR>
vnoremap <leader>ccf :CopilotChatFix<CR>
vnoremap <leader>ccO :CopilotChatOptimize<CR>
vnoremap <leader>ccd :CopilotChatDocs<CR>
vnoremap <leader>cct :CopilotChatTests<CR>
vnoremap <leader>ccc :CopilotChatCommit<CR>
nnoremap <leader>ccp :CopilotChatPrompts<CR>
vnoremap <leader>ccp :CopilotChatPrompts<CR>

" less important settings
set completeopt=menuone,noinsert,noselect
if (has("termguicolors"))
  set termguicolors
endif
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript']

" Start of plugins
call plug#begin()
" tier 1 essential, most used plugins
Plug 'itchyny/lightline.vim'
Plug 'szw/vim-maximizer'
Plug 'kdheepak/lazygit.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'
" requires nerdfont
Plug 'MeanderingProgrammer/render-markdown.nvim'
" use 'gc' operator to comment a line
Plug 'tpope/vim-commentary'
" shows lines changed since commit
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
" do CocInstall coc-java coc-javascript
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'tomasiser/vim-code-dark'
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'
" requires to download formatter seeparately. it should be available in the
" path
Plug 'vim-autoformat/vim-autoformat'

" tier 2, seems-good plugins
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-test/vim-test'
Plug 'github/copilot.vim'
Plug 'tpope/vim-fugitive'
Plug 'honza/vim-snippets'

" tier 3, plugins that I want to try
" Plug 'tpope/vim-dadbod'
" Plug 'kassio/neoterm'
" Plug 'sbdchd/neoformat'
" Plug 'pangloss/vim-javascript'
" Plug 'itchyny/vim-gitbranch'
" Plug 'christoomey/vim-tmux-navigator'
" Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }
" Plugin outside ~/.vim/plugged with post-update hook
call plug#end()

lua << EOF
require("CopilotChat").setup {
  -- See Configuration section for options
}
-- Quick chat keybinding
vim.keymap.set('n', '<leader>ccq', function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, {
      selection = require("CopilotChat.select").buffer
    })
  end
end, { desc = "CopilotChat - Quick chat" })

require("CopilotChat").setup({
  window = {
    layout = 'float',
    relative = 'cursor',
    width = 1,
    height = 0.4,
    row = 1
  }
})
-- Register copilot-chat filetype
require('render-markdown').setup({
  file_types = { 'markdown', 'copilot-chat' },
})

-- Adjust chat display settings
require('CopilotChat').setup({
  highlight_headers = false,
  separator = '---',
  error_header = '> [!ERROR] Error',
})
EOF

" settings for plugins

" lightline configuration
let g:lightline = {
      \ 'colorscheme': 'codedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

colorscheme codedark

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"szw/vim-maximizer
nnoremap <leader>m :MaximizerToggle!<CR>


"kassio/neoterm
" let g:neoterm_default_mod = 'vertical'
" let g:neoterm_size = 60
" let g:neoterm_autoinsert = 1
" nnoremap <c-q> :Ttoggle<CR>
" inoremap <c-q> <Esc>:Ttoggle<CR>
" tnoremap <c-q> <c-\><c-n>:Ttoggle<CR>

" sbdchd/neoformat
" nnoremap <leader>F : Neoformat prettier<CR>
" tnoremap <c-n> <c-\><c-n>


" junegunn/fzf.vim
nnoremap <leader><space> :GFiles<CR>
nnoremap <leader>ff :Rg<CR>
inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
      \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
      \ fzf#wrap({'dir': expand('%:p:h')}))
" if has('nvim')
"   au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
"   au! FileType fzf tunmap <buffer> <Esc>
" endif

" tpope/vim-fugitive
nnoremap <leader>gg :G<cr>

" setup mapping to call :LazyGit
nnoremap <silent> <leader>lg :LazyGit<CR>

" From COC readme page until line 255 
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  " nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')



" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>la  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>le  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>lc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>lo  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>ls  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>lj  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>lk  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>lp  :<C-u>CocListResume<CR>


"vim-test
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
" make test commands execute using dispatch.vim
let test#strategy = "neovim"
" for neovim
let test#neovim#term_position = "vert"


" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <A-m> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <silent><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : ":NERDTreeFind<CR>"

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" from :help terminal
" To map <Esc> to exit terminal-mode: >vim
" this mapping blocks switching to normal mode for a nvim inside terminal of
" nvim. 
" tnoremap <Esc> <C-\><C-n>

" To simulate |i_CTRL-R| in terminal-mode: >vim
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" To use `ALT+{h,j,k,l}` to navigate windows from any mode: >vim
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l

tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

autocmd FileType help nnoremap <buffer> <C-h> <C-w>h
autocmd FileType help nnoremap <buffer> <C-j> <C-w>j
autocmd FileType help nnoremap <buffer> <C-k> <C-w>k
autocmd FileType help nnoremap <buffer> <C-l> <C-w>l
autocmd FileType nerdtree nnoremap <buffer> <C-h> <C-w>h
autocmd FileType nerdtree nnoremap <buffer> <C-j> <C-w>j
autocmd FileType nerdtree nnoremap <buffer> <C-k> <C-w>k
autocmd FileType nerdtree nnoremap <buffer> <C-l> <C-w>l

" System Shortcuts for auto-pairs
"     <CR>  : Insert new indented line after return if cursor in blank brackets or quotes.
"     <BS>  : Delete brackets in pair
"     <M-p> : Toggle Autopairs (g:AutoPairsShortcutToggle)
"     <M-e> : Fast Wrap (g:AutoPairsShortcutFastWrap)
"     <M-n> : Jump to next closed pair (g:AutoPairsShortcutJump)
"     <M-b> : BackInsert (g:AutoPairsShortcutBackInsert)

" If <M-p> <M-e> or <M-n> conflict with another keys or want to bind to another keys, add

"     let g:AutoPairsShortcutToggle = '<another key>'

" to .vimrc, if the key is empty string '', then the shortcut will be disabled.

" pointer to the python environment for neovim tha has pynvim library
let g:python3_host_prog = expand('~/.venv/nvim/bin/python')

" coc-snippets commands
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
let g:python3_host_prog = expand('~/.venv/nvim/bin/python')

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')



" Set Vim options (can be done in Vimscript)
set foldcolumn=1
set foldlevel=99
set foldlevelstart=99
set foldenable

" Key mappings (Vimscript calls Lua functions)
nnoremap zR :lua require('ufo').openAllFolds()<CR>
nnoremap zM :lua require('ufo').closeAllFolds()<CR>


" Execute Lua setup
lua << EOF
require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'lsp', 'indent'}
    end
})
EOF

noremap <F4> :Autoformat<CR>

" disable copilot initially
"
nnoremap <leader>ghe :Copilot enable<CR>
nnoremap <leader>ghd :Copilot disable<CR>
let g:copilot_enabled = 0

imap <M-]> <Plug>(copilot-next)
imap <M-[> <Plug>(copilot-previous)
imap <M-\> <Plug>(copilot-suggest)

" coc-prettier 
" below line adds command :Prettier to format code

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" OS dependent setup
" c-v is occupied by paste in windows terminal, so use leader+b for paste
nnoremap <leader>b <c-v>
" suggested setup for wsl clipboard
"
let g:clipboard = {
      \   'name': 'WslClipboard',
      \   'copy': {
      \      '+': 'clip.exe',
      \      '*': 'clip.exe',
      \    },
      \   'paste': {
      \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      \   },
      \   'cache_enabled': 0,
      \ }

" To ALWAYS use the clipboard for ALL operations (instead of interacting with
" the \"+" and/or \"*" registers explicitly): >vim
    set clipboard+=unnamedplus
