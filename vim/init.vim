syntax on
set encoding=utf-8
set number
set hlsearch
set ignorecase
set relativenumber
set incsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set clipboard+=unnamedplus
"set runtime path
set rtp+=~/.fzf
set rtp+=~/.vim/bundle/Vundle.vim

"Plug
call plug#begin('~/.vim/plugged')
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()	

"Vundle
call vundle#begin()
Plugin 'lifepillar/vim-gruvbox8'
Plugin 'junegunn/fzf.vim' 
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
call vundle#end()

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
nnoremap <C-]> *:Tags <C-R><C-W><CR>
nnoremap <C-\> :Rg <CR>
nnoremap <C-f> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap zf  zf%<CR> "% mean jump to match bracket

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
"hello world!
