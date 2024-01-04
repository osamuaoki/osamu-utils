""" Generic baseline Vim and Neovim configuration (~/.vimrc)
"""   - For NeoVim, use "nvim -u ~/.vimrc [filename]"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                " :h 'cp -- sensible (n)vim mode
syntax on                       " :h :syn-on
filetype plugin indent on       " :h :filetype-overview
set encoding=utf-8              " :h 'enc (default: latin1) -- sensible encoding
""" current vim option value can be verified by :set encoding?
set backspace=indent,eol,start  " :h 'bs (default: nobs) -- sensible BS
set statusline=%<%f%m%r%h%w%=%y[U+%04B]%2l/%2L=%P,%2c%V
set listchars=eol:¶,tab:⇄\ ,extends:↦,precedes:↤,nbsp:␣
set viminfo=!,'100,<5000,s100,h " :h 'vi -- bigger copy buffer etc.
""" Pick "colorscheme" from blue darkblue default delek desert elflord evening
""" habamax industry koehler lunaperche morning murphy pablo peachpuff quiet ron
""" shine slate torte zellner
colorscheme industry
"colorscheme default
set laststatus=2                " :h 'ls (default 1)
""" boolian options can be unset by prefixing "no"
"set list                        " :h 'list (default nolist)
set smartcase                   " :h 'scs -- Override the 'ignorecase' option
set autoindent                  " :h 'ai
set smartindent                 " :h 'si
set nowrap                      " :h 'wrap
set noerrorbells                " :h 'eb
set novisualbell                " :h 'vb
set t_vb=                       " :h 't_vb -- termcap visual bell
set spell                       " :h 'spell
set spelllang=en_us,cjk         " :h 'spl -- english spell, ignore CJK
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Window moves without using CTRL-W which is dangerous in INSERT mode
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" fast "jk" to get out of INSERT mode (<ESC>)
inoremap  jk        <ESC>
""" double <ESC> to get out of TERM mode (CTRL-\ CTRL-N)
tnoremap <ESC><ESC> <C-\><C-N>
""" fast "jkjk" to get out of TERM mode (CTRL-\ CTRL-N)
tnoremap jkjk <C-\><C-N>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Use faster 'rg' (ripgrep package) for :grep
if executable("rg")
  " port https://www.vi-improved.org/recommendations/ to rg
  set grepprg=rg\ --no-heading\ --color=never\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Retain last cursor position :h '"
augroup RetainLastCursorPosition
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
augroup END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Force to use underline for spell check results
augroup SpellUnderline
  autocmd!
  autocmd ColorScheme *
    \ highlight SpellBad
    \   term=Underline
    \   gui=Undercurl
  autocmd ColorScheme *
    \ highlight SpellCap
    \   term=Underline
    \   gui=Undercurl
  autocmd ColorScheme *
    \ highlight SpellLocal
    \   term=Underline
    \   gui=Undercurl
  autocmd ColorScheme *
    \ highlight SpellRare
    \   term=Underline
    \   gui=Undercurl
augroup END
" vim: set sw=2 sts=2 et ft=vim :
