
set encoding=utf-8
set nocompatible              " required
filetype off                  " required
let g:python3_host_prog=$HOME."/.pyenv/versions/neovim3/bin/python3"
let mapleader=","
call plug#begin('~/.vim/plugged')


set rtp+=~/.vim/my-colors
Plug 'morhetz/gruvbox'

" TmuxVimNavigation
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_disable_when_zoomed = 1
nnoremap <silent> <C-H> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-J> :TmuxNavigateDown<cr>
nnoremap <silent> <C-K> :TmuxNavigateUp<cr>
nnoremap <silent> <C-L> :TmuxNavigateRight<cr>


""" Editor
" Asynchronous Linting
Plug 'w0rp/ale'
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '!'
let g:ale_set_highlights = 1
let g:ale_lint_delay = 1000
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" Workspace
Plug 'thaerkh/vim-workspace'
nnoremap <Leader>ws :ToggleWorkspace<CR>
let g:workspace_session_name='workspace.vim'
let g:workspace_session_disable_on_args=1
let g:workspace_autosave_ignore = [
    \ 'gitcommit',
    \ '__flygrep__',
    \ 'netrw',
    \ 'nerdtree',
    \ 'tagbar' ]
" Indentation
Plug 'Yggdroot/indentLine'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_char_list = ['|']
" because I miss sublime text
Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=1
" for noobs like me who have no idea how to use motions
Plug 'easymotion/vim-easymotion'
" surround
Plug 'tpope/vim-surround'
" Neosnippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
let g:neosnippet#snippets_directory='~/.vim/neosnippets/'
imap <C-e> <Plug>(neosnippet_expand_or_jump)
smap <C-e> <Plug>(neosnippet_expand_or_jump)
xmap <C-e> <Plug>(neosnippet_expand_target)
" Tagbar
Plug 'majutsushi/tagbar'


""" AUTOCOMPLETE
" Deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1


""" Explorers
" fzfinder
Plug 'junegunn/fzf.vim' ", { 'on': ['FZF', 'Buffers', 'Marks'] }
set rtp+=~/.fzf
" let g:fzf_action = {
"     \ 'ctrl-t': 'tab split',
"     \ 'ctrl-i': 'split',
"     \ 'ctrl-s': 'vsplit' }
command! -bang -nargs=? -complete=dir FilesCustom call fzf#vim#files(<q-args>, {'options': "$FZF_DEFAULT_OPTS"}, <bang>0)

" nerdtree
Plug 'preservim/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind', 'NERDTreeFocus'] }
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swo$', '\.swp$', '\.DS_Store$', '__pycache__']
let NERDTreeShowHidden=1
let g:NERDTreeQuitOnOpen=0
let g:NERDTreeWinSize=35
let g:NERDTreeHighlightCursorLine=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 0
" Disable arrow icons at the left side of folders for NERDTree.
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"

" git icons
Plug 'Xuyuanp/nerdtree-git-plugin'
" devicons fun fun fun
Plug 'ryanoasis/vim-devicons'
let g:webdevicons_conceal_nerdtree_brackets=0
let g:WebDevIconsNerdTreeBeforeGlyphPadding=" "
let g:WebDevIconsNerdTreeAfterGlyphPadding="  "
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true


""" git
Plug 'airblade/vim-gitgutter'
let g:gitgutter_terminal_reports_focus=0
let g:gitgutter_max_signs=1000
" git wrapper for vim
Plug 'tpope/vim-fugitive'


""" status
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
let g:lightline = {
\   'separator': {'left': '', 'right': ''},
\   'subseparator': {'left': '', 'right': ''},
\   'tabline': {
\       'left': [['tabs']],
\       'right': [['buffers']]
\   },
\   'active': {
\       'left': [
\           [ 'mode', 'paste', ],
\           [ 'gitbranch' ],
\           [ 'readonly', 'filepath' ],
\           [ 'modified' ],
\           [ 'tagbar' ],
\       ],
\       'right': [
\           [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
\           [ 'percent', 'lineinfo' ],
\           [ 'filetype', ]
\       ]
\   },
\   'inactive': {
\       'left': [
\           [ 'filepath', 'modified' ]
\       ],
\       'right': [['']]
\   },
\   'component': {
\       'lineinfo': '%3l:%-2v',
\       'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
\   },
\   'component_function': {
\       'linter_checking': 'lightline#ale#checking',
\       'linter_warnings': 'lightline#ale#warnings',
\       'linter_errors': 'lightline#ale#errors',
\       'linter_ok': 'lightline#ale#ok',
\       'gitbranch': 'fugitive#head',
\       'filepath': 'LightlineFilepath',
\   }
\}

command! LightlineReload call LightlineReload()
function! LightlineReload()
  silent! call lightline#init()
  silent! call lightline#colorscheme()
  silent! call lightline#update()
endfunction

function! LightlineFilepath()
    let filename = expand('%f:h') !=# '' ? expand('%f:h') : '-'
    return filename
endfunction

let g:lightline.component_type = {
  \  'linter_checking': 'left',
  \  'linter_warnings': 'warning',
  \  'linter_errors': 'error',
  \  'linter_ok': 'left',
  \ }


""" Syntax Highlighting
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['vue', 'json']


