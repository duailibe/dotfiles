set noshowmode

if has('gui_running')
  set fileformats=unix

  " Remove scrollbars and toolbar
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
  set guioptions-=T

  if has('gui_macvim')
    set fillchars=vert:\ ,diff:\
    let macvim_skip_colorscheme = 1
    set transparency=0
    set fuoptions=maxvert,maxhorz
    set macligatures
    set guifont=Fira\ Code:h12
    let g:vimBoxLinterErrorSymbol="⮿"
    let g:vimBoxLinterWarningSymbol="⮿"
    let g:vimBoxLinterOkSymbol="☻"
  endif
else
  let g:vimBoxLinterErrorSymbol=">"
  let g:vimBoxLinterWarningSymbol=">"
  let g:vimBoxLinterOkSymbol="☻"
endif

augroup vimrc
  autocmd!
  autocmd ColorScheme * highlight NonText ctermfg=bg guifg=bg
augroup END
