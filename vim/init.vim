let mapleader="\<SPACE>"
set laststatus=2
set shortmess=a
set hlsearch
set backspace=2
set ignorecase
set tags=./tags;,.tags
set number
"set relativenumber
set incsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set expandtab
set showcmd
set cursorline
set colorcolumn=120
set textwidth=120
set clipboard+=unnamedplus
set rtp+=~/.fzf
tnoremap <F1> <C-\><C-n>
nnoremap <M-]> <C-]>
nnoremap <M-o> <C-o>
nnoremap <M-w> <C-w>

call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'zackhsi/fzf-tags'
"Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plug 'phaazon/hop.nvim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"yang file
Plug 'nathanalderson/yang.vim'

"highlight
Plug 'lfv89/vim-interestingwords'
Plug 'frazrepo/vim-rainbow'

"align
Plug 'Chiel92/vim-autoformat'
Plug 'junegunn/vim-easy-align'
Plug 'Yggdroot/indentLine'

Plug 'karb94/neoscroll.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'roxma/vim-tmux-clipboard'

"Theme
"Plug 'lifepillar/vim-gruvbox8'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

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

"vim-autoformat
let g:autoformat_verbosemode=1
let g:python3_host_prog="/usr/bin/python3"
nmap <F5> :Autoformat<CR>
vmap <F5> :Autoformat<CR>

set background=dark
colo gruvbox
let g:gruvbox_italic=1

nnoremap * *N
nnoremap <M-p> *N:Tags <C-R><C-W><CR>
"nmap <C-p> <Plug>(fzf_tags)
nnoremap <M-g> *N:Rg <CR>
nnoremap <M-f> :Files<CR>
nnoremap <M-b> :Buffers<CR>
"% mean jump to match bracket
nnoremap zf  zf%
nnoremap f :HopChar1<CR>
nnoremap <F2> :BTags<CR>

lua require'hop'.setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }
"nnoremap dd  cc<Escape>kJ

" :help command to see detail
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   "rg --column -s -w --type-add 'cmd:*.cmd' --type-add 'sh:*.sh' --type-add 'mk:*.mk' -tsh -tc -tpy -tcmd -th -tmk -tcpp
            \   --line-number --no-heading -j9 --line-buffered 
            \   --color=always -- ".shellescape(expand('<cword>')), 1,
            \   fzf#vim#with_preview(), <bang>0)

"fzf-tags fuzzy search
noreabbrev <expr> ts getcmdtype() == ":" && getcmdline() == 'ts' ? 'FZFTselect' : 'ts'

"fzf-preview
let g:fzf_preview_window = ['right:60%', 'ctrl-/']

"Coc.Nvim
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
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


lua require('neoscroll').setup()

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

"  vim-multiple-cursors
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

" tabular
nmap <F4> :Tabularize /
vmap <F4> :Tabularize /

"neovim Tabline 
" In your init.lua or init.vim
