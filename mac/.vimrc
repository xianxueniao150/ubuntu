call plug#begin()
Plug 'mbbill/undotree'
Plug 'farmergreg/vim-lastplace'
" store session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'lifepillar/vim-cheat40'
Plug 'tomtom/tcomment_vim'
" 可以快速对齐的插件
Plug 'junegunn/vim-easy-align'
" 用来提供一个导航目录的侧边栏
Plug 'preservim/nerdtree'
" 可以使 nerdtree Tab 标签的名称更友好些
Plug 'jistr/vim-nerdtree-tabs'
" 可以在导航目录中看到 git 版本信息
Plug 'Xuyuanp/nerdtree-git-plugin'
" 查看当前代码文件中的变量和函数列表的插件，
" 可以切换和跳转到代码中对应的变量和函数的位置
" 大纲式导航, Go 需要 https://github.com/jstemmer/gotags 支持
Plug 'majutsushi/tagbar'
" 自动补全括号的插件，包括小括号，中括号，以及花括号
Plug 'jiangmiao/auto-pairs'
" Vim状态栏插件，包括显示行号，列号，文件类型，文件名，以及Git状态
Plug 'vim-airline/vim-airline'
" 有道词典在线翻译
Plug 'ianva/vim-youdao-translater'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 可以在文档中显示 git 信息
Plug 'airblade/vim-gitgutter'
" 下面两个插件要配合使用，可以自动生成代码块
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" 配色方案
Plug 'KeitaNakamura/neodark.vim'
" colorscheme monokai
Plug 'crusoexia/vim-monokai'
" colorscheme github
Plug 'acarapetis/vim-colors-github'
" colorscheme one
Plug 'rakr/vim-one'
Plug 'chriskempson/base16-vim'

" go 主要插件
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'fatih/vim-go', { 'tag': '*' }
" go 中的代码追踪，输入 gd 就可以自动跳转
Plug 'dgryski/vim-godef'

" markdown 插件
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" 设置括号等自动成双
Plug 'Raimondi/delimitMate'
" 语法错误检查
Plug 'dense-analysis/ale'
" nerdtree 等图标
Plug 'ryanoasis/vim-devicons'
call plug#end()

"==============================================================================
" vim 内置配置 
"==============================================================================

" 设置 vimrc 修改保存后立刻生效，不用在重新打开
" 建议配置完成后将这个关闭
autocmd BufWritePost $MYVIMRC source $MYVIMRC
" 使用 256 颜色库
let base16colorspace=256
" 使用 base16 中 base16-oceanicnext
"colorscheme neodark.vim
set softtabstop=4
set relativenumber
set mouse=a
set wildmode=list:longest
" 关闭兼容模式
set nocompatible
syntax on
set autowrite
" Sets how many lines of history VIM has to remember
set history=500
set cursorline "突出显示当前行
" set cursorcolumn " 突出显示当前列
set showmatch " 显示括号匹配
" 解决插入模式下delete/backspce键失效问题
set backspace=2
set showcmd  "（在右下角）显示现有的命令
" tab 缩进
set tabstop=4 " 设置Tab长度为4空格
set shiftwidth=4 " 设置自动缩进长度为4空格
set autoindent " 继承前一行的缩进方式，适用于多行注释

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
"Always show current position
set ruler
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases 
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch 
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set noswapfile 
" Add a bit extra margin to the left
"set foldcolumn=1

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c\ \[ff=%{&ff}]


let mapleader=";" 

" 退出插入模式指定类型的文件自动保存
au InsertLeave *.go,*.sh,*.php write

" Fast saving
nmap <leader>w :w!<cr>
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>
imap <F3> <esc>:NERDTreeMirror<CR>
imap <F3> <esc>:NERDTreeToggle<CR>
map <F7> :source ~/.vimrc<cr>
nnoremap <CR> a<CR><Esc>
"imap <D-s> <esc>:w<CR>
" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
autocmd FileType help noremap <buffer> q :q<cr>

function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction

noremap <silent> <c-s-k> :call <SID>swap_up()<CR>
noremap <silent> <c-s-j> :call <SID>swap_down()<CR>


set rtp+=/opt/homebrew/opt/fzf

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


"----------------------coc.vim
"Use <Tab> and <S-Tab> to navigate the completion list:
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"



"==============================================================================
" vim-go 插件
"==============================================================================
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_fmt_fail_silently = 1 "保存时不提示错误
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1

let g:godef_split=2

" Status line types/signatures
let g:go_auto_type_info = 1

"au filetype go inoremap <buffer> . .<C-x><C-o>
map <F2> :cnext<CR>
" Ex: `\b` for building, `\r` for running and `\b` for running test.
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" comment
inoremap <c-.> <c-_><c-_>

" undo
if has("persistent_undo")
   let target_path = expand('~/.vim/undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

"airline
let g:airline_powerline_fonts = 1 

"session
let g:session_autosave = 'no'

" nerdtree
"Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
"打开vim时如果没有文件自动打开NERDTree
autocmd vimenter * if !argc()|NERDTree|endif
"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 过滤: 所有指定文件和文件夹不显示
let NERDTreeIgnore = ['\.pyc$', '\.swp', '\.swo', '\.vscode', '__pycache__']


