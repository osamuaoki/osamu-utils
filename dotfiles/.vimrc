
" Local configuration
"
" behave as Vim (not as Vi)
set nocompatible

" paste mode
set nopaste
set pastetoggle=<f2>

" syntax highlights (affects spell check)
set syntax=ON
" disable with :set syntax off
" enable with :set syntax enable (retain your current color settings)

" spell check always enabled with en_us
set spell spelllang=en_us
" disable with               :set nospell
" enable with                :set spell
" search next with           ]s
" search previous with       [s
" suggest with               z=
" Insert mode completions    CTRL-X CTRL-O / CTRL-X s / CRTL-N / CTRL-P

" Enable spell checking for markdown/txt files
" autocmd BufRead *.md setlocal spell spelllang=en_us
" autocmd BufRead *.txt setlocal spell spelllang=en_us

" make vim copy buffer bigger (default 50 lines: viminfo='100,<50,s10,h)
set viminfo='100,<5000,s100,h

" Uncomment if use secure modeline plug-in
"set nomodeline

" Basic precaution
if $USER == "root"
 set noswapfile
else
 set swapfile
endif
" filler to avoid the line above being recognized as a modeline
" filler
" filler