""" Python
" python indentation for vim
Plug 'vim-scripts/indentpython.vim', {'for': 'python'}
" JEDI
Plug 'zchee/deoplete-jedi', {'for': 'python'}
Plug 'davidhalter/jedi', {'for': 'python'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
let g:jedi#completions_enabled = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#show_call_signatures = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:jedi#goto_command = "<leader>jc"
let g:jedi#goto_assignments_command = "<leader>ja"
let g:jedi#goto_definitions_command = "<leader>jd"
let g:jedi#documentation_command = "<leader>jl"
" beautifier
Plug 'psf/black', {'for': 'python'}


""" HTML & CSS
Plug 'mattn/emmet-vim', {'for': ['html', 'js', 'css', 'vue']}
" ternjs
Plug 'carlitux/deoplete-ternjs', {'for': ['html', 'js', 'css', 'vue']}
Plug 'ternjs/tern_for_vim', {'do': 'npm install -g tern', 'for': ['html', 'js', 'css', 'vue', 'json']}


""" Docker
Plug 'ekalinin/Dockerfile.vim'

call plug#end()
" =========================================================================== "

" --------------------------------------------------------------------------- "
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
    let buflist = GetBufferList()
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(bufnum) != -1
            exec(a:pfx.'close')
            return
        endif
    endfor
    if a:pfx == 'l' && len(getloclist(0)) == 0
        echohl ErrorMsg
        echo "Location List is Empty."
        return
    endif
    let winnr = winnr()
    exec(a:pfx.'open')
    if winnr() != winnr
        wincmd p
    endif
endfunction


" Beautifiers
autocmd FileType css noremap <buffer> <F6> :call CSSBeautify()<cr>
autocmd FileType html noremap <buffer> <F6>:call HtmlBeautify()<cr>
autocmd FileType javascript noremap <buffer> <F6>:call JsBeautify()<cr>
autocmd FileType vue noremap <buffer> <leader>jsb :call HtmlBeautify()<cr>
autocmd FileType json noremap <buffer> <F6>:call JsonBeautify()<cr>
autocmd FileType python noremap <buffer> <F6>:Black<cr>


" FZF
nnoremap <C-P> :Files<CR>
nnoremap <C-F> :Ag<CR>


" NerdTree
noremap <Leader>0 :NERDTreeFocus<CR>
noremap <Leader>- :NERDTreeFind<CR>
noremap <C-B> :NERDTreeToggle<CR>


" Folding and shit
nnoremap <space> za


" Vim-style tab navigation
nnoremap tj  :tabfirst<CR>
nnoremap tl  :tabnext<CR>
nnoremap th  :tabprev<CR>
nnoremap tk  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnew<CR>
nnoremap tm  :tabm<Space>
nnoremap tx  :tabclose<CR>
vnoremap <silent> <F5> :sort i<CR>
nnoremap <silent> <F5> :so $MYVIMRC<CR>:LightlineReload<CR>:call webdevicons#refresh()<CR>
nnoremap <F8> :set tabstop=4 shiftwidth=4 expandtab<CR>:retab!<CR>

nnoremap <Leader>lx :lclose<CR>
nnoremap <silent> <leader>ll :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>ee :call ToggleList("Quickfix List", 'c')<CR>
" =========================================================================== "


" LOOK & FEEL --------------------------------------------------------------- "
syntax on
set termguicolors
set background=dark
set t_Co=256
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
let g:gruvbox_italicize_comments=0
let g:gruvbox_italicize_strings=0
let g:gruvbox_improved_strings=0
let g:gruvbox_improved_warnings=0
let g:gruvbox_hls_cursor='orange'
silent! colorscheme gruvbox

" current line highlights
highlight CursorLine cterm=NONE ctermbg=black guibg=#151515
highlight CursorColumn cterm=NONE ctermbg=black guibg=#151515
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup end
set laststatus=2
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\

" netrw
let g:netrw_banner=1
let g:netrw_liststyle=3
let g:netrw_browse_split=0
let g:netrw_altv = 0
let g:netrw_winsize=20
" augroup ProjectDrawer
" 	autocmd!
" 	autocmd VimEnter * :Explore
" augroup END


" EDITOR -------------------------------------------------------------------- "
" definitions
set splitright
set splitbelow
set exrc             " allow project specific .vimrc
set secure           " disallow .vimrc not owned by uname
set clipboard=unnamed,unnamedplus
set regexpengine=1
set tabstop=4        " length of a tab
set shiftwidth=4     " length of an indent
set softtabstop=4     " length of an indent
set ruler
set autoindent
set number           " show line numbers
set nornu            " disabling relative numbers
set showmatch        " show matching paranthesis
set backspace=2      " normal editor backspacing
set timeoutlen=1000
set ttimeoutlen=2
set incsearch
set ignorecase       " ignore the case when searching
set smartcase        " case ignored if the search is all lower case
set undolevels=1000  " more undo levels
set scrolloff=7
set shortmess=a      " Decrease the message size
set cmdheight=1      " Change height of the cmd prompt
set redrawtime=20000 " Fixes syntax highlighting on large files
set noshowmode       " No showmode
set cursorline       " Show the cursorline
set mouse=a          " MOUSE MODE
set showtabline=2    " Show tabline
set guioptions-=e    " Don't use GUI tabline
let g:autoclose_on=1 " do not autoclose brackets

" Refresh Airline theme on entering a buffer
au! BufEnter *
    \ :LightlineReload

" show whitespaces
set listchars=tab:--,trail:·,nbsp:~,extends:>,precedes:<,eol:¬
set list
" =========================================================================== "


set directory=$HOME/.vim/swapfiles//
set backupdir=$HOME/.vim/backup//
set undodir=$HOME/.vim/undodir//
silent execute '!mkdir -p ~/.vim/swapfiles'
silent execute '!mkdir -p ~/.vim/backup'
silent execute '!mkdir -p ~/.vim/undodir'
set rtp+=~/.vim/after
let macvim_skip_colorscheme=1
silent! source ~/.vimrc-local
