vim.o.hidden         = true
vim.o.backup         = false
vim.o.writebackup    = false
vim.o.updatetime     = 300
vim.o.expandtab      = true
vim.o.number         = true
vim.o.softtabstop    = 4
vim.o.relativenumber = true
vim.o.shiftwidth     = 4
vim.o.tabstop        = 4
vim.o.incsearch      = true
vim.o.ignorecase     = true
vim.o.cursorline     = true
vim.cmd('packadd packer.nvim')
vim.cmd('syntax on')
vim.cmd('set encoding=utf-8')
vim.cmd('set backspace=2')
vim.cmd('set tags=./tags;,.tags')
vim.cmd('set colorcolumn=+1')
vim.cmd('set textwidth=180')
vim.cmd('set clipboard+=unnamedplus')
vim.cmd('set rtp+=~/.fzf')
vim.cmd('colorscheme dracula')
vim.cmd('highlight Comment cterm=italic')

vim.api.nvim_set_keymap('n' , '<F4>' , ':Tabularize /'   , {noremap = true})
vim.api.nvim_set_keymap('v' , '<F4>' , ':Tabularize /'   , {})

vim.api.nvim_set_keymap('n' , '<F5>' , ':Autoformat<CR>' , {noremap = true})
vim.api.nvim_set_keymap('v' , '<F5>' , ':Autoformat<CR>' , {})
vim.g.autoformat_verbosemode = 1

vim.api.nvim_set_keymap('n' , 'K'    , ':call InterestingWords("n")<CR>' , {noremap = true , silent = true})
vim.api.nvim_set_keymap('v' , 'K'    , ':call InterestingWords("v")<CR>' , {silent = true})
vim.api.nvim_set_keymap('n' , 'n'    , ':call WordNavigation(1)<CR> '    , {noremap = true , silent = true})
vim.api.nvim_set_keymap('n' , 'N'    , ':call WordNavigation(0)<CR> '    , {noremap = true , silent = true})
vim.api.nvim_set_keymap('n' , '<F3>' , ':call UncolorAllWords()<CR> '    , {noremap = true , silent = true})
vim.g.interestingWordsRandomiseColors = 1


vim.g.rainbow_active = 1
vim.g.rainbow_guifgs   = {'RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick'}
vim.g.rainbow_ctermfgs = {'lightblue', 'lightgreen', 'yellow', 'red', 'magenta'}

vim.api.nvim_set_keymap('n' , '<Tab>' , '<cmd>Te<CR>' , {noremap = true , silent = true})

vim.api.nvim_exec([[
let g:VM_maps = {}                            "取消默认按键映射。
let g:VM_maps['Find Under']         = '<M-n>' "进入多光标模式并选中光标下字符串。
let g:VM_maps['Find Subword Under'] = '<M-n>' "选中下一个字符串。
let g:VM_maps['Find Next']          = 'n'     "往下查找并增加光标。
let g:VM_maps['Find Prev']          = 'N'     "网上查找并增加光标。
let g:VM_maps['Skip Region']        = 'q'     "跳过当前光标到下一个。
let g:VM_maps['Remove Region']      = 'Q'     "取消当前光标。
let g:VM_maps['Select All']         = '\vA'   "进入多光标模式并选中所有同光标下的字符串。
let g:VM_maps['Undo']               = 'u'     "Undo.
let g:VM_maps['Redo']               = '<M-r>' "Redo.
]],false)

vim.api.nvim_set_keymap('n' , '<M-o>' , '<C-o>' , {noremap = true})

vim.api.nvim_set_keymap('n' , 'gb'    , ':BufferLineGoToBuffer '       , {noremap = true})
vim.api.nvim_set_keymap('n' , '<M-l>' , '<cmd>BufferLineCyclePrev<CR>' , {noremap = true , silent = true})
vim.api.nvim_set_keymap('n' , '<M-h>' , '<cmd>BufferLineCycleNext<CR>' , {noremap = true , silent = true})

