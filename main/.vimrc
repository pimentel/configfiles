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
" Plug 'gregsexton/Atom'
Plug 'altercation/vim-colors-solarized'
" Plug 'sonph/onehalf', { 'rtp': 'vim' }

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

" turn on hybrid line numbers
set number relativenumber
" toggle hybrid/normal line numbers
map <Leader><Leader>r :set relativenumber!<CR>

" show line numbers in netrw
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

" search recursively through the current path
set path=.,,**,/usr/include

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

" Show the status line all of the time
set laststatus=2

" Color scheme
" colorscheme atom
if has('gui')
  set background=dark
  colorscheme solarized
endif

" display this many lines around cursor
set scrolloff=5

" highlight ErrorMsg ctermfg=White guifg=White
highlight ErrorMsg term=standout ctermfg=15 ctermbg=1 guifg=#FFFFFF guibg=Red

" ==============================================================================
" Keybindings
" ==============================================================================

" Make hjkl act like you would expect on wrapped lines
noremap j gj
noremap k gk
inoremap <C-space> <C-x><C-o>

" vim-sneak configuration
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" smart home: http://vim.wikia.com/wiki/VimTip315
" make sure to check .gvimrc for corresponding code
noremap <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
imap <Home> <C-o><Home>

" Jump between sections if '{' is not in first column
" see ':help [[' and search for 'map'
map [[ ?{<CR>w99[{:noh<CR>
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

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

" Use w!! to write file with root permissions
cmap w!! %!sudo tee > /dev/null %

noremap <Leader>w :w<cr>

" ============================================================================
" general autocmd
" ============================================================================

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Automatically remove trailing white space on save
autocmd BufWritePre * :%s/\s\+$//e

" on window resize, make every pane equal
autocmd VimResized * wincmd =

" restore last position in file
" https://stackoverflow.com/questions/774560/in-vim-how-do-i-get-a-file-to-open-at-the-same-line-number-i-closed-it-at-last
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif

" ============================================================================
" plug-in and file specific settings
" ============================================================================

" R
" :help ft-r-indent
let r_indent_align_args = 0

" Nvim-R
let R_assign = 2
" let R_in_buffer = 0
" let R_applescript = 1

" ALE
let g:ale_linters = {
      \ 'python': ['flake8'],
      \ 'R': ['lintr'],
      \}

" lintr options
let g:ale_r_lintr_options='lintr::with_defaults(single_quotes_linter = NULL,
      \ assignment_linter = NULL, line_length_linter(100),
      \ absolute_paths_linter = NULL, absolute_path_linter = NULL,
      \ commented_code_linter = NULL, object_usage_linter = NULL)'

" python
" let g:ale_python_flake8_executable = '/Users/hjp/miniconda3/bin/flake8'
let g:ale_python_flake8_options=' --ignore F401'
autocmd Filetype python setl tabstop=4 sw=4 sts=4
autocmd Filetype python setl colorcolumn=80 textwidth=80


let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" airline
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" display the tab number
let g:airline#extensions#tabline#tab_nr_type = 1

" enable ale
let g:airline#extensions#ale#enabled = 1

" slime
let g:slime_target = 'tmux'
let g:slime_default_config = {"socket_name": 'default', 'target_pane': ':'}

" vim-gitgutter
set updatetime=100

" sneak: use case insensitive matches
let g:sneak#use_ic_scs = 1

" use the_silver_searcher rather than ack
if executable('ag')
  " odd error on mac requiring mmap:
  " https://github.com/ggreer/the_silver_searcher/issues/1038
  let g:ackprg = 'ag --mmap --vimgrep'
endif

" ==============================================================================
" custom functions
" ==============================================================================
function! RSendFunctionSlime()
  let save_cursor=winsaveview()
  let i = line('.')
  let line = getline(i)
  while i > 0 && line !~ '[a-zA-Z]\+[a-zA-Z0-9_\.]*[[:space:]]*\(<-\|=\)[[:space:]]*\(function\)[[:space:]]*\((\)'
    let i -= 1
    let line = getline(i)
  endwhile
  if i == 0
    echom "start of R function not found"
    return
  endif
  let start_of_function = i

  let line = getline(i)
  let end = line('$') + 1
  while i < end && line !~ '^\(}\)'
    let i += 1
    let line = getline(i)
  endwhile

  if i == end
    echom "end of R function not found"
    return
  endif
  let end_of_function = i

  :exe start_of_function . "," . end_of_function "SlimeSend"

  call winrestview(save_cursor)
endfunction
