" Detect windows OS
let uname = system('uname -a')
let isWindows = 0
if uname =~ "Microsoft"
 let isWindows = 1
endif

" unfold everything when opening a file
set foldlevelstart=99

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
set tags+=tags;~


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

" ================== Start of Plugin Configs ==========================
" --------- start of vim-plug config ---------
call plug#begin('~/.vim/plugged')
if isWindows
  Plug 'vim-scripts/Zenburn'
  Plug 'morhetz/gruvbox'
endif
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vobornik/vim-mql4'
Plug 'rupurt/vim-mql5'
Plug 'terryma/vim-smooth-scroll'
Plug 'derekwyatt/vim-fswitch'
Plug 'Valloric/YouCompleteMe'
Plug 'leafgarland/typescript-vim'
call plug#end()
" --------- End of vim-plug config ---------

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" Smooth scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>

" yank-stack
map <leader>v <Plug>yankstack_substitute_older_paste
map <leader>V <Plug>yankstack_substitute_newer_paste

" Use ctrlp.vim instead MRU.vim by overwriting keymappings from amix ultimateVimConfiguration
map <leader>f :CtrlPMixed<CR>

" Use fzf instead Ack by overwriting keymappings from amix ultimateVimConfiguration
map <leader>g :Ag<CR>
" Search word under cursor
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR> 
nnoremap <silent> <Leader>s :Ack -f <C-R><C-W><CR> 

" Switch to last split
map <silent> <Leader>w <C-W>w

" derekwyatt/vim-fswitch
nmap <silent> <Leader>a :FSHere<cr>
" map .cc files and .h files for vim-fswitch
augroup mycppfiles
  au!
  au BufEnter *.h let b:fswitchdst  = 'cpp,cc,C'
  au BufEnter *.cc let b:fswitchdst  = 'h'
augroup END

map <leader>tt :CtrlPBuffer<cr>

 " ================== End of Plugin Configs ==========================


if isWindows
  set t_Co=16
  set background=dark
  colorscheme gruvbox
else
  colorscheme zenburn
endif
