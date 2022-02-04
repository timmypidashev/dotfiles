" ---------------
" NeoVim Defaults
" ---------------
" Spaces and Tabs
set tabstop=4                   " number of visual spaces per TAB
set softtabstop=4               " number of spaces in tab when editing
set shiftwidth=4                " number of spaces to use for autoindent
set expandtab                   " tabs are space
set autoindent                  " automatically indent
set copyindent                  " preserve indents when pasting

" Clipboard
set clipboard+=unnamedplus      " Enable global clipboard for vim

" edit/reload vimrc
nnoremap <silent> <C-r> :source $MYVIMRC<cr>

" numberline
set number

" map CTRL-s to saving changes
nnoremap <C-S> :update<cr>

" ---------------
"  Vim-Plug Config
" ---------------
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Plugins
call plug#begin()
    Plug 'https://github.com/wakatime/vim-wakatime' " wakatime plugin
    Plug 'https://github.com/projekt0n/github-nvim-theme' " github colortheme
call plug#end()

" ---------------
" github colortheme
" ---------------
" Change the "hint" color to the "orange" color, and make the "error" color bright red
let g:github_colors = {
  \ 'hint': 'orange',
  \ 'error': '#ff0000'
\ }

let g:github_dark_sidebar = 0
" Load the colorscheme
colorscheme github_dark_default
