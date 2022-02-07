set tabstop=4                     " The width of a TAB is set to 4.
set shiftwidth=4                  " Indents will have a width of 4.
set softtabstop=4                 " Sets the number of columns for a TAB.
set expandtab                     " Expand TABs to spaces.
set mouse=a                       " Enable mouse support.
set number                        " Show line numbers.
set clipboard=unnamedplus         " Use system clipboard.
set ignorecase                    " Case insensitive search.
set showmatch                     " Highlight matching brackets.
set laststatus=1                  " Show status line.

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
    Plug 'https://github.com/andweeb/presence.nvim' " discord rich presense
    Plug 'https://github.com/github/copilot.vim' " github copilot
call plug#end()
