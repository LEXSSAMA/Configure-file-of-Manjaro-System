-- enable line number
vim.o.number = true
-- set tab to 4 space
vim.o.expandtab = true
vim.o.tabstop = 4 
vim.o.softtabstop = 4 
vim.o.shiftwidth = 4 
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.colorcolumn = "150"
vim.o.textwidth = "150"
vim.g.mapleader = " "
-- vim.o.mouse = "a"
-- Don't hightlight search results
vim.o.hlsearch = false
vim.api.nvim_set_keymap('n' , '<M-o>' , '<C-o>' , {noremap = true})


--------------- neoscroll setup begin -----------------------------------
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
--------------- neoscroll setup end -----------------------------------

--------------- fzf-lua setup begin -----------------------------------
local actions = require "fzf-lua.actions"
require'fzf-lua'.setup
{
    winopts = {
        height      = 0.85,
        width       = 0.80,
        row         = 0.35,
        col         = 0.50,
        git_icons   = false,
        file_icons  = false,
        color_icons = false,
        border           = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        preview = {
            -- default     = 'bat',           -- override the default previewer?
            -- default uses the 'builtin' previewer
            border         = 'border',        -- border|noborder, applies only to
            -- native fzf previewers (bat/cat/git/etc)
            wrap           = 'nowrap',        -- wrap|nowrap
            hidden         = 'nohidden',      -- hidden|nohidden
            vertical       = 'up:65%',        -- up|down:size
            horizontal     = 'right:60%',     -- right|left:size
            layout         = 'vertical',          -- horizontal|vertical|flex
            flip_columns   = 120,             -- #cols to switch to horizontal on flex
            -- Only used with the builtin previewer:
            title          = true,            -- preview border title (file/buf)?
            title_pos      = "center",        -- left|center|right, title alignment
            scrollbar      = 'float',         -- `false` or string:'float|border'
            -- float:  in-window floating border
            -- border: in-border chars (see below)
            scrolloff      = '-2',            -- float scrollbar offset from right
            -- applies only when scrollbar = 'float'
            scrollchars    = {'█', '' },      -- scrollbar chars ({ <full>, <empty> }
            -- applies only when scrollbar = 'border'
            delay          = 100,             -- delay(ms) displaying the preview
            -- prevents lag on fast scrolling
            winopts = {                       -- builtin previewer window options
                number            = true,
                relativenumber    = false,
                cursorline        = true,
                cursorlineopt     = 'both',
                cursorcolumn      = false,
                signcolumn        = 'no',
                list              = false,
                foldenable        = false,
                foldmethod        = 'manual',
            },
        } ,
    },
    keymap = {
        builtin = {
            -- neovim `:tmap` mapping for the fzf win
            ["<M-d>"] = "preview-page-down",
            ["<M-u>"] = "preview-page-up",
        },
        fzf = {
            -- fzf '--bind=' options
            ["alt-j"] = "down",
            ["alt-k"] = "up",
        }
    },
    action = {
        -- These override the default tables completely
        -- no need to set to `false` to disable an action
        -- delete or modify is sufficient
        files = {
            -- providers that inherit these actions:
            --   files, git_files, git_status, grep, lsp
            --   oldfiles, quickfix, loclist, tags, btags
            --   args
            -- default action opens a single selection
            -- or sends multiple selection to quickfix
            -- replace the default action with the below
            -- to open all files whether single or multiple
            -- ["default"]     = actions.file_edit,
            ["default"]     = actions.file_edit_or_qf,
            ["ctrl-s"]      = actions.file_split,
            ["ctrl-v"]      = actions.file_vsplit,
            ["ctrl-t"]      = actions.file_tabedit,
        },
        buffers = {
            -- providers that inherit these actions:
            --   buffers, tabs, lines, blines
            ["default"]     = actions.buf_edit,
            ["ctrl-s"]      = actions.buf_split,
            ["ctrl-v"]      = actions.buf_vsplit,
            ["ctrl-t"]      = actions.buf_tabedit,
        },
    },
    files = {
        vim.api.nvim_set_keymap('n', '<M-f>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true }),
        prompt = 'Files> ',
    },
    grep_cword = {
        vim.api.nvim_set_keymap('n', '<M-g>', "<cmd>lua require('fzf-lua').grep_cword()<CR>", { noremap = true, silent = true }),
        glob_flag    = "--iglob",
        multiprocess = true,
        rg_opts      = "--sort none -U --mmap --hidden -j9 --column --line-number --no-heading --color=auto --case-sensitive  -g '!{.git,node_modules}/*'",
    },
    grep_visual = {
        vim.api.nvim_set_keymap('v', '<M-g>', "<cmd>lua require('fzf-lua').grep_visual()<CR>", { noremap = true, silent = true }),
        multiprocess = true,
        rg_opts      = "--sort none -U --mmap --hidden -j9 --column --line-number --no-heading --color=auto --case-sensitive  -g '!{.git,node_modules}/*'",
    },
    tags_grep_cword = {
        vim.api.nvim_set_keymap('n', '<M-]>', "<cmd>:lua require('fzf-lua').tags_grep_cword()<CR>", { noremap = true, silent = true }),
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
        rg_opts      = "--sort none -U --mmap -j9 --no-heading --color=auto --case-sensitive  -g '!{.git,node_modules}/*'",
        grep_opts    = "--color=auto --perl-regexp",
        multiprocess = true,
        fzf_opts     = { ["--info"] = "default", ["--tiebreak"] = "begin" },
    } ,
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
--------------- fzf-lua setup end -----------------------------------

--------------- gruvbox setup begin --------------------------------
require("gruvbox").setup({
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})
vim.o.background = "dark" -- or "light" for light mode
vim.cmd("colorscheme gruvbox")
--------------- gruvbox setup end --------------------------------

--------------- vim-autoformat begin -----------------------------
vim.api.nvim_set_keymap('n' , '<F5>' , ':Autoformat<CR>' , {noremap = true})
vim.api.nvim_set_keymap('v' , '<F5>' , ':Autoformat<CR>' , {})
vim.g.autoformat_verbosemode = 1
--------------- vim-autoformat end -----------------------------

--------------- tabular setup begin -----------------------------
vim.api.nvim_set_keymap('n' , '<F4>' , ':Tabularize /'   , {noremap = true})
vim.api.nvim_set_keymap('v' , '<F4>' , ':Tabularize /'   , {})
--------------- tabular setup end -----------------------------

--------------- vim-interestingwords setup begin -----------------------------
vim.api.nvim_set_keymap('n' , 'K'    , ':call InterestingWords("n")<CR>' , {noremap = true , silent = true})
vim.api.nvim_set_keymap('v' , 'K'    , ':call InterestingWords("v")<CR>' , {silent = true})
vim.api.nvim_set_keymap('n' , 'n'    , ':call WordNavigation(1)<CR> '    , {noremap = true , silent = true})
vim.api.nvim_set_keymap('n' , 'N'    , ':call WordNavigation(0)<CR> '    , {noremap = true , silent = true})
vim.api.nvim_set_keymap('n' , '<F3>' , ':call UncolorAllWords()<CR> '    , {noremap = true , silent = true})
vim.g.interestingWordsRandomiseColors = 1
--------------- vim-interestingwords setup end -----------------------------

--------------- vim-visual-multi setup begin -----------------------------
vim.api.nvim_exec([[
let g:VM_maps = {}                            "取消默认按键映射。
let g:VM_maps['Find Under']         = '<M-n>' "进入多光标模式并选中光标下字符串。
let g:VM_maps['Find Subword Under'] = '<M-n>' "选中下一个字符串。
let g:VM_maps['Find Next']          = 'n'     "往下查找并增加光标。
let g:VM_maps['Find Prev']          = 'N'     "往上查找并增加光标。
let g:VM_maps['Skip Region']        = 'q'     "跳过当前光标到下一个。
let g:VM_maps['Remove Region']      = 'Q'     "取消当前光标。
let g:VM_maps['Select All']         = '\vA'   "进入多光标模式并选中所有同光标下的字符串。
let g:VM_maps['Undo']               = 'u'     "Undo.
let g:VM_maps['Redo']               = '<M-r>' "Redo.
]],false)
--------------- vim-visual-multi setup end -----------------------------

--------------- hop setup begin -----------------------------
require('hop').setup {
    HopChar1 = {
        vim.api.nvim_set_keymap('n', 'f', "<cmd>HopChar1<CR>",{noremap = true}),
        keys = 'etovxqpdygfblzhckisuran'
    },
}
--------------- hop setup end -----------------------------

--------------- airline theme setup begin ----------------
vim.api.nvim_exec(
[[
let g:airline_theme='google_dark'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_z = ''
let g:airline_section_x = ''
]] ,false)
--------------- airline theme setup end ----------------

--------------- coc.nvim setup begin ----------------
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = "number"
-- vim.opt.signcolumn = "yes"
local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})
-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})
--------------- coc.nvim setup end ----------------

return require('packer').startup(function()
    use {'wbthomason/packer.nvim'}
    use {'karb94/neoscroll.nvim'}
    use {'roxma/vim-tmux-clipboard'}
    use { 'ibhagwan/fzf-lua'       , requires = { 'kyazdani42/nvim-web-devicons' } }
    use { "ellisonleao/gruvbox.nvim" }
    use { 'Chiel92/vim-autoformat'     }
    use { 'godlygeek/tabular'          }
    use { 'lfv89/vim-interestingwords' }
    use { 'mg979/vim-visual-multi'    }
    use { 'phaazon/hop.nvim'           }
    use {'vim-airline/vim-airline'        }
    use {'vim-airline/vim-airline-themes' }
    use {'neoclide/coc.nvim'    , branch   = 'release'}
end)

