call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'

Plug 'ervandew/supertab'
Plug 'sjl/gundo.vim'
Plug 'majutsushi/tagbar'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Quramy/vison'
Plug 'scrooloose/nerdcommenter'
Plug 'docunext/closetag.vim'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-easymotion'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-git'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'rgarver/Kwbd.vim'
Plug 'thinca/vim-fontzoom'
Plug 'vim-scripts/vcscommand.vim'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-smooth-scroll'
Plug 'dbakker/vim-projectroot'
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'othree/yajs.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'tpope/vim-markdown'
Plug 'vim-ruby/vim-ruby'

Plug 'Quramy/tsuquyomi'
Plug 'mattn/emmet-vim'

call plug#end()

" Required:
filetype plugin indent on

syntax on

set hlsearch " Highlight searches
set incsearch " Do incremental searching
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
set showcmd
"set cmdheight=5
"set scrolloff=10
set wildignore+=*.png,*.jpg,*.gif,*.ai,*.jpeg,*.psd,*.swp,*.jar,*.zip,*.gem,.DS_Store,log/**,tmp/**,coverage/**,rdoc/**,output_*,*.xpi,doc/**
set wildignore+=downloads,tmp,log,download,tags
set wildmode=longest,list:longest
set completeopt=menu,preview

set nobackup       " no backup files
set nowritebackup  " only in case you don't want a backup file while editing
set noswapfile     " no swap files
set background=dark
set number
set ignorecase
set smartcase

" to allow changed buffers to be in the background
set hidden

" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
set nocompatible
set nowrap

let g:airline_powerline_fonts=1

" disable async gitgutter, since it conflicts with
"let g:gitgutter_async = 0

" ack config
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" folding
augroup vimrc
  " fold by default by indendation, but allow manual folding as well
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
"set foldmethod=indent
"set foldmethod=syntax
set nofoldenable
set foldlevel=1

colorscheme solarized

" set leader key
let mapleader=" "

" syntastic config
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" typescript config
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
let g:syntastic_typescript_tsc_fname = ''
"let g:typescript_compiler_options='--target ES5 --emitDecoratorMetadata --experimentalDecorators'
"let g:syntastic_typescript_tsc_args='--target ES5 --emitDecoratorMetadata --experimentalDecorators'

if executable('ctags')
  let g:tagbar_type_coffee = {
    \ 'ctagsbin' : 'coffeetags',
    \ 'ctagsargs' : '',
    \ 'kinds' : [
      \ 'f:functions',
      \ 'o:object',
    \ ],
    \ 'sro' : ".",
    \ 'kind2scope' : {
      \ 'f' : 'object',
      \ 'o' : 'object',
    \ }
  \ }
endif

set mouse+=a
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif

" toggle color scheme
call togglebg#map("<leader>tc")

" toggle relative/absolute line numbers
nnoremap <leader>tl :call NumberToggle()<CR>

" jk triggers ESC in insert mode
inoremap jk <ESC>

" ctrl + h/l in insert mode
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" smooth scrolling
noremap <silent> <C-k> :call smooth_scroll#up(&scroll, 0, 3)<CR>
noremap <silent> <C-j> :call smooth_scroll#down(&scroll, 0, 3)<CR>

" trigger search
map <C-f> :Ag ""<Left>
map <leader>sp :call SearchProject()<CR>
map <leader>sd :call SearchDirectory()<CR>

" ctrl p for last used files
nnoremap <leader>fr :CtrlPMRUFiles<CR>
" ctrl p for buffers
nnoremap <leader>fb :CtrlPBuffer<CR>
" ctrl p mapping
nnoremap <leader>fl :CtrlP<CR>

" ctrlp config
let g:ctrlp_switch_buffer=0
let g:ctrlp_open_multi='vr'
let g:ctrlp_max_height=15
let g:ctrlp_match_window_bottom=0

" use ag or git for ctrlP
let g:ctrlp_use_caching = 0
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

" fugitive git bindings
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>
" same bindings for merging diffs as in normal mode
xnoremap <leader>dp :diffput<cr>
xnoremap <leader>do :diffget<cr>

" to cd to project root
nnoremap <leader>cd :ProjectRootCD<cr>

" open tagbar
map <leader>tb :TagbarToggle<CR>
" toggle line wrapping
map <leader>tw :set wrap!<cr>
" split window
nnoremap <leader>w <C-w>v<C-w>l

" cycle through panes (in addition to C-w...)
nnoremap <leader>wh <C-w>h
nnoremap <leader>wl <C-w>l
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k

" exit with ESC from terminal mode
tnoremap <Esc> <C-\><C-n>

" next quickfix
noremap <leader>n :cn<CR>zv

" remove unwanted whitespaces
"map <leader>cef :execute "%s/\\s\\+$//e"<CR>
autocmd BufWritePre * :execute "%s/\\s\\+$//e"

" close buffer
map <leader>x :Kwbd<CR>
" close all open buffers
map <leader>X :bufdo Kwbd<CR>
" close buffer and window
map <leader>q :bd<CR>

" VCSCommand related
let VCSCommandMapPrefix = "<leader>v"
map <leader>va :VCSAnnotate<CR>
map <leader>vl :VCSLog<CR>
map <leader>vj :call RepoLog()<CR>
map <leader>vd :call RepoDiff()<CR>
map <leader>vv :call RepoShow()<CR>
" toggle highlight search
nnoremap <silent><expr> <Leader>hs (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" toggle paste mode
map <leader>tp :set paste!<CR>

" to cycle through buffers and tabs
"nmap <silent> ;' :tabnext<CR>
"nmap <silent> ;l :tabprev<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>

" open netrw
map <silent> <C-n> :e.<CR>

"map <silent> <C-n> :Lexplore<CR>
" netrw config
" Hit enter in the file browser to open the selected
" file in previous buffer
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 20
" hide files/directories starting with a dot
let g:netrw_list_hide= '^\.'
" hide help header
"let g:netrw_banner=0

" Default to tree mode
"let g:netrw_liststyle=3

" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir='rm -r'

" Change directory to the current buffer when opening files.
set autochdir

function FindRev()
  " TODO try to fix this
  " execute "normal! ^/\\v([a-z0-9]+)((\\d)([a-z])[a-z0-9]+)\<CR>"
  return expand("<cword>")
endfunction

function RepoLog()
  let revision = FindRev()
  execute "VCSLog -r " . revision
endfunction

function RepoDiff()
  let revision = FindRev()
  execute "normal! ^/\\v([a-z0-9]+)((\\d)([a-z])[a-z0-9]+)\<CR>"
  " hash~1 is the git parent revision of hash
  execute "VCSDiff " . expand("<cword>") . "~1 " . expand("<cword>")
endfunction

function RepoShow()
  let revision = FindRev()
  execute "rightbelow new"
  execute "set buftype=nofile"
  execute "set bufhidden=hide"
  execute "setlocal noswapfile"
  " read 'git show #rev'
  execute "r !git show " . revision
  " jump to first line again..
  execute "1"
endfunction

function SearchProject()
  execute "ProjectRootCD"
  let search = input("Search Project: ")
  execute "Ack! ".search
endfunction

function SearchDirectory()
  execute "ProjectRootCD"
  let dir = input("Choose Directory: ", "", "file")
  let search = input("Search Directory: ")
  execute "Ack! ".search." ".dir
endfunction

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