vim.api.nvim_set_keymap("n" , "gd"      , "<Plug>(coc-definition)"                                                      , {silent = true})
vim.api.nvim_set_keymap("i" , "<TAB>"   , "pumvisible() ? '<C-n>' : '<TAB>'"                                            , {noremap = true  , silent = true , expr = true})
vim.api.nvim_set_keymap("i" , "<S-TAB>" , "pumvisible() ? '<C-p>' : '<C-h>'"                                            , {noremap = true  , expr = true})
vim.api.nvim_set_keymap("i" , "<CR>"    , "pumvisible() ? coc#_select_confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'" , {silent = true   , expr = true   , noremap = true})


require('hop').setup {
    HopChar1 = {
        vim.api.nvim_set_keymap('n', 'f', "<cmd>HopChar1<CR>",{noremap = true}),
        keys = 'etovxqpdygfblzhckisuran'
    },
}


local actions = require "fzf-lua.actions"
require'fzf-lua'.setup
{
    winopts = {
        height      = 0.7,
        git_icons   = true,
        file_icons  = false,
        color_icons = false,
        vim.api.nvim_set_keymap('t','<M-j>',"<C-j>",{noremap = true }),
        vim.api.nvim_set_keymap('t','<M-k>',"<C-k>",{noremap = true }),
        border           = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        hl = {
            normal         = 'Normal',        -- window normal color (fg+bg)
            border         = 'Normal',        -- border color (try 'FloatBorder')
            -- Only valid with the builtin previewer:
            cursor         = 'Cursor',        -- cursor highlight (grep/LSP matches)
            cursorline     = 'CursorLine',    -- cursor line
            search         = 'Search',        -- search matches (ctags)
            title          = 'Normal',        -- preview border title (file/buffer)
            -- scrollbar_f = 'PmenuThumb',    -- scrollbar "full" section highlight
            -- scrollbar_e = 'PmenuSbar',     -- scrollbar "empty" section highlight
        },
    } ,

    files = {
        vim.api.nvim_set_keymap('n', '<M-f>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true }),
        prompt = 'Files> ',
    },
    grep_cword = {
        vim.api.nvim_set_keymap('n', '<M-g>', "*<cmd>lua require('fzf-lua').grep_cword()<CR>", { noremap = true, silent = true }),
        glob_flag    = "--iglob",
        multiprocess = true,
        rg_opts      = "--sort-files --hidden --column --line-number --no-heading " ..
        "-s -w --type-add 'cmd:*.cmd' -tc -tpy -tcmd -th -tcpp "..
        "--color=always --case-sensitive  -g '!{.git,node_modules}/*'",
    },
    tags_grep_cword = {
        vim.api.nvim_set_keymap('n', '<M-]>', "*<cmd>:lua require('fzf-lua').tags_grep_cword()<CR>", { noremap = true, silent = true }),
        prompt       = 'Tags❯ ',
        ctags_file   = "tags",
        multiprocess = true,
        -- 'tags_live_grep' options, `rg` prioritizes over `grep`
        rg_opts      = "--no-heading --color=always --case-sensitive",
        grep_opts    = "--color=auto --perl-regexp",
        no_header    = false,    -- hide grep|cwd header?
        no_header_i  = false,    -- hide interactive header?
    },
    btags = {
        vim.api.nvim_set_keymap('n', '<F2>', "<cmd>:lua require('fzf-lua').btags()<CR>", { noremap = true, silent = true }),
        prompt       = 'BTags❯ ',
        ctags_file   = "tags",
        rg_opts      = "--no-heading --color=always",
        grep_opts    = "--color=auto --perl-regexp",
        multiprocess = true,
        fzf_opts     = {
            ['--delimiter'] = "'[\\]:]'",
            ["--with-nth"]  = '2..',
            ["--tiebreak"]  = 'index',
        },
    },

    buffers = {
        vim.api.nvim_set_keymap('n', '<M-b>', "<cmd>:lua require('fzf-lua').buffers()<CR>", { noremap = true, silent = true }),
        prompt        = 'Buffers❯ ',
        sort_lastused = true,         -- sort buffers() by last used

    },
    previewers = {
        bat = {
            cmd    = "bat",
            args   = "--style=numbers,changes --color always --line-range :500 {}",
            theme  = 'Coldark-Dark', -- bat preview theme (bat --list-themes)
            config = nil,            -- nil uses $BAT_CONFIG_PATH
        },
    },
}

require('neoscroll').setup({
    hide_cursor          = true  , -- Hide cursor while scrolling
    stop_eof             = true  , -- Stop at <EOF> when scrolling downwards
    use_local_scrolloff  = false , -- Use the local scope of scrolloff instead of the global scope
    respect_scrolloff    = false , -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true  , -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function      = nil   , -- Default easing function
    pre_hook             = nil   , -- Function to run before the scrolling animation starts
    post_hook            = nil   , -- Function to run after the scrolling animation ends
    performance_mode     = false , -- Disable "Performance Mode" on all buffers.
})
local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t['<M-u>'] = { 'scroll' , { '-vim.wo.scroll' , 'true'  , '250' } }
t['<M-d>'] = { 'scroll' , { 'vim.wo.scroll'  , 'true'  , '250' } }
t['<M-y>'] = { 'scroll' , { '-0.10'          , 'false' , '100' } }
t['<M-e>'] = { 'scroll' , { '0.10'           , 'false' , '100' } }
t['zt']    = { 'zt'     , { '250' } }
t['zz']    = { 'zz'     , { '250' } }
t['zb']    = { 'zb'     , { '250' } }
require('neoscroll.config').set_mappings(t)

require('bufferline').setup {
    options = {
        mode = "buffers",
        numbers =  "ordinal" ,
        close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
        indicator_icon = '▎',
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
            -- remove extension from markdown files for example
            if buf.name:match('%.md') then
                return vim.fn.fnamemodify(buf.name, ':t:r')
            end
        end,
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 18,
        diagnostics =  "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "("..count..")"
        end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        custom_filter = function(buf_number, buf_numbers)
            -- filter out filetypes you don't want to see
            if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
                return true
            end
            -- filter out by buffer name
            if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
                return true
            end
            -- filter out based on arbitrary rules
            -- e.g. filter out vim wiki buffer from tabline in your work repo
            if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
                return true
            end
            -- filter out by it's index number in list (don't show first buffer)
            if buf_numbers[1] ~= buf_number then
                return true
            end
        end,
        offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center"}},
        show_buffer_icons = true , -- disable filetype icons for buffers
        show_buffer_close_icons = true ,
        show_close_icon = true ,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "thick" ,
        enforce_regular_tabs = false ,
        always_show_bufferline = true,
        sort_by = 'id'
    },
}

return require('packer').startup({
    function()
        use { 'wbthomason/packer.nvim'     }
        use { 'phaazon/hop.nvim'           }
        use { 'junegunn/vim-easy-align'    }
        use { 'karb94/neoscroll.nvim'      }
        use { 'godlygeek/tabular'          }
        use { 'Chiel92/vim-autoformat'     }
        use { 'frazrepo/vim-rainbow'       }
        use { 'Yggdroot/indentLine'        }
        use { 'lfv89/vim-interestingwords' }
        use { 'dracula/vim'                }
        use { 'mg979/vim-visual-multi'    }
        use { 'junegunn/fzf'           , run      = './install --bin'}
        use { 'ibhagwan/fzf-lua'       , requires = { 'kyazdani42/nvim-web-devicons' } }
        use {'akinsho/bufferline.nvim' , requires = 'kyazdani42/nvim-web-devicons'}
       	use {'neoclide/coc.nvim'       , branch   = 'release'}
        use {'vim-airline/vim-airline'}
        use {'vim-airline/vim-airline-themes'}
    end
})
