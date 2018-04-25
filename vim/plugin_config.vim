
" --------- start of vim-plug config ---------
call plug#begin('~/.vim/plugged')
Plug 'mileszs/ack.vim'
if isWindows
  Plug 'vim-scripts/Zenburn'
  Plug 'morhetz/gruvbox'
endif
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'terryma/vim-smooth-scroll'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'derekwyatt/vim-fswitch'
Plug 'vim-scripts/YankRing.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/nerdcommenter'
Plug 'vobornik/vim-mql4'
Plug 'rupurt/vim-mql5'
Plug 'leafgarland/typescript-vim'
call plug#end()
" --------- End of vim-plug config ---------

" ===============================================================
" Customize plugins
" ===============================================================

""""""""""""""""""""""""""""""
" => YouCompleteMe
""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

""""""""""""""""""""""""""""""
" => Smooth scroll
""""""""""""""""""""""""""""""
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>

""""""""""""""""""""""""""""""
" => CtrlP
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'
map <leader>o :CtrlPMRU<CR>

""""""""""""""""""""""""""""""
" => Search word under cursor
""""""""""""""""""""""""""""""
" Ack
" ---
nnoremap <silent> <Leader>s :Ack! <C-R><C-W><CR> 
nnoremap <silent> <Leader>st :Ack! --ignore-dir=Test <C-R><C-W><CR> 
" Avoid opening in a new tab because switchbuf current value (switchbuf=useopen,usetab,newtab) includes newtab
" Reference : https://github.com/mileszs/ack.vim/issues/213
set switchbuf=useopen,usetab
" Remove perl error regarding LC_CTYPE 
" Reference : https://github.com/mileszs/ack.vim/issues/163
let $LC_CTYPE='en_US.UTF-8'
let $LC_ALL='en_US.UTF-8'
" Ag
" ---
nnoremap <silent> <Leader>ss :Ag <C-R><C-W><CR> 
" Find references
" --------------
nnoremap <silent> <Leader>r :tselect <C-R><C-W><CR> 

""""""""""""""""""""""""""""""
" => vim-fswitch
""""""""""""""""""""""""""""""
nmap <silent> <Leader>a :FSHere<cr>
" map .cc files and .h files for vim-fswitch
augroup mycppfiles
  au!
  au BufEnter *.h let b:fswitchdst  = 'cpp,cc,C'
  au BufEnter *.cc let b:fswitchdst  = 'h'
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nerd tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>nn :NERDTreeToggle<cr>
map <leader>nf :NERDTreeFind<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>c :TagbarToggle<CR>

""""""""""""""""""""""""""""""
" YankRing
""""""""""""""""""""""""""""""
let g:yankring_map_dot = 0
nnoremap <leader>ps :YRShow<CR>

""""""""""""""""""""""""""""""
" UltiSnips
""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<c-j>"

""""""""""""""""""""""""""""""
" => FZF
""""""""""""""""""""""""""""""
map <leader>f :Ag<CR>
map <leader>tt :Windows<cr>
