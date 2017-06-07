set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'elzr/vim-json'
Plugin 'scrooloose/nerdtree'
Plugin 'saltstack/salt-vim'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'tpope/vim-markdown'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'altercation/vim-colors-solarized'
Plugin 'flazz/vim-colorschemes'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
""Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on

set ts=4
set sw=4
set et

set bg=dark
"colorscheme solarized
colorscheme molokai
"set t_Co=256                        " force vim to use 256 colors
"let g:solarized_termcolors=256      " use solarized 256 fallback
set tabstop=4
set shiftwidth=4
set nowrap
set number
set et
let mapleader = ' '

"set t_kb=^?

"Syntax highlighting only for enhanced-vi
"if has("terminfo")
"syntax on
"endif
"
""Set a statusbar
set statusline=~

let g:NumberToggleTrigger="<C-l>"

"I know it's horrible for a vi master but useful for newbies.
"imap <C-a> <Esc>I
"imap <C-e> <ESC>A
"map <C-Tab> <C-W>w
"imap <C-Tab> <C-O><C-W>w
"cmap <C-Tab> <C-C><C-Tab>
"
""Some macros to manage the buffer of vim
map <F5> :bp<C-M>
map <F6> :bn<C-M>
map <F7> :bd<C-M>
"" NerdTree Toggle
map <C-n> :NERDTreeToggle<CR>
"let NERDTreeQuitOnOpen = 1

nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

set splitbelow
set splitright

"Default backspace like normal
"set bs=2
"
""Terminal for 80 char ? so vim can play till 79 char.
"set textwidth=79
"
""Some option desactivate by default (remove the no).
set nobackup
"set nohlsearch
set hlsearch
set noincsearch

"Display a status-bar.
""set laststatus=2

"Show the position of the cursor.
set ruler

"Show matching parenthese.
set showmatch

function! StartUp()     
    if !exists("s:std_in") && 0 == argc()
        NERDTree
    end
endfunction

"" Gzip and Bzip2 files support
" Take from the Debian package and the exemple on $VIM/vim_exemples
if has("autocmd")

    "autocmd vimenter * NERDTree
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown

    "" Only open NerdTree if a file is not defined.
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * call StartUp()

" Set some sensible defaults for editing C-files
augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For *.c and *.h files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd BufRead *       set formatoptions=tcql nocindent comments&
  autocmd BufRead *.c,*.h set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
augroup END

" Also, support editing of gzip-compressed files. DO NOT REMOVE THIS!
" This is also used when loading the compressed helpfiles.
augroup gzip
  " Remove all gzip autocommands
  au!

  " Enable editing of gzipped files
  "   read: set binary mode before reading the file
  "     uncompress text in buffer after reading
  "  write: compress file after writing
  " append: uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre    *.gz set bin
  autocmd BufReadPre,FileReadPre    *.gz let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost  *.gz '[,']!gunzip
  autocmd BufReadPost,FileReadPost  *.gz set nobin
  autocmd BufReadPost,FileReadPost  *.gz let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost  *.gz execute ":doautocmd BufReadPost " . %:r

  autocmd BufWritePost,FileWritePost    *.gz !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost    *.gz !gzip <afile>:r
augroup END

augroup bzip2
  " Remove all bzip2 autocommands
  au!

  " Enable editing of bzipped files
  "       read: set binary mode before reading the file
  "             uncompress text in buffer after reading
  "      write: compress file after writing
  "     append: uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre        *.bz2 set bin
  autocmd BufReadPre,FileReadPre        *.bz2 let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost      *.bz2 set cmdheight=2|'[,']!bunzip2
  autocmd BufReadPost,FileReadPost      *.bz2 set cmdheight=1 nobin|execute ":doautocmd BufReadPost " . %:r
  autocmd BufReadPost,FileReadPost      *.bz2 let &ch = ch_save|unlet ch_save

  autocmd BufWritePost,FileWritePost    *.bz2 !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost    *.bz2 !bzip2 <afile>:r

  autocmd FileAppendPre                 *.bz2 !bunzip2 <afile>
  autocmd FileAppendPre                 *.bz2 !mv <afile>:r <afile>
  autocmd FileAppendPost                 *.bz2 !mv <afile> <afile>:r
  autocmd FileAppendPost                *.bz2 !bzip2 -9 --repetitive-best <afile>:r
