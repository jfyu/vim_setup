local M = {}

function M.map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return M
-- from https://blog.devgenius.io/create-custom-keymaps-in-neovim-with-lua-d1167de0f2c2
