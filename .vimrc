" === Basic settings === "

set nocompatible "not vi-compatible mode
filetype off
source ~/.vim/plugins.vim "Load plugins
filetype plugin indent on "enable filetype plugin
syntax on "syntax highlighting on

if has('gui_running')
    colorscheme solarized
    if has("gui_gtk2")
        set guifont=Monospace\ 11
    endif
else
    colorscheme desert
endif

let mapleader=','
set number
set autochdir "switch to the current file directory
set backspace=indent,eol,start "make backspace more flexible
set fileformats=unix,dos,mac "support all three in specified order
set hidden "change buffers without saving
set iskeyword-=_ " `_` symbol breaks the word
set noerrorbells "no error sound
set novisualbell "no visual blinking
set wrap linebreak textwidth=0 "wrap lines at word boundaries
set autoindent "copy indent from current line
set smartindent "smart indent
set scrolloff=5 "5 lines of context around cursor
set ruler "show cursor position all the time
set cmdheight=2 "command bar height
set showcmd "show the command being typed 
set hlsearch "highligh search matches
set showmatch "show matching brackets
set matchtime=2 "how long to blink matching bracket
set whichwrap=<,>,h,l "wrapping when navigating
set incsearch "incremental search
set nobackup "turn off backup
set nowritebackup "turn off backup
set textwidth=78 "text width
set expandtab "spaces instead of tab
set tabstop=4 "number of spaces in tab
set shiftwidth=4 "spaces for indent
set softtabstop=4 "number of spaces in tab when editing
set laststatus=2 "allways show status line
set statusline=%<%f%h%m%r%=%{&ff}\ %l,%c%V\ %P
set completeopt=longest,menuone "autocompletion settings
set modeline "read modeline
set nostartofline "do not change cursor position when jumping to other line
set wildmenu "show list instead of completing command
set wildmode=list:longest,full "command completion order
set nolist
set listchars=eol:$,tab:»·,trail:.
let &sbr = nr2char(8618).' ' " Show ↪ at the beginning of wrapped lines
set colorcolumn=80
set runtimepath^=~/.vim/ctrlp.vim
set splitbelow "split down
set splitright "split to the right

set ttyfast
set history=1000
set undofile
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set noswapfile
set backup
set shell=/bin/bash\ --login
set showbreak=↪
set fillchars=diff:⣿,vert:│
set autowrite
set autoread
set title
set noignorecase
set gdefault
set fo-=t
set complete=.,w,b,u,t

"=== Plugins configuration ==="

"--- NERDTree ---"
let NERDTreeHijackNetrw = 0

"--- Tlist ---"
"let Tlist_Auto_Open = 1 " let the tag list open automagically
let Tlist_Exit_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_File_Fold_Auto_Close = 1 " fold closed other trees
let Tlist_WinWidth = 40 " 40 cols wide
let Tlist_Auto_Highlight_Tag = 1 "automatically highligh tag

"--- CtrlP ---"
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
let g:ctrlp_user_command = 'find %s -type f' 
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:25,results:25'
let g:ctrlp_by_filename=1

"--- Ag/Ack/Greplace ---"
if executable('ag')
    let g:ackprg = 'ag --vimgrep --smart-case'
endif
cnoreabbrev ag Ack
cnoreabbrev aG Ack                                                                           
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

"-- php-cs-fixer ---"
nnoremap <silent><leader>pf :call PhpCsFixerFixFile()<CR>

"=== Functions ==="

"--- Trailing whitespace ---"
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

"=== Auto commands ==="

"--- Autosource ---"
augroup autosourcegroup
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END

"--- Python ---"
augroup pythongroup
    autocmd!
    autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
    autocmd FileType python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup END

"--- PHP ---"
augroup phpgroup
    autocmd!
    autocmd FileType php autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup END

"=== Mappings ==="

"--- Autocompletion ---"
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>" 
inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>" 
inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>" 

"--- Copy/Paste/Cut ---"
vmap <C-c> "+y
vmap <C-v> <ESC>"+p
vmap <C-x> "+d
nmap <C-v> "+p
imap <C-v> <ESC>"+pi

"--- Tab navigation ---"
nmap <C-Tab> :tabnext<CR>
nmap <C-Insert> :tabnew<CR>
nmap <C-Delete> :tabclose<CR> 

"--- Tags ---"
map <C-t> :CtrlPBufTag<CR>
nmap <F3> :TlistToggle<CR>

"--- Misc ---"
nmap <F2> :NERDTreeToggle<CR>
nmap ,<space> :nohlsearch<CR>
nnoremap <F5> :buffers<CR>:buffer<Space>

"=== Tips ==="
" zz -- center on current line
" Ctrl+P -- CtrlP search by filename
" Ctrl+T -- CtrlP search by tag
" :ag -- search in project
" :Gsearch -- search/replace in project
" ,pf -- php cs fixer
" Uppercase mark is global
" mark 0 -- place of last modification
" C-6 / C-^ -- switches to previous buffer
" F5 -- fast selection of buffer
