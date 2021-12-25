syntax on
set encoding=utf-8
set number
set foldmethod=manual
"用来显示底部状态
set laststatus=2
"用来关闭 Hit Enter to Continue
set shortmess=a
set hlsearch
set backspace=2
set mouse=a
set ignorecase
" ./tags表示当前目录下的tags，分号表示向上搜索
set tags=./tags;,.tags
set relativenumber
set incsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set expandtab	"表示缩进用空格来表示
set showcmd
set colorcolumn=150
set textwidth=110
"set cursorline
set clipboard+=unnamedplus
"set runtime path
set rtp+=~/.fzf
set rtp+=~/.vim/bundle/Vundle.vim

call plug#begin('~/.vim/plugged')
Plug 'phaazon/hop.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'Yggdroot/indentLine'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'dhruvasagar/vim-table-mode'
Plug 'lifepillar/vim-gruvbox8'
Plug 'junegunn/fzf.vim' 
Plug 'godlygeek/tabular'
Plug 'ludovicchabant/vim-gutentags'
Plug 'dracula/vim'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'junegunn/vim-easy-align'
Plug 'lfv89/vim-interestingwords'
Plug 'mhinz/vim-signify'
Plug 'roxma/vim-tmux-clipboard'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'vim-scripts/taglist.vim'
Plug 'zackhsi/fzf-tags'
Plug 'karb94/neoscroll.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

"vim-signify
set updatetime=100
"theme
"colo gruvbox8_hard
"let g:airline_theme='gruvbox8'
colo dracula
let g:airline_theme='dracula'

"cscope
"source /home/lqb/.vim/plugged/cscope_maps.vim

"Map Command
nnoremap P "*p<CR>
"Fzf configuration
" * mean highlight the word that are pointed by cursor.
" :Tags mean use Tags function from fzf,
" <C-R>a mean insert a content from register a in nomal mode.
" <C-W> mean the word that are pointed by cursor.

nnoremap * *N
nnoremap <C-p> *N:Tags <C-R><C-W><CR>
"nmap <C-p> <Plug>(fzf_tags)
nnoremap <C-g> *N:Rg <CR>
nnoremap <C-f> :Files<CR>
nnoremap <C-b> :Buffers<CR>
"% mean jump to match bracket
nnoremap zf  zf%
nnoremap f :HopChar1<CR>
nnoremap <F2> :BTags<CR>

lua require'hop'.setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }

" :help command to see detail
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   "rg --column -s -w --type-add 'cmd:*.cmd' -tc -tpy -tcmd -th -tcpp --line-number --no-heading --color=always -- ".shellescape(expand('<cword>')), 1,
\   fzf#vim#with_preview(), <bang>0)

"fzf-tags fuzzy search
noreabbrev <expr> ts getcmdtype() == ":" && getcmdline() == 'ts' ? 'FZFTselect' : 'ts'

"--smart-case 

"Coc.Nvim
"set updatetime=300

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped
"by other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : \<C-h>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" enable this plugin for filetypes, '*' for all files.
 let g:apc_enable_ft = {'*':1}
"
" " source for dictionary, current or other loaded buffers, see ':help cpt'
 set cpt=.,k,w,b
"
" " don't select the first item.
 set completeopt=menu,menuone,noselect
"
" " suppress annoy messages.
 set shortmess+=c

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
 let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project','.accurev','.lqb']
 let g:airline#extensions#gen_tags#enabled = 1
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

"配置ale
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_sign_error = "\ue009\ue009"
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta

"Taglist
let Tlist_WinWidth = 60

lua require('neoscroll').setup({mappings = {'<C-0>', '<C-)>', '<C-u>', '<C-d>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},}) 

"indentLine
let g:indentLine_color_term = 202
let g:indentLine_char_list = ['|', '¦', '┆', '┊']


"interestingwords
nnoremap <silent> K :call InterestingWords('n')<cr>
vnoremap <silent> K :call InterestingWords('v')<cr>
nnoremap <silent> <F3> :call UncolorAllWords()<cr>
nnoremap <silent> n :call WordNavigation(1)<cr>
nnoremap <silent> N :call WordNavigation(0)<cr>

"table 
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']
let g:interestingWordsRandomiseColors = 1

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

"  vim-multiple-cursors
"按键映射前缀: <leader>v。
let g:VM_maps = {}                            "取消默认按键映射。
let g:VM_maps['Find Under']         = '<c-n>' "进入多光标模式并选中光标下字符串。
let g:VM_maps['Find Subword Under'] = '<c-n>' "选中下一个字符串。
let g:VM_maps['Find Next']          = 'n'     "往下查找并增加光标。
let g:VM_maps['Find Prev']          = 'N'     "网上查找并增加光标。
let g:VM_maps['Skip Region']        = 'q'     "跳过当前光标到下一个。
let g:VM_maps['Remove Region']      = 'Q'     "取消当前光标。
let g:VM_maps['Select All']         = '\vA'   "进入多光标模式并选中所有同光标下的字符串。
let g:VM_maps['Undo']               = 'u'     "Undo.
let g:VM_maps['Redo']               = '<c-r>' "Redo.

" tabular
nmap <F4> :Tabularize /
vmap <F4> :Tabularize /
