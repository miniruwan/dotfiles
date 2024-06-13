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


" copying to clipboard
vmap <C-x> :!pbcopy<CR>  
vmap <C-c> "+y

" Source other vim configuration files
if has('nvim')
  execute 'source ' . expand('<sfile>:p:h') . '/neovim.vim'
endif
execute 'source ' . expand('<sfile>:p:h') . '/plugin_config.vim'

set nu
set noswapfile

" Setting the correct path for grep
set grepprg=/usr/bin/grep

" change cursor shape between insert and command modes
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Mouse scroll
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces

" Search web selected text
if uname =~ "Microsoft"
:vmap ?? y:!
 \ /mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe "http://www.google.com/search?q=
 \<C-R>0
 \"
 \<CR><CR>
else
:vmap ?? y:!
 \ /usr/bin/open -a "/Applications/Google Chrome.app" "http://www.google.com/search?q=
 \<C-R>0
 \"
 \<CR><CR>
endif

" Initiate replace word under cursor
map <silent> <Leader>h :%s/<C-R><C-W>

" Switch to last split
map <silent> <Leader>w <C-W>w

" Find references
" --------------
" (tselect word under cursor. This is useful if there are multiple tags for the same word)
" nnoremap <silent> <C-\> :tselect <C-R><C-W><CR> 

" Move out of auto-completed paranthesis(or similar) when in insert mode
" inside the paranthesis
inoremap <C-\> <Esc>A

" unfold everything when opening a file
set foldlevelstart=99

map <leader>et :tabe ~/temp/temp.txt<CR>

command VT tabe ~/temp/temp.txt

if uname =~ "Microsoft"
  set t_Co=16
  set background=dark
  colorscheme OceanicNext
  let g:clipboard = {
    \   'name': 'WslClipboard',
    \   'copy': {
    \      '+': 'clip.exe',
    \      '*': 'clip.exe',
    \    },
    \   'paste': {
    \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \   },
    \   'cache_enabled': 0,
    \ }  
else
  colorscheme onedark
  hi MatchParen cterm=bold ctermfg=LightYellow ctermbg=Gray
endif

" Treat wods with dash as one word
" https://til.hashrocket.com/posts/t8osyzywau-treat-words-with-dash-as-a-word-in-vim
set iskeyword+=-
