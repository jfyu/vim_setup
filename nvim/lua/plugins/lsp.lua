return {
    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/nvim-lsp-installer",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local lsp_defaults = {
                flags = {
                    debounce_text_changes = 150,
                },
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                on_attach = function(client, bufnr)
                    -- Keybindings
                    local opts = { buffer = true }
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('x', '<F4>', vim.lsp.buf.range_code_action, opts)
                    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
                    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
                end
            }

            local lspconfig = require('lspconfig')
            lspconfig.util.default_config = vim.tbl_deep_extend(
                'force',
                lspconfig.util.default_config,
                lsp_defaults
            )

            -- Setup LSP servers
            require("nvim-lsp-installer").setup({})
            
            -- Python
            lspconfig.pyright.setup({})
            
            -- R
            lspconfig.r_language_server.setup({})
        end
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                    { name = 'path' },
                })
            })

            -- Set configuration for specific filetype
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'buffer' },
                })
            })

            -- Use buffer source for `/`
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':'
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end
    },
} 