augroup END

endif " has ("autocmd")

"  if &background == "dark"
"    hi Comment      term=underline                      ctermfg=DarkRed     guifg=#FFFFFF
"    hi Constant     term=underline                      ctermfg=Magenta     guifg=#ffa0a0
"    hi Special      term=bold                           ctermfg=DarkRed     guifg=Orange
"    hi Identifier   term=underline                      ctermfg=DarkCyan    guifg=#40ffff   gui=bold
"    hi Statement    term=bold                           ctermfg=Yellow      guifg=#ffff60   gui=bold
"    hi PreProc      term=underline                      ctermfg=LightBlue   guifg=#ff80ff
"    hi Type         term=underline                      ctermfg=DarkCyan    guifg=#60ff60   gui=bold
"    hi Ignore                       ctermfg=black       guifg=bg
"  else
"    hi Comment      term=bold       ctermfg=DarkBlue    guifg=Blue
"    hi Constant     term=underline  ctermfg=DarkRed     guifg=Magenta
"    hi Special      term=bold       ctermfg=DarkMagenta guifg=SlateBlue
"    hi Identifier   term=underline  ctermfg=DarkCyan    guifg=DarkCyan
"    hi Statement    term=bold       ctermfg=Brown       guifg=Brown     gui=bold
"    hi PreProc      term=underline  ctermfg=DarkMagenta guifg=Purple
"    hi Type         term=underline  ctermfg=DarkGreen   guifg=SeaGreen  gui=bold
"    hi Ignore                       ctermfg=white       guifg=bg
"  endif
"  hi Error          term=reverse    ctermbg=Red     ctermfg=White   guibg=Red       guifg=White
"  hi Todo           term=standout   ctermbg=Yellow  ctermfg=Black   guibg=Yellow    guifg=Blue
"
"  if &background == "dark"
"    hi Comment      term=underline                      ctermfg=DarkRed     guifg=#FFFFFF
"    hi Constant     term=underline                      ctermfg=Magenta     guifg=#ffa0a0
"    hi Special      term=bold                           ctermfg=DarkRed     guifg=Orange
"    hi Identifier   term=underline                      ctermfg=DarkCyan    guifg=#40ffff   gui=bold
"    hi Statement    term=bold                           ctermfg=DarkRed      guifg=#ffff60   gui=bold
"    hi PreProc      term=underline                      ctermfg=LightBlue   guifg=#ff80ff
"    hi Type         term=underline                      ctermfg=DarkCyan    guifg=#60ff60   gui=bold
"    hi Ignore                       ctermfg=black       guifg=bg
"  else
"    hi Comment      term=bold       ctermfg=DarkBlue    guifg=Blue
"    hi Constant     term=underline  ctermfg=DarkRed     guifg=Magenta
"    hi Special      term=bold       ctermfg=DarkMagenta guifg=SlateBlue
"    hi Identifier   term=underline  ctermfg=DarkCyan    guifg=DarkCyan
"    hi Statement    term=bold       ctermfg=Brown       guifg=Brown     gui=bold
"    hi PreProc      term=underline  ctermfg=DarkMagenta guifg=Purple
"    hi Type         term=underline  ctermfg=DarkBlue   guifg=SeaGreen  gui=bold
"    hi Ignore                       ctermfg=white       guifg=bg
"  endif
"  hi Error          term=reverse    ctermbg=Red     ctermfg=White   guibg=Red       guifg=White
"  hi Todo           term=standout   ctermbg=DarkRed  ctermfg=Black   guibg=Yellow    guifg=Blue

syntax match nonascii "[^\x00-\x7F]"
highlight nonascii guibg=Red ctermbg=2
