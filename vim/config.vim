" ===============================================================
"
" This is the main vim configuration file.
" This file will source other vim configuration files also.
" _______________________________________________________________
" ===============================================================


" https://superuser.com/questions/179164/vim-complains-about-a-temporary-file-when-opening-syntax-highlighted-files-on-ma
set shell=/bin/zsh
" Detect OS for later
let uname = system('uname -a')

let mapleader=","

" Source other vim configuration files
if has('nvim')
  execute 'source ' . expand('<sfile>:p:h') . '/neovim.vim'
endif
execute 'source ' . expand('<sfile>:p:h') . '/plugin_config.vim'

set nu
set noswapfile

" copying to clipboard
vmap <C-x> :!pbcopy<CR>  
vmap <C-c> "+y

" Setting the correct path for grep
set grepprg=/usr/bin/grep

" change cursor shape between insert and command modes
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

" Mouse scroll
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" configure tabwidth and insert spaces instead of tabs
set tabstop=2        " tab width is 4 spaces
set shiftwidth=2     " indent also with 4 spaces
set expandtab        " expand tabs to spaces

" Search web selected text
:vmap ?? y:!
 \ /usr/bin/open -a "/Applications/Google Chrome.app" "http://www.google.com/search?q=
 \<C-R>0
 \"
 \<CR><CR>

" Initiate replace word under cursor
map <silent> <Leader>h :%s/<C-R><C-W>

" Switch to last split
map <silent> <Leader>w <C-W>w

" Find references
" --------------
" (tselect word under cursor. This is useful if there are multiple tags for the same word)
nnoremap <silent> <C-\> :tselect <C-R><C-W><CR> 

" unfold everything when opening a file
set foldlevelstart=99

map <leader>et :tabe ~/temp/temp.txt<CR>

if uname =~ "Microsoft"
  set t_Co=16
  set background=dark
  colorscheme gruvbox
else
  colorscheme zenburn
endif
