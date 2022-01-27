" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" vim plugins
call plug#begin()
Plug 'wakatime/vim-wakatime' " wakatime plugin
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fzf 
Plug 'jremmen/vim-ripgrep' " ripgrep plugin
Plug 'airblade/vim-gitgutter' " gitgutter
call plug#end()

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

" cursor line if i begine liking it
" (uncomment line below to enable)
" set cursorline

" Editor plugin binds, commands, and configurations
" ----------------------

" fzz(fuzzy finder)
" ----------------------
" Map FZF default to CTRL-f
nnoremap <silent> <C-f> :FZF<CR>

" ripgrep(grep commands)
" ----------------------
" tell vim to use ripgrep instead of default vimgrep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" Do not show file names in grep search
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Map RG default to f
nnoremap <silent> <Leader>f :Rg<CR>

" gitgutter(git diff column)
" ----------------------
"autocmd VimEnter * highlight! clear SignColumn
" autocmd ColorScheme * highlight! link SignColumn LineNr
"  Activate gitgutter automatically
autocmd VimEnter * GitGutterEnable
autocmd ColorScheme * highlight! link SignColumn LineNr

" remove grey background

" Disable gitgutter column highlight
" autocmd VimeEnter * GitGutterLineHighlightsDisable

" Ensure gitgutter always displays
let g:gitgutter_max_signs = -1

