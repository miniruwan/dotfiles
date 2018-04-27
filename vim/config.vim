"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Assumptions:
"       $MY_VIM_CONFIG_DIR environment variable is set
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Detect windows OS
let uname = system('uname -a')
let isWindows = 0
if uname =~ "Microsoft"
 let isWindows = 1
endif

" Assumption: $MY_VIM_CONFIG_DIR environment variable is set
source $MY_VIM_CONFIG_DIR/plugin_config.vim

set nu

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

" do an upward search from the directory containing tags up to the stop directory (~)
set tags+=~/projects/mcu-libwebrtc/libwebrtc/src/tags,tags;~

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
map <silent> <Leader>h :%s/<C-R><C-W>/

" Switch to last split
map <silent> <Leader>w <C-W>w

" unfold everything when opening a file
set foldlevelstart=99

map <leader>et :tabe ~/temp/temp.txt<CR>

if isWindows
  set t_Co=16
  set background=dark
  colorscheme gruvbox
else
  colorscheme zenburn
endif
