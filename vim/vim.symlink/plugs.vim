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

Plug 'jordwalke/VimCloser'

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
