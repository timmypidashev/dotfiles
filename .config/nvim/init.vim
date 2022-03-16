set tabstop=4                     " The width of a TAB is set to 4.
set shiftwidth=4                  " Indents will have a width of 4.
set softtabstop=4                 " Sets the number of columns for a TAB.
set expandtab                     " Expand TABs to spaces.
set mouse=a                       " Enable mouse support 
set number                        " Show line numbers.
set clipboard=unnamedplus         " Use system clipboard.
set ignorecase                    " Case insensitive search.
set laststatus=1                  " Show status line.

" paste bind
map <C-V> "+gP

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
    Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'} " coc
    Plug 'https://github.com/wakatime/vim-wakatime' " wakatime
    Plug 'https://github.com/morhetz/gruvbox' " gruvbox
    Plug 'https://github.com/vimwiki/vimwiki' " vimwiki
    Plug 'https://github.com/junegunn/goyo.vim' " goyo
    Plug 'https://github.com/mhinz/vim-startify' " startify
    Plug 'https://github.com/tpope/vim-fugitive' " fugitive
    Plug 'https://github.com/michal-h21/vimwiki-sync' " vimwiki-sync
        Plug 'https://github.com/preservim/nerdtree' " nerdtree
call plug#end()

" Set colorscheme
colorscheme gruvbox
hi Normal ctermbg=none

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Neovide configuration
let g:neovide_fullscreen=v:true
let g:neovide_cursor_antialiasing=v:true

" startify configuration
let g:startify_custom_header =
    \ startify#pad(split(system('figlet -w 80 NeoVim'), '\n'))

let g:startify_lists = [
    \ { 'type': 'bookmarks', 'header': ['    Bookmarks']    },
    \ { 'type': 'files',     'header': ['    MRU']          },
    \ ]

let g:startify_bookmarks = [ {'c': '~/.config/nvim/init.vim'}, {'w': '~/.vimwiki/index.wiki'} ]

" vimwiki-sync configuration
let g:vimwiki_list = [{'path':'$HOME/.vimwiki'}]
let g:vimwiki_sync_branch = "main"
let g:vimwiki_sync_commit_message = '%c'

" nerdtree configuration
nnoremap <C-n> :NERDTreeFocus<CR>

" Remove help info from nertree
let NERDTreeMinimalUI=1

" Set to current dir
let NERDTreeChDirMode=2

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

