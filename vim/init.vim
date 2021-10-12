syntax on
set encoding=utf-8
set colorcolumn=130
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set runtime path
set rtp+=~/.fzf
set rtp+=~/.vim/bundle/Vundle.vim
set clipboard+=unnamedplus

set number
set hlsearch
set ignorecase
set relativenumber
set incsearch
set expandtab
set autoindent
set updatetime=100

"Plug
call plug#begin('~/.vim/plugged')
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/vim-easy-align'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mhinz/vim-signify'
Plug 'phaazon/hop.nvim'
Plug 'lifepillar/vim-gruvbox8'
Plug 'junegunn/fzf.vim' 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()	

"theme
colo gruvbox8_hard
let g:airline_theme='gruvbox8'

"cscope
"source /home/lqb/.config/nvim/autoload/cscope.vim

"Map Command
nnoremap P "*p<CR>
"Fzf configuration
" * mean highlight the word that are pointed by cursor.
" :Tags mean use Tags function from fzf,
" <C-R>a mean insert a content from register a in nomal mode.
" <C-W> mean the word that are pointed by cursor.
nnoremap <C-g> *N:Tags <C-R><C-W><CR>
nnoremap <C-\> *N:Rg <CR>
nnoremap <C-f> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap zf  zf%<CR> "% mean jump to match bracket
nnoremap f :HopChar1<CR>

lua require'hop'.setup { keys = 'asdfhjkqweruiopyxcvbnmlg' }

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" :help command to see detail
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always -- '.shellescape(expand('<cword>')), 1,
  \   fzf#vim#with_preview(), <bang>0)
"--smart-case 
"Coc.Nvim
set updatetime=300

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

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
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

"hello world!

