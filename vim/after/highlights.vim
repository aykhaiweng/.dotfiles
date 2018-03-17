" LOOK & FEEL --------------------------------------------------------------- "
" ColorScheme
if (has("termguicolors"))
    set termguicolors
endif
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax enable
set background=dark
set t_Co=256
colorscheme OceanicNext
" some modifications to OceanicNex:

" statusline
set laststatus=2
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\

" current line highlights
" highlight CursorLine cterm=None ctermbg=234 guibg=#000000
" highlight CursorColumn cterm=None ctermbg=235 guibg=#000000
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup end

" highlights
" v this is commented out because it is now handled by better-whitespace
" highlight BadWhitespace ctermbg=red guibg=darkred
" match BadWhitespace /\s\+$/
" highlight Comment ctermfg=245
" highlight NonText ctermfg=238
" highlight SpecialKey ctermfg=238
highlight ExtraWhitespace ctermbg=red


" EDITOR -------------------------------------------------------------------- "
" definitions
set splitright
set splitbelow
let g:autoclose_on = 0  " do not autoclose brackets
set exrc  " allow project specific .vimrc
set secure  " disallow .vimrc not owned by uname
set clipboard=unnamed
set tabstop=4       " length of a tab
set shiftwidth=4    " length of an indent
set ruler
set autoindent
set encoding=utf-8
set number           " show line numbers
set nornu            " disabling relative numbers
set showmatch        " show matching paranthesis
set backspace=2      " normal editor backspacing
set timeoutlen=1000
set ttimeoutlen=2
set incsearch
set ignorecase       " ignore the case when searching
set smartcase        " case ignored if the search is all lower case
set lazyredraw
set undolevels=1000  " more undo levels
set ttyfast
set so=10

" Python
au BufNewFile,BufRead *.py
    \ syntax on
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set expandtab
    \ set colorcolumn=80
    \ set syntax=python
    \ let python_highlight_all=1
    \ let g:syntastic_python_checkers = ['flake8']

" HTML, JS, CSS
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=4
    \ set shiftwidth=4
    \ set noexpandtab

au BufNewFile,BufRead Vagrant
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
    \ set expandtab
    \ set syntax=ruby

" show whitespaces
set listchars=tab:--,trail:·,nbsp:~,extends:>,precedes:<,eol:¬
set list

" autocmds
" call Flake8 everytime the BufWritePost is called
" au BufReadPost,BufWritePost,InsertLeave *.py call Flake8()
" call GitGutter everytime the cursor is idling
" au CursorHold,CursorHoldI * GitGutter

" =========================================================================== "
