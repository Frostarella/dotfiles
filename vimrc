" .vimrc
" adapted from onc // github.com/onc
" @frostarella // gihub.com/frostarella
" last changed: 08. June 2018


" =============================================================================
"               BASICS
" =============================================================================
" vim wants to run under xterm, fzf under screen...
set term=xterm-256color
set nocompatible

set completeopt-=preview " get rid of preview in scratch buffer at top of file

filetype on
filetype plugin on
filetype indent on 

" ------------- SYNTAX --------------------------------------------------------
syntax enable
set background=dark

" ------------- ENCODING ------------------------------------------------------
set encoding=utf8
set termencoding=utf-8
set fileencoding=utf-8

" ------------- LINE NUMBERS --------------------------------------------------
set number " set relativenumber

" ------------- FORMAT --------------------------------------------------------
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4 

set autoindent " copy the indention from prev line
set smartindent " auto indent in some files e.g. C-like
set formatoptions+=t " wrapping words
set textwidth=0 " no new line after 80 chars

" wrap long lines - only for display, no new lines!
set linebreak
set wrap
set nolist

set wrapmargin=0 " wrap 5 chars before right window border

" Tab-stuff
set expandtab
set smarttab

set backspace=indent,eol,start " smart backspace

" ------------- SEARCH --------------------------------------------------------
set incsearch " instant regex preview
set hlsearch " show all search results
set nowrapscan " turn off wrapping while searching
set magic " nice regex

" better search
set smartcase
set ignorecase

" ------------- VISUAL --------------------------------------------------------
set lazyredraw " Don't redraw while executing macros (good performance config)
set showmatch " show matching brackets
set wildmenu " graphical menu for command mode autocomplete
set scrolloff=15 " number of lines above and below scroll
set foldmethod=marker " folding
set antialias " set antialias
set switchbuf=usetab " use tabs
set ttyfast " make Vim run moar smooth
set mouse=a " mouse in all modes
set cursorline " cursor-zeile markieren

" fixing delay on leaving insert-mode
set notimeout
set ttimeout
set ttimeoutlen=10

set colorcolumn=80 " show column number 80

set nofoldenable " disable folding

" ------------- LANG ----------------------------------------------------------
set spelllang=en

" ------------- FILESYSTEM ----------------------------------------------------
" fu swapfiles
set noswapfile
set nobackup

set autoread " auto read file when a file is changed from outside
set clipboard=unnamed " normal OS clipboard interaction

" Maintain undo history between sessions
set undofile   
set undodir=~/.vim/undodir

" ------------- KEYBINDINGS ---------------------------------------------------
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" save on double esc
map <Esc><Esc> :w<CR>

" Y for yank until last non whitespace char, like D
nnoremap Y yg_

" Create newlines without entering insert mode
nnoremap go o<Esc>k
nnoremap gO O<Esc>j

" space fuer comandmode
nnoremap <space> :

" save as sudo
cabbrev w!! w !sudo tee % > /dev/null %

" source vimrc
cabbrev so :source ~/.vimrc

" turn on spell
cabbrev spellon :setlocal spell

" turn off hightlighting on backspace
nnoremap <silent> <bs> :nohl<cr>

" open vimrc
nnoremap <leader>vim :tabnew ~/.vimrc<cr>
nnoremap <silent> <leader>f gg=G``

" ------------- FILETYPE SETTINGS ---------------------------------------------
autocmd Bufread,BufNewFile *.tex set filetype=tex 
autocmd Bufread,BufNewFile *.md set filetype=markdown " Vim interprets .md as 'modula2'
autocmd Bufread,BufNewFile *.mail set filetype=mail 

" spell in tex
autocmd FileType tex setlocal spell
autocmd BufNewFile,BufRead *.tex setlocal spell
autocmd FileType tex set colorcolumn=125

" javascript
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab

" mail
autocmd FileType mail setlocal textwidth=80 spell

" C
autocmd FileType c setlocal foldmethod=syntax

" =============================================================================
"               PLUGINS
" =============================================================================
" install plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline' " pretty and useful bottom bar thingy
Plug 'lilydjwg/colorizer' " for nicer colour stuffz on text
Plug 'junegunn/vim-easy-align' " alignment tool
Plug 'chriskempson/base16-vim' " base 16 themes
Plug 'vim-airline/vim-airline-themes' " airline themes
Plug 'valloric/youcompleteme' " completion
Plug 'OmniSharp/omnisharp-vim' " completion server for c# and unity
Plug 'w0rp/ale' " syntax
Plug 'jpalardy/vim-slime' " send from one pane to another -> used for R
Plug 'jiangmiao/auto-pairs' " insert parentheses is pairs
call plug#end()

" ------------- EASY ALIGN ----------------------------------------------------
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" ------------- ?????????? ----------------------------------------------------
" https://sunaku.github.io/vim-256color-bce.html
set t_ut=
set t_Co=256
" https://github.com/chriskempson/base16-vim/issues/110#issuecomment-257204974
if has("termguicolors")
    set termguicolors
endif

" ------------- WORDCOUNT FOR AIRLINE -----------------------------------------
" from https://stackoverflow.com/questions/114431/fast-word-count-function-in-vim
function! WordCount()
   let s:old_status = v:statusmsg
   let position = getpos(".")
   exe ":silent normal g\<c-g>"
   let stat = v:statusmsg
   let s:word_count = 0
   if stat != '--No lines in buffer--'
     let s:word_count = str2nr(split(v:statusmsg)[11])
     let v:statusmsg = s:old_status
   endif
   call setpos('.', position)
   return s:word_count 
endfunction

" ------------- AIRLINE -------------------------------------------------------
set laststatus=2

let g:airline_theme='base16_mary' " set theme
let g:airline_powerline_fonts=1 " enable powerline fonts
let g:airline#extensions#wordcount#enabled=0 " disable native wordcount
let g:solarized_termcolors=256 
let g:airline_skip_empty_sections=1 " skip statusline sections when empty

" statusline layout
let g:airline#extensions#default#layout=[
      \ ['b', 'c', 'y',],
      \ ['z',]
      \ ]

let g:airline_section_z='%{WordCount()} words in %L lines' " include wordcount and linecount in statusline

" left and right sep of sections
let g:airline_right_sep=''
let g:airline_left_sep=''

let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]

" ------------- YOU COMPLETE ME -----------------------------------------------
let g:rainbow_active=1
let g:rainbow_load_separately=[
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]'], ['\{', '\}']] ],
    \ [ '*.{cpp,java,cs}' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]
let g:rainbow_guifgs=['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs=['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']
let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf.py'
let g:ycm_register_as_syntastic_checker=0
" uncomment the following line to disable youcompleteme
" let g:loaded_youcompleteme = 1

" ------------- VIM-SLIME -----------------------------------------------------
" https://github.com/jalvesaq/vim-slime
let g:slime_target='tmux'
let g:slime_paste_file='$HOME/.vimslime_paste'
let g:slime_default_config={'socket_name': 'default', 'target_pane': ':.1'}

" ------------- ALE -----------------------------------------------------------
" https://github.com/w0rp/ale
let g:ale_linters={
\ 'cs':['OmniSharp']
\}


" =============================================================================
" =============================================================================
" =============================================================================
" colorscheme must always stay at the bottom
colorscheme base16-mary
