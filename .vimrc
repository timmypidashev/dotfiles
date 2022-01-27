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
Plug 'dense-analysis/ale' "ale
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
" define gutter error sign
let g:ale_sign_error = '●'

" define gutter warning sign
let g:ale_sign_warning = '!'

" map Ctrl-e to ale_next_wrap(jump to next error)
nmap <silent> <C-e> <Plug>(ale_next_wrap)

" lint on save
let g:ale_lint_on_save = 1

" add linter to status line
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
set statusline+=%=
set statusline+=\ %{LinterStatus()}

