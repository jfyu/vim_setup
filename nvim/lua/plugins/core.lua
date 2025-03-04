return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority=1000,
        config = function()
            require('catppuccin').setup({
                flavour="mocha"
            })
            vim.cmd.colorscheme "catppuccin"
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }, 
        init = function()
            require('lualine').setup({
                options = {
                theme = "catppuccin"
                }
            })
        end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "vim", "python", "r" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    -- Git plugins
    {
        "tpope/vim-fugitive",
        dependencies = {
            "tpope/vim-rhubarb",
            "idanarye/vim-merginal",
        },
        lazy=false,
        --cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
    },
    {
        "f-person/git-blame.nvim",
        config = function()
            vim.g.gitblame_enabled = 1
        end,
    },
    {
        "airblade/vim-gitgutter",
        event = { "BufReadPre", "BufNewFile" },
    },

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local function my_on_attach(bufnr)
                local api = require("nvim-tree.api")
                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end
                api.config.mappings.default_on_attach(bufnr)
                vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
                vim.keymap.set('n', '<C-s>', api.node.run.system, opts('Run System'))
                vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
            end

            require("nvim-tree").setup({
                on_attach = my_on_attach,
                git = {
                    enable = true,
                    ignore = false,
                    timeout = 400,
                },
            })

            -- Keymaps
            vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
            vim.keymap.set('n', '<C-f>', ':NvimTreeFindFileToggle<CR>', {noremap = true})
            vim.keymap.set('n', '<leader>nr', ':NvimTreeResize 60<CR>', {noremap = true})

            -- Auto open for directories
            vim.api.nvim_create_autocmd({ "VimEnter" }, {
                callback = function(data)
                    if vim.fn.isdirectory(data.file) == 1 then
                        vim.cmd.cd(data.file)
                        require("nvim-tree.api").tree.open()
                    end
                end,
            })
        end,
    },

    -- Utilities
    {
        "scrooloose/nerdcommenter",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
    },
    {
        "tmux-plugins/vim-tmux-focus-events",
        event = "VeryLazy",
    },
    {
        "roxma/vim-tmux-clipboard",
        event = "VeryLazy",
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = true,
    },
} 
