" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

" lua require('plugins')

lua << EOF
require('packer').startup(function()
	-- Packer can manage itself
	-- use 'jszakmeister/markdown2ctags'
	use 'lvht/tagbar-markdown'
	use 'preservim/tagbar'
	use 'plasticboy/vim-markdown'
	use 'tpope/vim-surround'
	use 'wbthomason/packer.nvim'
	use 'airblade/vim-gitgutter'
	use 'airblade/vim-rooter'
	use 'folke/tokyonight.nvim'
	-- 快捷键提示
	-- use 'spinks/vim-leader-guide'
	use 'liuchengxu/vim-which-key'
	use 'fatih/vim-go'
	use 'glepnir/dashboard-nvim'
	use 'junegunn/fzf'
	use 'junegunn/fzf.vim'
	use {
		'kyazdani42/nvim-tree.lua',
		requires = 'kyazdani42/nvim-web-devicons'
	}
	use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
	use '907th/vim-auto-save'
	use 'farmergreg/vim-lastplace'
	use 'lifepillar/vim-cheat40'
	use 'tomtom/tcomment_vim'
	-- 可以快速对齐的插件
	use 'junegunn/vim-easy-align'
	-- Vim状态栏插件，包括显示行号，列号，文件类型，文件名，以及Git状态
	use 'vim-airline/vim-airline'
	use 'jdhao/better-escape.vim'
	use 'mbbill/undotree'
	-- nerdtree 等图标
	use 'ryanoasis/vim-devicons'
	use {'neoclide/coc.nvim',  branch = 'release'}
end)
EOF

set autochdir      
set foldmethod=syntax
set foldlevel=20
" By default timeoutlen is 1000 ms
set timeoutlen=500

"缩进
set autoindent "按下回车键后，下一行的缩进会自动跟上一行的缩进保持一致
set tabstop=4 " 设置Tab长度为4空格
set shiftwidth=4 "在文本上按下>>的字符数

"外观
set number
set relativenumber
set cursorline "突出显示当前行

"搜索
set showmatch " 显示括号匹配
set hlsearch   " Highlight search results
set incsearch  "每输入一个字符，就自动跳到第一个匹配的结果
set ignorecase

set noswapfile 
set updatetime=100

let mapleader=";" 

" map----------------
" enter 在下一行插入空行
nnoremap <CR> o<Esc>
" space 插入空格
noremap <Space> i<Space><Esc>l
" backspace 删除
noremap <BS> i<BS><Esc>l
" 切换窗口
noremap  <leader>w <c-w>w 
" 首尾切换
noremap <expr>0 col(".")==1?"$":"0"

" command------------
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
autocmd FileType help noremap <buffer> q :q<cr>
autocmd FileType help noremap <buffer> u <c-u>
autocmd FileType help noremap <buffer> d <c-d>

" abbr-----------------
iabbrev class public class{}<esc>i<cr><esc>k$Fsli

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

noremap <silent> <c-s-j> :call <SID>swap_down()<CR>
noremap <silent> <c-s-k> :call <SID>swap_up()<CR>


"----------------------coc.vim
nmap <silent> <F2> <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

"Use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

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

" highlight identifiers
let g:go_auto_sameids = 1
" 禁用K快捷键
let g:go_doc_keywordprg_enabled = 0
"au filetype go inoremap <buffer> . .<C-x><C-o>
" map <F2> :cnext<CR>
" Ex: `\b` for building, `\r` for running and `\b` for running test.
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
" autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap gb  <c-t>

" comment
inoremap <c-.> <c-_><c-_>

"airline
let g:airline_powerline_fonts = 1 

"session
let g:session_autosave = 'no'

