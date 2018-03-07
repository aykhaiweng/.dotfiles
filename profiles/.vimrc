set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" editor
Plugin 'tmhedberg/SimpylFold'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'

" explorers
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'

Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

" git
Plugin 'airblade/vim-gitgutter'
Plugin 'jreybert/vimagit'

" status
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" ColorScheme
Plugin 'mhartington/oceanic-next'

" Python
Plugin 'davidhalter/jedi-vim'
Plugin 'lambdalisue/vim-pyenv'
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/indentpython.vim'
" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" global options
set encoding=utf-8
set nu
set splitright
set splitbelow
let g:autoclose_on = 0  " do not autoclose brackets
set exrc  " allow project specific .vimrc
set secure  " disallow .vimrc not owned by uname
set clipboard=unnamedplus


" CONTROLS ------------------------------------------------------------------ "
" mouse
set mouse=a

" key shortcuts for pane switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding with the spacebar
nnoremap <space> za

" copy and pasting like a boss for MAC
nnoremap <C-c> :.w !pbcopy<CR><CR>
vnoremap <C-c> :w !pbcopy<CR><CR>
nnoremap <C-v> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
inoremap <C-v> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>

" =========================================================================== "

" PLUGIN SETTINGS ----------------------------------------------------------- "
" syntastic
syntax on
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Enable folding
set foldmethod=indent
set foldlevel=99

" SimpylFold options
let g:SimpylFold_docstring_preview=1

" AutoComplete options
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" nerdtree
" ignore files
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swo$', '\.swp$', '\.DS_Store$'] 
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" ctrlp
" ignore misc files
set wildignore=*.db
" ignore vim files
set wildignore+=*.swp,*.swo,*.so
" ignore python files
set wildignore+=*.pyc
" ignore mac files
set wildignore+=*.DS_Store
" ignore folders
let g:ctrlp_custom_ignore={
	\ 'dir': '\v[\/]\.(git|hg|svn)$',
	\ }
" =========================================================================== "

" EDITOR -------------------------------------------------------------------- "
" definitions
highlight BadWhitespace ctermbg=red guibg=darkred

" Global
set tabstop=4
set softtabstop=4

" Python
au BufNewFile,BufRead *.py
    \ syntax enable
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=80
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
    \ let python_highlight_all=1
    \ syntax on
	\ set ruler

" Whitespace
" define BadWhitespace before using in a match
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" HTML, JS, CSS
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=4
    \ set shiftwidth=4
" =========================================================================== "

" LOOK & FEEL --------------------------------------------------------------- "
" statusline
set laststatus=2
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\

" colorscheme
if (has("termguicolors"))
  set termguicolors
endif
colorscheme OceanicNext
" =========================================================================== "
