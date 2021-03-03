" ---------------------------------------------------- setting ----------------------------------------------------
"  {{{
filetype on "文件类型识别
filetype indent on  "根据文件类型开启缩进
filetype plugin on  "开启根据文件类型加载插件
filetype plugin indent on

let g:netrw_dirhistmax  =0
set nocompatible    "不兼容 vi
set encoding=utf-8  "编码

set nobackup    "不生成备份文件
set noswapfile  "不生成 swp 文件

set undofile    "记录文件修改历史
set undodir=~/.cache/vim/undodir
set undolevels=100

set backspace=indent,eol,start  "backspace 键行为修正

set cursorline  "突出当前行
"set cursorcolumn   "突出当前列

set clipboard+=unnamedplus  "共享系统剪切板
set wrap    "超出行长度的部分分行显示

set number  "开启行号
set relativenumber    "相对行号

set expandtab   "展开 tab 为空格
set shiftwidth=4    "设置缩进宽度为4
set softtabstop=4   "让退格键能删除缩进
set tabstop=4   "设置制表符宽度为4

set hlsearch    "高亮搜索
set ignorecase  "忽略大小写
set incsearch   "边输入边搜索
set smartcase   "大小写都有时,还是大小写敏感

set showmatch   "显示括号匹配
set matchtime=9 "括号匹配短暂跳转时间

set showcmd "命令补全
set wildmenu    "命令补全菜单

set scrolloff=5 "屏幕上下保持五行
set termguicolors   "开启真彩色支持
set t_Co=256

set laststatus=2    "状态栏始终存在,0不显示,1需要时显示
set updatetime=300  "文本刷新时间,默认4000
set hidden  "未保存的 buffer 可以被隐藏
set ruler   "当前位置显示
"set t_ti= t_te=    "退出 vim 后将当前文件打印在终端
set noshowmode  "不显示当前模式
set signcolumn=auto   "标识列自动隐藏,最大2列,设置为 yes 为一直存在.

set shortmess+=c

set timeoutlen=500

set splitright  "向右分屏
set splitbelow  "向下分屏

syntax enable   "开启语法高亮
syntax on   "允许用户用自己的语法高亮

set foldenable
set foldmethod=marker
set foldmarker={{{,}}}
autocmd bufenter $MYVIMRC set foldlevel=2
" }}}


" ---------------------------------------------------- plug ---------------------------------------------------
call plug#begin('~/.config/nvim/plugged')
" {{{


Plug 'neoclide/coc.nvim', {'branch': 'release'}
" {{{
set shortmess+=c
inoremap <silent><expr> <c-space> coc#refresh()
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <expr> <CR> pumvisible() ? "\<c-g>\<cr>" : "\<CR>"

autocmd CursorHold * silent call CocActionAsync('highlight')
" }}}
" mapping{{{
" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
"nmap <leader>r <Plug>(coc-rename)

" }}}
" coc 系列插件{{{
" 代码格式化 prettier{{{
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" }}}

" coc-snippets{{{
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <leader>x for convert visual selected code to snippet
xmap <c-x>  <Plug>(coc-convert-snippet)
nnoremap <c-s> :CocCommand snippets.editSnippets<cr>
" }}}

" go 自动导包
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

let g:coc_global_extensions = [
            \ 'coc-sh',
            \ 'coc-json',
            \ 'coc-prettier',
            \ 'coc-vimlsp',
            \ 'coc-snippets',
            \ 'coc-html',
            \ 'coc-vetur',
            \ 'coc-git',
            \ 'coc-css',
            \ 'coc-phpls',
            \ 'coc-tsserver',
            \ 'coc-marketplace']
" }}}
" npm i eslint eslint-plugin-vue -D

Plug 'alvan/vim-closetag', {'for': ['html', 'vue']}


