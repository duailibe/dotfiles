set noshowmode

if has('gui_running')
  set fileformats=unix

  if has('gui_macvim')
    set fillchars=vert:\ ,diff:\ 
    let macvim_skip_colorscheme = 1
    set transparency=0
    set fuoptions=maxvert,maxhorz
  endif
endif

augroup vimrc
  autocmd!
  autocmd ColorScheme * highlight NonText ctermfg=bg guifg=bg
augroup END

    
