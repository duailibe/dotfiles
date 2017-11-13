Plug 'jordwalke/vim-one'
if !exists('g:one_allow_italics')
  " Italics don't typically render well in terminals
  let g:one_allow_italics = has('gui_running')
endif

Plug 'jordwalke/VimCleanColors'
Plug 'tpope/vim-sensible'
Plug 'jordwalke/VimAutoMakeDirectory'

" Git plugins
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'jreybert/vimagit'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-markdown'

Plug 'MartinLafreniere/vim-PairTools'
set runtimepath+=~/.vim/plugins.rc/pairTools

Plug 'jordwalke/VimLastTab'
Plug 'jordwalke/VimCloser'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='one'
source ~/.vim/plugins.rc/airline.vim
if has("gui_macvim") || has("gui_vimr")
  autocmd VimEnter * set guioptions+=e
endif

Plug 'vim-syntastic/syntastic'
" TODO: Disable signs in merlin/syntastic, and only use the VimHint strategy of
" underlining *just* the region of error.
let g:syntastic_enable_signs=0
let g:syntastic_always_populate_loc_list=1
let g:syntastic_loc_list_height=15
" This doesn't work:'
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#quickfix#location_text = 'Diagnostics'
let g:airline#extensions#whitespace#trailing_format = ' '


Plug 'jordwalke/MacVimSmartGUITabs'
" Make sure to have `set guioptions+=e` in your `.gvimrc`.
map <D-Cr> :SmartGUITabsToggleFullScreen<CR>
imap <D-Cr> <Esc>:SmartGUITabsToggleFullScreen<CR>
nmap <D-Cr> <Esc>:SmartGUITabsToggleFullScreen<CR>

" NERDTree
Plug 'scrooloose/nerdtree'
" Close vim if the only window left
" open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" nice arrow
let g:NERDTreeDirArrows = 1
" not so much cruft
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowBookmarks = 1
hi def link NERDTreeRO Normal
hi def link NERDTreePart StatusLine
hi def link NERDTreeDirSlash Directory
hi def link NERDTreeCurrentNode Search
hi def link NERDTreeCWD Normal

let g:NERDTreeWinSize=40

" Not so much color
let g:NERDChristmasTree = 0

Plug 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_focus_on_files = 1
let g:nerdtree_tabs_open_on_gui_startup = 0

Plug 'ctrlpvim/ctrlp.vim'
set splitright
let g:ctrlp_switch_buffer="ETVH"
let g:ctrlp_map = '<D-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_match_window = 'bottom,order:btt,min:13,max:13'
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_show_hidden = 0
let g:ctrlp_mruf_max = 250
let g:ctrlp_max_depth = 7
let g:ctrlp_max_files = 30000
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

let g:ctrlp_prompt_mappings = {
      \ 'CreateNewFile()':      [''],
      \ 'ToggleType(1)':        ['<c-u>', '<c-up>'],
      \ 'ToggleType(-1)':       ['<c-y>', '<c-down>'],
      \ 'PrtCurLeft()':         ['<c-b>', '<left>', '<c-^>'],
      \ 'PrtCurRight()':        ['<c-f>', '<right>'],
      \ 'AcceptSelection("e")': ['<c-t>'],
      \ 'AcceptSelection("h")': ['<c-v>'],
      \ 'AcceptSelection("v")': ['<c-s>'],
      \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
      \ 'PrtClearCache()':      ['<D-C>'],
      \ 'PrtDeleteEnt()':       ['<F7>'],
      \ 'PrtExit()':            ['<c-l>', '<esc>', '<c-c>', '<c-g>'],
      \ }

Plug 'terryma/vim-smooth-scroll'
"Normal mode
noremap <silent> <c-u> :call smooth_scroll#up(40, 20, 6)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(40, 20, 6)<CR>

" smooth_scroll is broken in visual mode currently - unmap
vnoremap <silent> <c-u> <c-u>
vnoremap <silent> <c-d> <c-d>

Plug 'jordwalke/flatlandia'
Plug 'altercation/vim-colors-solarized'
"default value is 1
let g:solarized_underline=0
"default value is 16
let g:solarized_termcolors=256
"default value is normal
let g:solarized_contrast="high"
"default value is normal
let g:solarized_visibility="high"

Plug 'scrooloose/nerdcommenter'
let g:NERDCompactSexyComs = 0
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'reason': { 'left': '/*','right': '*/', 'nested': 1 } }

Plug 'mxw/vim-jsx'

Plug 'vim-scripts/Parameter-Text-Objects'

Plug 'AndrewRadev/splitjoin.vim'

Plug 'ntpeters/vim-better-whitespace'
let g:strip_whitespace_on_save = 1

Plug 'prettier/vim-prettier'
