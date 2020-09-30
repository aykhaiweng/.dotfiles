" " Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylint']
" " Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 1

setlocal colorcolumn=100
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal foldlevel=99
setlocal foldmethod=indent

" Removing trailing whitespaces
autocmd BufWritePre * %s/\s\+$//e

call deoplete#custom#option({
    \ 'auto_complete_delay': 100,
    \ 'smart_case': v:true,
    \ 'auto_refresh_delay': 200,
    \ })
call deoplete#custom#source('_',
    \'disabled_syntaxes', ['Comment']
    \)
