set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

"plugin list
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'taglist.vim'
Plugin 'ervandew/supertab'
Plugin 'vim-airline/vim-airline'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/fzf.vim' 

"color 
"Plugin 'altercation/solarized'

call vundle#end()            " required
filetype plugin on

" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to


nmap <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
imap <F5> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
set tags=tags
set tags+=./tags "add current directory's generated tags file 
"set tags+=/home/lhh/workspace/ldmud/tags "add new tags file(刚刚生成tags的路径，在ctags -R 生成tags文件后，不要将tags移动到别的目录，否则ctrl+］时，会提示找不到源码文件) 
"set tags+=/home/lhh/workspace/MudOS_v21/tags "add new tags file(刚刚生成tags的路径，在ctags -R 生成tags文件后，不要将tags移动到别的目录，否则ctrl+］时，会提示找不到源码文件) 
nmap <F6> <C-P>
nmap <F7> :NERDTreeToggle<CR>
imap <F7> <ESC>:NERDTreeToggle<CR>
nmap <F8> :TlistToggle<CR>
imap <F8> <ESC>:TlistToggle<CR>
nmap <C-X> :w<CR>
imap <C-X> <ESC>:w<CR>
"nmap <F9> :TlistToggle"<CR>
nmap <F9> <C-O>
nmap <F10> <C-]>


" nerdtree 
" vim打开文件时自动打开
" autocmd vimenter * NERDTree
" vim没有指定文件时自动打开
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"ctrlp 配置
let g:NERDTreeChDirMode = 2 
let g:ctrlp_working_path_mode = 'rw' 
let g:ctrlp_max_depth = 40
let g:ctrlp_max_files = 50000
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

"ag 配置
let g:ag_prg="ag --vimgrep --smart-case --column"
let g:ag_highlight=1

syntax enable
"set background=light
"colorscheme solarized

" 编码格式
set expandtab " 把tab转换成空格
set tabstop=4 " 空格数量是4
set shiftwidth=4 " 自动缩进的宽度

" 编译单个文件
nmap <F11> :call DoOneFileCompile()<CR>
imap <F11> <ESC>:w<CR>:call DoOneFileCompile()<CR>
function DoOneFileCompile()
    if &filetype!="c"
        echo "this file isn't lpc file，can not be compiled.."
        return
    endif

    let path=getcwd()
    let num=match(path, "logic")
    let path=strpart(path, num)
    if path!="logic"
        echo "please first move to root logic dir，then push F11 to compile.."
        return
    endif
    
    let curpath=getcwd()
    let fullpath=expand("%:p")
    let len=strlen(curpath) 
    let filepath=strpart(fullpath, len)
    echo filepath
    execute "!./../engine/engine.nostrip -L -hchenyh-261 -r ".filepath
    "execute "!./../engine/engine -r ".filepath
endfunction

" 热更单个文件
nmap <F12> :call DoOneFileUpdate()<CR>
imap <F12> <ESC>:w<CR>:call DoOneFileUpdate()<CR>
function DoOneFileUpdate()
    if &filetype!="c"
        echo "this file isn't lpc file，can not be compiled.."
        return
    endif

    let path=getcwd()
    let num=match(path, "logic")
    let path=strpart(path, num)
    if path!="logic"
        echo "please first move to root logic dir，then push F11 to compile.."
        return
    endif
    
    let curpath=getcwd()
    let fullpath=expand("%:p")
    let len=strlen(curpath) 
    let filepath=strpart(fullpath, len)
    execute "!echo ".filepath." > etc/autoupdate"
endfunction


" to make ctrlp more faster
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
    let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

set nu                                                                                                                                                       
set nobackup
set cursorline
set ruler
set autoindent
set hlsearch 

if has("cscope")  
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set csverb
    set cspc=3
    if filereadable(".tags/cscope.out")
        silent cs add .tags/cscope.out
    else
        let cscope_file=findfile(".tags/cscope.out", ".;")  
        if !empty(cscope_file) && filereadable(cscope_file)  
            exe "cs add" cscope_file 
        endif        
    endif  
endif  

let Tlist_Use_Right_Window = 1 
"let Tlist_Auto_Open = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_One_File = 1
set nocompatible
set bs=2

if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

colorscheme desert
let g:airline_powerline_fonts = 1 


"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%] "显示文件名：总行数，总的字符数
"#set ruler "在编辑过程中，在右下角显示光标位置的状态行


" 状态栏
" set laststatus=2      " 总是显示状态栏
" highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
" 获取当前路径，将$HOME转化为~
function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction
set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \\|%=\|\ %l,%c\ %p%%\ \|\ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\%{$USER}\ @\ %{hostname()}\