Plug 'vimwiki/vimwiki'
" {{{
autocmd FileType vimwiki set filetype=markdown
let g:vimwiki_list = [{'path': '~/notes',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_key_mappings =
\ {
\   'all_maps': 1,
\   'global': 1,
\   'headers': 0,
\   'text_objs': 0,
\   'table_format': 0,
\   'table_mappings': 0,
\   'lists': 1,
\   'links': 0,
\   'html': 0,
\   'mouse': 0,
\ }
" }}}

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
" {{{
let g:mapleader = " "
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')
" Define prefix dictionary
let g:which_key_map =  {}

let g:which_key_map.p = {
    \ 'name' : '中文格式修正' ,
    \ 'g' : ['Pangu', '中文格式修正'] ,
    \ }

let g:which_key_map.f = { 'name' : '格式化代码' }

let g:which_key_map.m = {
    \ 'name' : 'markdown' ,
    \ 'p' : ['<Plug>MarkdownPreviewToggle', 'markdown预览'] ,
    \ 't' : '生成目录' , 
    \ }

let g:which_key_map.n = {
    \ 'name' : 'nerdtree' ,
    \ 't' : ['NERDTreeToggle' , 'nerdtree']
    \ }

let g:which_key_map.i = {
    \ 'name' : 'markdown插入剪贴板图片' ,
    \ 'p' : 'markdown插入剪贴板图片'
    \ }

let g:which_key_map.u = {
    \ 'name' : 'undotree' ,
    \ 't' : 'undotree'
    \ }

let g:which_key_map.t = {
    \ 'name' : '翻译' ,
    \ 't' : ['<Plug>TranslateW', '翻译'] ,
    \ 'b' : ['TagbarToggle', 'tagbar'] ,
    \ }

let g:which_key_map.r = {
    \ 'name' : '重命名变量' ,
    \ 'n' : ['<Plug>(coc-rename)', '重命名变量'],
    \ }

" }}}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" 文件查找{{{
" enter 在当前窗口打开, c-t 新标签页打开 c-x c-v 横纵分屏打开
" }}}
" mapping{{{
nmap <silent> <c-p> :Files<cr>
nmap <silent> <c-b> :Buffers<cr>
" }}}

Plug 'voldikss/vim-translator'
" {{{
let g:translator_target_lang = 'zh'
let g:translator_default_engines = ['bing', 'youdao']
" }}}
" mapping{{{
""" Configuration example
" Echo translation in the cmdline
" nmap <silent> <Leader>t <Plug>Translate
" vmap <silent> <Leader>t <Plug>TranslateV
" Display translation in a window
nmap <silent> <Leader>tt <Plug>TranslateW
vmap <silent> <Leader>tt <Plug>TranslateWV
" Replace the text with translation
" nmap <silent> <Leader>tr <Plug>TranslateR
" vmap <silent> <Leader>tr <Plug>TranslateRV
" }}}

Plug 'tpope/vim-commentary'
" 注释{{{
autocmd FileType cpp setlocal commentstring=// %s
autocmd filetype html setlocal commentstring=/*%s*/
" 自动在注释后加个空格
let g:NERDSpaceDelims = 1
" 允许注释空行
let g:NERDCommentEmptyLines = 1
" }}}
" mapping{{{
nnoremap <c-c> :Commentary<cr>
vnoremap <c-c> :Commentary<cr>
" }}}

Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" 多光标操作{{{
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n
" }}}

Plug 'easymotion/vim-easymotion'
" {{{
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap f <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap f <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" }}}

" 外观{{{
Plug 'morhetz/gruvbox'
" 主题{{{
colorscheme gruvbox
hi Normal  ctermfg=252 ctermbg=none guibg=NONE  "随终端透明
" }}}

Plug 'itchyny/lightline.vim'
" 状态条{{{
let g:lightline = {
        \ 'colorscheme': 'gruvbox',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'readonly', 'filename', 'modified', '喵!'] ]
        \ },
        \ 'component': {
        \   '喵!': '>^.^<'
        \ }
        \ }
" }}}

Plug 'gregsexton/matchtag',{ 'for' : ['html','vue'] }
" html 标签匹配 {{{

" }}}

Plug 'ap/vim-css-color',{ 'for' : 'css' }
" css 颜色显示{{{

" }}}

"  Plug 'sheerun/vim-polyglot'
"  " 各语言高亮和缩进{{{
"  
"  " }}}

" }}}

" markdown 文件{{{

Plug 'hotoo/pangu.vim'
" 中文格式修正{{{
autocmd BufWritePre *.markdown,*.md, call PanGuSpacing()
" }}}

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" markdown预览{{{
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = 'google-chrome-stable'

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']
" }}}

Plug 'ferrine/md-img-paste.vim' 
" markdown插入剪贴板图片{{{
"设置默认储存文件夹。这里表示储存在当前文档所在文件夹下的'pic'文件夹下，相当于 ./pic/
let g:mdip_imgdir = 'pic' 
"设置默认图片名称。当图片名称没有给出时，使用默认图片名称
let g:mdip_imgname = 'image'
" }}}
" mapping{{{
"设置快捷键，个人喜欢 Ctrl+p 的方式，比较直观
autocmd FileType markdown nnoremap <silent> <leader>ip :call mdip#MarkdownClipboardImage()<CR>F%i
" }}}

Plug 'mzlogin/vim-markdown-toc'
" markdown目录{{{
let g:vmt_auto_update_on_save = 1
let g:vmt_cycle_list_item_markers = 1
" }}}
" {{{
" 生成 gitbook 类的目录
function! Gtoc()
    normal gg
    :RemoveToc
    :GenTocGFM
endfunction
autocmd filetype markdown nnoremap <silent> <leader>mt <c-[>:exec Gtoc()<cr>
" RemoveToc 删除目录
" UpdateToc 更新目录
" }}}


" }}}

" 扩展窗口插件{{{

Plug 'preservim/tagbar'
" {{{
let g:tagbar_width = 30
let g:tagbar_sort = 0
" }}}
" mapping{{{
" nnoremap <leader>tb :TagbarToggle<cr>
" }}}


Plug 'preservim/nerdtree',{ 'on' : 'NERDTreeToggle' }
" {{{
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeWinSize=20 
" }}}
" mapping{{{
" }}}


Plug 'mbbill/undotree',{ 'on' : 'UndotreeToggle' }
" undofile 可视化{{{
" }}}
" mapping{{{
nmap <leader>ut : UndotreeToggle<cr>
" }}}

" }}}



" 不用管的插件{{{

Plug 'ludovicchabant/vim-gutentags', {'for' : ['go', 'cpp']}
" {{{
set tags=./.tags;,.tags "ctags配置
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
" }}}


Plug 'tpope/vim-surround'
" 包围符号操作{{{

" }}}


Plug 'gcmt/wildfire.vim'
" 智能选择文本对象{{{
let g:wildfire_objects = {
    \ "*" : ["iw","i'", 'i"', "i)", "i]", "i}"],
    \ "html,xml" : ["iw","i'", 'i"', "i)", "i]", "i}","at", "it"],
\ }
" }}}
" mapping{{{
" This selects the next closest text object.
" map <SPACE> <Plug>(wildfire-fuel)
" This selects the previous closest text object.
" vmap <C-SPACE> <Plug>(wildfire-water)
" }}}

" }}}

call plug#end()
" }}}

" ---------------------------------------------------- autocmd ---------------------------------------------------
"  {{{
" autocmd bufwritepost $MYVIMRC source % "修改配置文件保存后自动加载
" autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exec "normal!g'\"" | endif   "光标复位
" autocmd BufEnter * silent! lcd %:p:h    "打开文件时切换到文件所在的路径

" 输入法{{{
let s:fcitx_cmd = executable("fcitx5-remote") ? "fcitx5-remote" : "fcitx-remote"
autocmd InsertLeave * let b:fcitx = system(s:fcitx_cmd) | call system(s:fcitx_cmd.' -c')
autocmd InsertEnter * if exists('b:fcitx') && b:fcitx == 2 | call system(s:fcitx_cmd.' -o') | endif
" }}}

" }}}



" ---------------------------------------------------- mapping ---------------------------------------------------
"  {{{
nnoremap <F7> <esc>:tabnew $MYVIMRC<cr>
let mapleader=" "
nmap // :nohlsearch<cr>
nnoremap <c-a> <Esc>ggvG$
nmap Q :bdelete<cr>

" 光标移动优化{{{
noremap H 0
noremap J 5j
noremap K 5k
noremap L $
noremap n nzz
noremap N Nzz
nnoremap j gj
nnoremap k gk
inoremap <c-j> <c-[>la
" }}}

" tab{{{
nnoremap <c-t> :tabnew<cr>
nnoremap <c-w> :tabclose<cr>
nnoremap <c-k> :tabnext<cr>
nnoremap <c-j> :tabprevious<cr>
" }}}

" 窗口跳转{{{
nnoremap <a-h> <c-w>h
nnoremap <a-j> <c-w>j
nnoremap <a-k> <c-w>k
nnoremap <a-l> <c-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
" }}}

" 终端设置{{{
autocmd TermOpen * startinsert
autocmd TermOpen * setlocal statusline=%{b:term_title}
nnoremap <a-t> :terminal<cr>
tnoremap <A-n> <C-\><C-n>
tnoremap <A-q> <C-\><C-n>:bdelete!<cr>
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
" }}}

" 不同编程语言 mapping{{{
autocmd filetype html map <buffer> <F5> :w<cr>:!firefox --new-window %:p &<cr><cr>

nnoremap <F5> :call CodeRun()<cr>
cnoremap su w !sudo tee %
function! CodeRun()
    exec "w"
    if &filetype == 'go'
        set splitbelow
        :split
        :resize 8
        :term go run %
    endif
    if &filetype == 'javascript'
        :!node %
    endif
endfunction

autocmd filetype go nmap <buffer> <leader>f :w<cr>:!gofmt -w %<cr><cr>:e!<cr>
autocmd filetype javascript,css,json,typescript,html,md nmap <buffer> <leader>f :Prettier<cr>
autocmd filetype html,vue nnoremap > 0f>
" }}}

" }}}
