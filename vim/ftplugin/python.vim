" " Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylint']
" " Disable warnings about trailing whitespace for Python files.
" let b:ale_warn_about_trailing_whitespace = 1

syntax on
set colorcolumn=80
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set foldmethod=syntax
set foldlevel=99
