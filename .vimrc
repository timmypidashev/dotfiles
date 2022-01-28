" vim plug
" ------------------
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Plugins that are called to install
call plug#begin()
Plug 'wakatime/vim-wakatime' " wakatime plugin
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fzf 
Plug 'jremmen/vim-ripgrep' " ripgrep plugin
Plug 'airblade/vim-gitgutter' " gitgutter
Plug 'dense-analysis/ale' " ale
Plug 'vim-airline/vim-airline' " airline
Plug 'vim-airline/vim-airline-themes' " airline themes
Plug 'powerline/fonts' " powerline fonts for airline
Plug 'mhinz/vim-startify' " startify
call plug#end()

" Vim defaults
" -------------------
" line numbers
set number

" syntax highlighting
syntax on

" tabs set to 4 spaces
set tabstop=4

" automatically indent
set autoindent

" ensure tabs are consistent throughout all configurations
" (incase wierd people with 5 space tabs use this lol)
set expandtab

" make sure backspacing tabs is also consistent
" and doesnt just get rid of 1 space
set softtabstop=4

" Remove default vim bar
set noshowmode

" fzf(fuzzy finder) TODO: Polish fzf!
" ----------------------
" Map FZF default to CTRL-f
nnoremap <silent> <C-f> :FZF<CR>

let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }

" gitgutter(git diff column)
" ----------------------
"  Activate gitgutter automatically
autocmd VimEnter * GitGutterEnable

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" set the highlight backgournd to match the colorscheme
highlight! link SignColumn LineNr
set background=dark

" Disable gitgutter column highlight
autocmd VimEnter * GitGutterLineHighlightsDisable

" Ensure gitgutter always displays
let g:gitgutter_max_signs = -1

" ale(asynchronous lint engine) 
" ----------------------
" TODO: Configure ale!

" airline
" ----------------------
" remove default symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" change font type to convert symbols 
" below to powerline version
let g:airline_powerline_fonts=1

" add powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

" add tabline to top of screen
let g:airline#extensions#tabline#enabled = 1
