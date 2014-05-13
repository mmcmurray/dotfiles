set nocompatible              " be iMproved
filetype off                  " required!
syntax enable

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"===================
"  VUNDLE/PLUGINS      
"===================
" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'

"Plugin 'tpope/vim-fugitive'
"Plugin 'Lokaltog/vim-easymotion'
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"Plugin 'L9'
"Plugin 'FuzzyFinder'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"===================
"  PLUGIN OPTIONS     
"===================

"airline/powerline
let g:airline_powerline_fonts=1
set laststatus=2
set noshowmode

"solarized
call togglebg#map("<F5>")
let g:solarized_bold=0
"let g:solarized_termcolors=256
set background=light
colorscheme solarized

"===================
"   VIM SETTINGS
"===================

"quick change modes
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

