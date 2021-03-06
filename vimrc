set nocompatible
" set keymap=bulgarian-phonetic
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
Plugin 'gmarik/vundle'

" My bundles
Plugin 'ervandew/supertab'
Plugin 'kchmck/vim-coffee-script'
Plugin 'skwp/greplace.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-ruby/vim-ruby'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'tpope/vim-rake'
Plugin 'bling/vim-airline'
Plugin 'elixir-lang/vim-elixir'
Plugin 'scrooloose/syntastic'
Plugin 'elmcast/elm-vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'DataWraith/auto_mkdir'
" Colors
Plugin 'nanotech/jellybeans.vim'

call vundle#end()            " required
filetype plugin indent on

" Boris Vian
colorscheme jellybeans

" cursorline rules
set cursorline

"==============
" Ruby stuff
" =============

syntax enable
augroup myfiletypes
  autocmd!
  " autoindent with 2 spaces, always expand
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  autocmd FileType ruby,eruby,yaml setlocal colorcolumn=80
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
augroup END

runtime macros/matchit.vim

"===========================
let mapleader = "\<Space>"

vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
nmap <Leader>vr :sp $MYVIMRC<cr>
nmap <Leader>so :source $MYVIMRC<cr>
nmap <Leader>vi :tabe $MYVIMRC<cr>
imap jk <esc>
imap kj <esc>
nnoremap gb :ls<cr>:b<space>
" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR> map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
nnoremap <A-n> :bnext<CR>:redraw<CR>:ls<CR>
nnoremap <A-p> :bprevious<CR>:redraw<CR>:ls<CR>

" Break line at the cursor (Ctrl-J):
nnoremap <NL> i<CR><esc>

" Clear the last search:
nmap <Leader>h :nohlsearch<CR>

" puts the caller
nnoremap <leader>wtf oputs "#" * 90<c-m>puts caller<c-m>puts "#" * 90<esc>

" show last inserted text
nnoremap gV `[v`]
" copy to clipboard
set clipboard=unnamed
" set paste
" set go+=a
set backspace=indent,eol,start " allow backspacing over everything in insert mode
map <Leader>c <C-_><C-_>
set history=500   " keep 500 lines of command line history
set ruler    " show the cursor position all the time
set showcmd  " display incomplete commands
set autoindent
set showmatch
set nowrap
set backup
set backupdir=~/.tmp
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files
set writebackup
set autoread
set wmh=0
set viminfo+=!
set guioptions-=T
set guifont=Triskweline_10:h10
set et
set sw=2
set smarttab
set noincsearch
set ignorecase smartcase
set laststatus=2  " Always show status line.
set relativenumber
set invnumber
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set autoindent " always set autoindenting on
set bg=light
set lazyredraw " Don't redraw screen when running macros.

" Enable folding
set foldenable
set foldlevelstart=10  "open most folds by default
set foldnestmax=10     " 10 nested fold max
set foldmethod=indent  " fold based on indent level

" Set the tag file search order
set tags=./tags;

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" ctrlp opens file in new buffer
let g:ctrlp_switch_buffer = 0

" ctrlp respects change of dir
let g:ctrlp_working_path_mode = 0
" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" search for the word under cursor
noremap <Leader>a  :Ag -Q <C-r>=expand('<cword>')<CR><CR>

" Make the omnicomplete text readable
highlight PmenuSel ctermfg=black

" Ignore stuff that can't be opened
set wildignore+=tmp/**

" Set statusline of fugitive
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
" Status line - syntastic
" set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_tidy_exec = 'tidy5'
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:syntastic_ruby_rubocop_exec = '/Users/rmilushev/.rbenv/shims/rubocop'
" Highlight the status line
highlight StatusLine ctermfg=blue ctermbg=yellow

" Format xml files
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.

set nofoldenable " Say no to code folding...

command! Q q " Bind :Q to :q
command! Qall qall
command! QA qall
command! E e

" Execute macro in q
map Q @q

" Disable K looking stuff up
map K <Nop>

au BufNewFile,BufRead *.txt setlocal nolist " Don't display whitespace

" Better? completion on command line
set wildmenu
" What to do when I press 'wildchar'. Worth tweaking to see what feels right.
set wildmode=list:full

" (Hopefully) removes the delay when hitting esc in insert mode
set noesckeys
set ttimeout
set ttimeoutlen=1

" Add smart split sizes of window in focus:
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

" Let's be reasonable, shall we?
nmap k gk
nmap j gj

let g:CommandTMaxHeight=50
let g:CommandTMatchWindowAtTop=1

" Elm
let g:elm_format_autosave = 1
let g:elm_detailed_complete = 1
let g:elm_syntastic_show_warnings = 1
let g:elm_format_fail_silently = 1
let g:elm_browser_command = 'open'
let g:elm_make_show_warnings = 1
let g:elm_setup_keybindings = 1

" Elm support deoplete neovim
" h/t https://github.com/ElmCast/elm-vim/issues/52#issuecomment-264161975
" let g:deoplete#sources.elm = ['omni'] + g:deoplete#sources._
" let g:deoplete#omni#functions.elm = ['elm#Complete']
" let g:deoplete#omni#input_patterns.elm = '[^ \t]+'
" let g:deoplete#disable_auto_complete = 1

" Don't wait so long for the next keypress (particularly in ambigious Leader
" situations.
set timeoutlen=500

" Set gutter background to black
highlight SignColumn ctermbg=black


"""RENAME CURRENT FILE (thanks Gary Bernhardt)""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <Leader>n :call RenameFile()<cr>

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Make it more obvious which paren I'm on
hi MatchParen cterm=none ctermbg=black ctermfg=yellow

" By default, vim thinks .md is Modula-2.
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Wrap the quickfix window
autocmd FileType qf setlocal wrap linebreak

" q closes the buffer for help files
autocmd Filetype help nnoremap <buffer> q :q<CR>
" neat bracketed paste, credits Chris Page
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    vmap <expr> <Esc>[200~ XTermPasteBegin("c")
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
endif

" status line for fugitive plugin
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
