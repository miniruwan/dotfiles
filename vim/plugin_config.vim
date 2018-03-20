
" --------- start of vim-plug config ---------
call plug#begin('~/.vim/plugged')
Plug 'mileszs/ack.vim'
if isWindows
  Plug 'vim-scripts/Zenburn'
  Plug 'morhetz/gruvbox'
endif
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'terryma/vim-smooth-scroll'
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
let g:ctrlp_map = '<Leader>o'
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

""""""""""""""""""""""""""""""
" => Search word under cursor
""""""""""""""""""""""""""""""
nnoremap <silent> <Leader>ss :Ag <C-R><C-W><CR> 
nnoremap <silent> <Leader>s :Ack! <C-R><C-W><CR> 
nnoremap <silent> <Leader>st :Ack! --ignore-dir=Test <C-R><C-W><CR> 
nnoremap <silent> <Leader>r :tselect <C-R><C-W><CR> 
" Remove perl error regarding LC_CTYPE 
" https://github.com/mileszs/ack.vim/issues/163
let $LC_CTYPE='en_US.UTF-8'
let $LC_ALL='en_US.UTF-8'

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
map <leader>nn :nerdtreetoggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>' :TagbarToggle<CR>

""""""""""""""""""""""""""""""
" YankRing
""""""""""""""""""""""""""""""
let g:yankring_map_dot = 0

""""""""""""""""""""""""""""""
" => FZF
""""""""""""""""""""""""""""""
map <leader>ag :Ag<CR>
map <leader>tt :Windows<cr>
