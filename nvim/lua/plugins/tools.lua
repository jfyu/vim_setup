return {
    -- Database
    {
        "tpope/vim-dadbod",
        dependencies = {
            "kristijanhusak/vim-dadbod-ui",
            "kristijanhusak/vim-dadbod-completion",
        },
        cmd = { "DB", "DBUI" },
        init = function()
            -- Database connections
            vim.g.dbs = {
                wsdev = vim.env.CONN_PANTHEON,
                wsprod = vim.env.CONN_PANTHEON_PROD
            }
        end,
        config = function()
            -- Keymaps
            vim.keymap.set('n', '<C-d>', ':DBUIToggle<CR>', {noremap = true})

            -- Setup completion for SQL files
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'sql',
                desc = 'vim-dadbod-completion',
                callback = function()
                    require('cmp').setup.buffer({
                        sources = {
                            { name = 'vim-dadbod-completion' },
                            { name = 'buffer' }
                        }
                    })
                end
            })
        end
    },

    -- Markdown Preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreview", "MarkdownPreviewToggle" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    -- Python formatting
    {
        "psf/black",
        ft = "python",
        config = function()
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.py",
                callback = function()
                    vim.cmd("Black")
                end,
            })
        end,
    },

    -- Additional UI enhancements
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },
    {
        "MunifTanjim/nui.nvim",
        event = "VeryLazy",
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
       lazy = false,
       version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
       opts = {
         provider = "ws_ai",
         vendors = {
           ws_ai = {
             __inherited_from = "openai",
             endpoint = "https://llm.w10e.com/api/bedrock/v2/",
             api_key_name = "WS_AI_KEY",
             model = "bedrock-claude-3.5-sonnet", -- your desired model
           },
         },
       },
       build = "make",
       dependencies = {
         "nvim-treesitter/nvim-treesitter",
         "stevearc/dressing.nvim",
         "nvim-lua/plenary.nvim",
         "MunifTanjim/nui.nvim",
         --- The below dependencies are optional,
         "echasnovski/mini.pick", -- for file_selector provider mini.pick
         "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
         "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
       },
    },
} 
