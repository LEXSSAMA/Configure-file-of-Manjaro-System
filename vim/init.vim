set number
set incsearch
set expandtab
set hlsearch
set ignorecase
set cursorline
set mouse=
set nowrap

let mapleader   ="\<SPACE>"
set tags        =./tags,tags;$HOME
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set colorcolumn =150
set textwidth   =150
set rtp        +=/usr/bin/fzf

nnoremap <F10> :cd /data/lqb/REL_8_10_X_INT<CR>

call plug#begin('~/.config/nvim/plugged')
""""""""""Theme Begin""""""""""""""""""""
Plug 'morhetz/gruvbox' "Theme
Plug 'sainnhe/everforest'
Plug 'aonemd/quietlight.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'preservim/vim-colors-pencil'
""""""""""Theme End""""""""""""""""""""

Plug 'roxma/vim-tmux-clipboard' "tmux
Plug 'phaazon/hop.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'lfv89/vim-interestingwords'
Plug 'frazrepo/vim-rainbow'
Plug 'mhinz/vim-startify'
"Plug 'nvim-tree/nvim-web-devicons'
Plug 'Chiel92/vim-autoformat'
Plug 'mbbill/undotree'
Plug 'godlygeek/tabular'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dhruvasagar/vim-table-mode'
call plug#end()

"neoscroll.nvim"
lua require('neoscroll').setup()

"hop.nvim"
nnoremap f :HopChar1<CR>
lua require'hop'.setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }

"Theme"
set t_Co=256
set termguicolors
set background=dark " or light if you want light mode
"set background=light " or light if you want light mode
"colorscheme dracula 
"colorscheme quietlight
colorscheme gruvbox
let g:gruvbox_italic=1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"vim-multiple-cursors"
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<M-n>'
let g:VM_maps['Find Subword Under'] = '<M-n>'
let g:VM_maps['Find Next']          = 'n'
let g:VM_maps['Find Prev']          = 'N'
let g:VM_maps['Skip Region']        = 'q'
let g:VM_maps['Remove Region']      = 'Q'
let g:VM_maps['Select All']         = '\vA'
let g:VM_maps['Undo']               = 'u'     "Undo.
let g:VM_maps['Redo']               = '<M-r>' "Redo.

"interestingwords"
nnoremap <silent> K    : call InterestingWords('n')<cr>
vnoremap <silent> K    : call InterestingWords('v')<cr>
nnoremap <silent> <F3> : call UncolorAllWords()<cr>
nnoremap <silent> n    : call WordNavigation(1)<cr>
nnoremap <silent> N    : call WordNavigation(0)<cr>
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']
let g:interestingWordsRandomiseColors = 1

"autoformat
let g:python3_host_prog="/usr/bin/python3"
let g:formatters_python = ['black']
nmap <F5> :Autoformat<CR>
vmap <F5> :Autoformat<CR>

"vim-ranbow
let g:rainbow_active = 1
let g:rainbow_load_separately = [
            \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
            \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
            \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
            \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
            \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

"UndoTree"
nnoremap <leader>u :UndotreeToggle<CR>
silent !mkdir -p $HOME/.config/nvim/tmp/backup
silent !mkdir -p $HOME/.config/nvim/tmp/undo
"silent !mkdir -p $HOME/.config/nvim/tmp/sessions
set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/backup,.
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.config/nvim/tmp/undo,.
endif

let g:undotree_DiffAutoOpen       = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators    = 1
let g:undotree_WindowLayout       = 1
let g:undotree_DiffpanelHeight    = 10
let g:undotree_SplitWidth         = 24

function g:Undotree_CustomMap()
    nmap <buffer> u   <plug>UndotreeNextState
    nmap <buffer> d   <plug>UndotreePreviousState
    nmap <buffer> U 5 <plug>UndotreeNextState
    nmap <buffer> D 5 <plug>UndotreePreviousState
endfunc

"tabular"
nnoremap <F4> :Tabularize /
vnoremap <F4> :Tabularize /

"indentLine"
let g:indentLine_color_term = 202
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

"fzf.vim"
let g:fzf_preview_window = ['up:65%:wrap','ctrl-/']
command! -bang -nargs=* Rg
            \ call fzf#vim#grep("rg --sort none  --vimgrep -s -w --type-add 'cmd:*.cmd' --type-add 'sh:*.sh'
            \   --type-add 'mk:*.mk' -tsh -tc -tpy -tcmd -th -tmk -tcpp 
            \   --threads 9 --line-buffered --color=auto 
            \   --mmap -U -- ".shellescape(expand('<cword>')), 1,
            \   fzf#vim#with_preview({'options': ['--height=70%','--bind=alt-j:down,alt-k:up']}), <bang>0)
nnoremap <M-g> *N :Rg <CR>

nnoremap <M-f> :Files<CR>
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--bind=alt-j:down,alt-k:up']}), <bang>0)

"fzf-preview"
let g:fzf_preview_floating_window_rate = 0.9
let g:fzf_preview_default_fzf_options  = {'--preview-window': 'right:65%:cycle' ,'--bind':'alt-j:down,alt-k:up'}
let g:fzf_preview_grep_cmd             = 'rg --line-number --no-heading --color=never --hidden --threads 9'
let g:fzf_preview_command              = 'bat --color=always --plain{-1} -m '
let g:fzf_preview_cache_directory      = expand('~/.cache/vim/fzf_preview')
let g:fzf_preview_direct_window_option = ''
let g:fzf_preview_buffers_jump         = 0

nnoremap <silent> <leader>/ :<C-u>FzfPreviewLines --add-fzf-arg=-e --add-fzf-arg=--no-sort --add-fzf-arg=--query=""<CR>"'"

"fzf-tags"
nnoremap <F2> :BTags<CR>
nnoremap <M-b> :Buffers<CR>

"Airline
let g:airline_theme='google_dark'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_z = ''
let g:airline_section_x = ''

"coc.nvim"
set encoding   =utf-8
set updatetime =300
set signcolumn =yes
set nobackup
set nowritebackup

inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <leader>rn  <Plug>(coc-rename)
" GoTo code navigation

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

set signcolumn=number

"autocmd CursorHold * silent call CocActionAsync('highlight')

"Ctags"
nnoremap <M-]> <C-]>
nnoremap <M-t> <C-t>
nnoremap <M-o> <C-o>

"vim-table-mode
"let b:table_mode_corner='+'
let g:table_mode_corner_corner='+'
let g:table_mode_corner='+'

"alpha-nvim
"lua require('alpha').setup(require'alpha.themes.startify'.config)