" markdown
autocmd Filetype markdown inoremap ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
autocmd Filetype markdown inoremap ,n ---<Enter><Enter>
autocmd Filetype markdown inoremap ,b **** <++><Esc>F*hi
autocmd Filetype markdown inoremap ,s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown inoremap ,i ** <++><Esc>F*i
autocmd Filetype markdown inoremap ,d `` <++><Esc>F`i
autocmd Filetype markdown inoremap ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap ,h ====<Space><++><Esc>F=hi
autocmd Filetype markdown inoremap ,p ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap ,a [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown nnoremap ,1 I#<Space><Esc>
autocmd Filetype markdown inoremap ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown nnoremap m2 I##<Space><Esc>
autocmd Filetype markdown inoremap ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown nnoremap m3 I###<Space><Esc>
autocmd Filetype markdown inoremap ,4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown nnoremap m4 I####<Space><Esc>
autocmd Filetype markdown inoremap ,l --------<Enter>
function! s:MarkCodeBlock() abort
	" Add Markdown code-block delimiters to begin and end of current visual group.
	call append(line("'<")-1, '```')
	call append(line("'>"), '```')
endfunction
xnoremap mc :<c-u>call <sid>MarkCodeBlock()<CR>

function! Zoom ()
	" check if is the zoomed state (tabnumber > 1 && window == 1)
	if tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$') == 1
		let l:cur_winview = winsaveview()
		let l:cur_bufname = bufname('')
		tabclose

		" restore the view
		if l:cur_bufname == bufname('')
			call winrestview(cur_winview)
		endif
	else
		tab split
	endif
endfunction

nmap <leader>z :call Zoom()<CR>


" autosave
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification

" tagbar
let g:tagbar_type_go = {
			\ 'ctagstype' : 'go',
			\ 'kinds'     : [
				\ 'p:package',
				\ 'i:imports:1',
				\ 'c:constants',
				\ 'v:variables',
				\ 't:types',
				\ 'n:interfaces',
				\ 'w:fields',
				\ 'e:embedded',
				\ 'm:methods',
				\ 'r:constructor',
				\ 'f:functions'
				\ ],
				\ 'sro' : '.',
				\ 'kind2scope' : {
					\ 't' : 'ctype',
					\ 'n' : 'ntype'
					\ },
					\ 'scope2kind' : {
						\ 'ctype' : 't',
						\ 'ntype' : 'n'
						\ },
						\ 'ctagsbin'  : 'gotags',
						\ 'ctagsargs' : '-sort -silent'
						\ }

" align
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"escape
" use jj to escape insert mode.
let g:better_escape_shortcut = 'jj'
" set time interval to 200 ms
let g:better_escape_interval = 200



" undo
if has("persistent_undo")
	let target_path = expand('~/.config/nvim/undodir')

	" create the directory and any parent directories
	" if the location does not exist.
	if !isdirectory(target_path)
		call mkdir(target_path, "p", 0700)
	endif

	let &undodir=target_path
	set undofile
endif

"-----------dashboard
" Default value is clap
let g:dashboard_default_executive ='fzf'

"-----------bufferline
" In your init.lua or init.vim
set termguicolors
" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent><leader>n :BufferLineCycleNext<CR>
nnoremap <silent><leader>p :BufferLineCyclePrev<CR>
lua << EOF
require('bufferline').setup {
	options = {
		offsets = {{filetype = "NvimTree"}},
		}
	}
EOF

"-----------map key
"" Define prefix dictionary
let g:which_key_map =  {}
call which_key#register('z', "g:which_key_map")
" nnoremap <silent> z :<c-u>WhichKey 'z'<CR>
noremap zr zR
let g:which_key_map.r = 'expand all'
noremap zm zM
let g:which_key_map.m = 'fold all'
noremap zA za
let g:which_key_map.A = 'toggle'
noremap za zA
let g:which_key_map.a = 'toggle recursively'

"---------theme
" Vim Script
colorscheme tokyonight

" tree
let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:nvim_tree_follow_update_path = 1 "0 by default, will update the path of the current dir if the file is not inside the tree.Default is 0
let g:nvim_tree_indent_markers = 1
nnoremap <leader>t :NvimTreeToggle<CR>
let g:nvim_tree_hide_dotfiles = 1
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_auto_close = 1

" tagbar------------------
nmap <F8> :TagbarToggle<CR>

" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '/opt/homebrew/lib/python3.9/site-packages/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes --sro=»',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '»',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
