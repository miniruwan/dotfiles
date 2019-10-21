" _______________________________________________________________
" ===============================================================
"
" This file contains the vim plugin configurations
" _______________________________________________________________
" ===============================================================

" --------- start of vim-plug config ---------
call plug#begin('~/.vim/plugged')
Plug 'rafi/awesome-vim-colorschemes'
Plug 'mhinz/vim-startify'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
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
Plug 'godlygeek/tabular'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'vim-scripts/DrawIt'
Plug 'bfrg/vim-cpp-modern'
if has('nvim')
  Plug 'arakashic/chromatica.nvim'
endif
call plug#end()
" --------- End of vim-plug config ---------

" ===============================================================
" Customize plugins
" ===============================================================

""""""""""""""""""""""""""""""
" => YouCompleteMe
""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf = expand('<sfile>:p:h') . '/ycm_extra_conf.py'
let g:ycm_max_diagnostics_to_display = 200
map <leader>y :YcmCompleter FixIt<CR>

""""""""""""""""""""""""""""""
" => Smooth scroll
""""""""""""""""""""""""""""""
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>

""""""""""""""""""""""""""""""
" => CtrlP
""""""""""""""""""""""""""""""
let g:ctrlp_extensions = ['changes']
let g:ctrlp_working_path_mode = 0
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'
map <leader>o :CtrlPMRU<CR>
map <leader>c :CtrlPChange<CR>

""""""""""""""""""""""""""""""
" => Search word under cursor
""""""""""""""""""""""""""""""
" Ack
" ---
" let g:ack_default_options = ' -s -H --nopager --nocolor --nogroup --column --ignore-dir={node_modules,publish,doc,doc-style} --ignore-file=is:tags'
let g:ack_default_options = ' -s -H --nopager --nocolor --nogroup --column --ignore-file=is:tags'
nnoremap <silent> <Leader>ft :Ack! <C-R><C-W><CR> 
xnoremap <silent> <Leader>ft y:Ack! --literal "<C-R>""<CR> 
nnoremap <silent> <Leader>f :Ack! --ignore-dir=Test <C-R><C-W><CR> 
xnoremap <silent> <Leader>f y:Ack! --ignore-dir=Test --literal "<C-R>""<CR> 
" Avoid opening in a new tab because switchbuf current value (switchbuf=useopen,usetab,newtab) includes newtab
" Reference : https://github.com/mileszs/ack.vim/issues/213
set switchbuf=useopen,usetab
" Remove perl error regarding LC_CTYPE 
" Reference : https://github.com/mileszs/ack.vim/issues/163
let $LC_CTYPE='en_US.UTF-8'
let $LC_ALL='en_US.UTF-8'
" Ag
" ---
nnoremap <silent> <Leader>fs :Ag <C-R><C-W><CR> 

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
function! ToggleNERDTreeFind()
    if g:NERDTree.IsOpen()
        execute ':NERDTreeClose'
    else
        execute ':NERDTreeFind'
    endif
endfunction

nnoremap <leader>nn :call ToggleNERDTreeFind()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>r :TagbarToggle<CR>

""""""""""""""""""""""""""""""
" YankRing
""""""""""""""""""""""""""""""
let g:yankring_history_dir = '~/.vim'
let g:yankring_map_dot = 0
map <leader>ps :YRShow<CR>

""""""""""""""""""""""""""""""
" UltiSnips
""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<c-j>"
let g:snips_author=$USER
let g:UltiSnipsSnippetDirectories = [expand('<sfile>:p:h').'/UltiSnips', 'UltiSnips']

""""""""""""""""""""""""""""""
" => FZF
""""""""""""""""""""""""""""""
map <leader>ff :Ag<CR>
map <leader>tt :Windows<cr>

""""""""""""""""""""""""""""""
" => vim-easy-align
""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""
" => incsearch
""""""""""""""""""""""""""""""
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

""""""""""""""""""""""""""""""
" => incsearch-fuzzy
""""""""""""""""""""""""""""""
map <Space>/ <Plug>(incsearch-fuzzy-/)
map <Space>? <Plug>(incsearch-fuzzy-?)

""""""""""""""""""""""""""""""
" => auto-pairs
""""""""""""""""""""""""""""""
let g:AutoPairsShortcutJump='<S-Tab>'
if uname =~ "Linux"
  let g:AutoPairsShortcutBackInsert = '<C-b>'
endif

""""""""""""""""""""""""""""""
" => chromatica.nvim
""""""""""""""""""""""""""""""
if uname =~ "Darwin"
  let g:chromatica#libclang_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'
else
  let g:chromatica#libclang_path='/usr/lib/x86_64-linux-gnu/libclang.so.1'
endif
let g:chromatica#enable_at_startup=1
