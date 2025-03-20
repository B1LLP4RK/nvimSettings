augroup autopairs_force_unmap
  autocmd!
  autocmd BufEnter * silent! iunmap <buffer> <M-]>
  autocmd BufEnter * silent! iunmap <buffer> <M-[>
  autocmd BufEnter * silent! iunmap <buffer> <M-\>
augroup END

" put this inside .config/nvim/after/plugin/autopairs-unmap.vim
" this is to unmap M-] from auto-pairs and so on to use it for copilot.
" It has to be in the after directory, because plugins take effect after init.vim
