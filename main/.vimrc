" vim-plug configuration
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

if has('gui_running')
  set guifont=Hack:h14
endif

Plug 'ajh17/VimCompletesMe'
Plug 'tpope/vim-obsession'
Plug 'airblade/vim-gitgutter'
Plug 'jpalardy/vim-slime'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'Chiel92/vim-autoformat'
Plug 'qpkorr/vim-bufkill'
Plug 'vim-airline/vim-airline-themes'
Plug 'mileszs/ack.vim'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-repeat'
Plug 'luochen1990/rainbow'
Plug 'ludovicchabant/vim-gutentags'

" extended % matching for HTML, LaTeX, and many other languages
Plug 'vim-scripts/matchit.zip'

" language support
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'gabrielelana/vim-markdown'
Plug 'lervag/vimtex'
Plug 'jalvesaq/Nvim-R'
Plug 'klmr/vim-snakemake'

" linter support
Plug 'w0rp/ale'

" colorschemes
Plug 'gregsexton/Atom'
Plug 'altercation/vim-colors-solarized'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

Plug 'KabbAmine/yowish.vim'
Plug 'whatyouhide/vim-gotham'
Plug 'romainl/Apprentice'
Plug 'joshdick/onedark.vim'
Plug 'nightsense/carbonized'
Plug 'toupeira/vim-desertink'

" requires installation via homebrew
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

syntax on

set nobackup
set noswapfile

" Hide buffers instead of closing them
set hidden

set nocompatible

" turn on line numbers
set number
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

set wrap
set textwidth=90
set colorcolumn=90
set formatoptions=qrn1
" show cursor position at all the time
set ruler

" Attempt to determine the type of a file based on its name and possibly its
" contents.  Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Turn on omnicomplete in all modes
set omnifunc=syntaxcomplete#Complete

" command line completion
set wildmenu
set wildmode=longest:full,full
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o

" add a '$' to the end of a change motion
set cpoptions+=$

set backspace=indent,eol,start
set autoread

" Disable automatic folding
set nofoldenable

" set tabsize to 2 spaces
set autoindent
set copyindent " copy the previous line's indentation
set smartindent

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop

" turn on highlighting during search
set hlsearch
set incsearch ignorecase smartcase

" Color scheme
" colorscheme slate
" colorscheme torte
" colorscheme kellys
" colorscheme lettuce
" colorscheme inkpot
" colorscheme sift
" colorscheme elise
" colorscheme jellybeans
" colorscheme sonofobsidian
" colorscheme atom
if has('gui')
  set background=dark
  colorscheme solarized
endif


" display this many lines around cursor
set scrolloff=5

" set guioptions-=T   " remove toolbar

" Keybindings
inoremap <C-space> <C-x><C-o>
" nnoremap ; :

" After a search, press ESC to clear the highlight
if has('gui')
  nnoremap <esc> :noh<return>
else
  " XXX: apparently remapping ESC breaks in terminal
  nnoremap <esc><esc> :noh<return>
endif

" Reload ~/.vimrc
nnoremap gev :edit ~/.vimrc<return>
nnoremap grv :source ~/.vimrc<return>

if has('macunix')
  " Easy window navigation
  nmap <silent> ˚ :wincmd k<CR>
  nmap <silent> ∆ :wincmd j<CR>
  nmap <silent> ˙ :wincmd h<CR>
  nmap <silent> ¬ :wincmd l<CR>
endif

" Default leader is '\'
let mapleader=','
let maplocalleader=','

" restore last position in file
" https://stackoverflow.com/questions/774560/in-vim-how-do-i-get-a-file-to-open-at-the-same-line-number-i-closed-it-at-last
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" ============================================================================
" File specific settings

" R
" :help ft-r-indent
let r_indent_align_args = 0

" Nvim-R
let R_assign = 2
" let R_in_buffer = 0
" let R_applescript = 1

" lintr options
let g:ale_r_lintr_options='lintr::with_defaults(single_quotes_linter = NULL,
      \ assignment_linter = NULL, line_length_linter(100),
      \ absolute_paths_linter = NULL, absolute_path_linter = NULL,
      \ commented_code_linter = NULL, object_usage_linter = NULL)'

" python
let g:ale_python_flake8_options=' --ignore F401'
autocmd Filetype python setl tabstop=4 sw=4 sts=4
autocmd Filetype python setl colorcolumn=80 textwidth=80

" Use w!! to write file with root permissions
cmap w!! %!sudo tee > /dev/null %

" Show the status line all of the time
set laststatus=2

" Reformat the entire paragraph
" noremap Q gqip

" Make hjkl act like you would expect on wrapped lines
noremap j gj
noremap k gk

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Automatically remove trailing white space on save
autocmd BufWritePre * :%s/\s\+$//e

let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show trailing whitespace
" let g:airline#extensions#whitespace#enabled = 0

" enable ale
let g:airline#extensions#ale#enabled = 1

autocmd Filetype rmd nmap <LocalLeader>zp <Plug>ROpenPDF

" highlight ErrorMsg ctermfg=White guifg=White
highlight ErrorMsg term=standout ctermfg=15 ctermbg=1 guifg=#FFFFFF guibg=Red

" Jump between sections if '{' is not in first column
" see ':help [[' and search for 'map'
map [[ ?{<CR>w99[{:noh<CR>
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

" start a command with a single !
" nnoremap ! :!

let g:slime_target = 'tmux'
let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], 'target_pane': 'ir:1.1'}

" vim-gitgutter
set updatetime=100

" vim-sneak configuration
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" sneak: use case insensitive matches
let g:sneak#use_ic_scs = 1

" use the_silver_searcher rather than ack
if executable('ag')
  " odd error on mac: https://github.com/ggreer/the_silver_searcher/issues/1038
  let g:ackprg = 'ag --mmap --vimgrep'
endif

" smart home: http://vim.wikia.com/wiki/VimTip315
noremap <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
imap <Home> <C-o><Home>

" depends on default slime mappings
function! RSendFunctionSlime()
  let start=winsaveview()
  " find the '{'
  :exe "normal! ?{\<CR>w99[{:noh\<CR>"
  " highlight matching '}' and call slime
  :exe "normal V%\<c-c>\<c-c>"
  call winrestview(start)
endfunction

" depends on default slime mappings
function! RSendLineSlime()
  let start=winsaveview()
  :exe "normal V\<c-c>\<c-c>"
  call winrestview(start)
endfunction
