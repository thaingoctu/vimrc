source $VIMRUNTIME/vimrc_example.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" ==============================================================================
" UI Config
" ==============================================================================
" Set the display font for GUI Vim
if has("gui_running")
    if has("gui_win32")
        set guifont=Consolas:h10:cANSI
    elseif has("gui_gtk2")
        set guifont=Inconsolata\ 10 
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h10
    endif
    set nowrap          " Don't wrap text
    set guioptions-=T   " Don't show the toolbar
    set guioptions+=bar " Show the horizontal scroll bar
    set columns=100 lines=25
endif

colorscheme darkblue    " Set the color scheme
syntax on               " Turn on syntax coloring
set number              " Turn on line number
set cursorline          " Highlight the current line
set colorcolumn=81      " Show a vertical ruler
set showcmd             " Show command in the bottom bar

" ==============================================================================
" Use powershell 
" ==============================================================================
if has("win32")
    set shell=powershell.exe
    set shellcmdflag=-command
endif

" ==============================================================================
" Searching
" ==============================================================================
set hlsearch            " Highlight search
set incsearch           " Turn on incremental searches

" ==============================================================================
" Code Editor
" ==============================================================================
set showmatch           " Highlight matching [{()}]
set tabstop=4           " Set number of visual spaces per TAB
set softtabstop=4       " Number of spaces in TAB when editing
set expandtab           " TAB is spaces
set cindent             " Indent according to a standard C style
set autoindent          " New lines are indented the same as previous line
set smartindent         " Add an extra level of indentation if the line contains
                        " a left curly brace and remove an indentation level
                        " if the line contains a right curly brace

" ==============================================================================
" Backup
" ==============================================================================
set nobackup            " Don't write a backup file *.~
set noundofile          " Don't write an undofile *.un~
