-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic vim options
vim.g.mapleader = " " -- Make sure to set leader before lazy
vim.g.maplocalleader = " "

-- Basic vim settings
vim.opt.number = true -- Show line numbers
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 4 -- Number of spaces tabs count for
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.cursorline = false -- Disable cursorline for better performance
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true -- But don't ignore it when search string contains uppercase letters
vim.opt.hidden = true -- Allow switching from unsaved buffer
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.updatetime = 250 -- Balance between responsiveness and performance
vim.opt.backspace = "indent,eol,start" -- Fix backspace behavior

-- Disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set Python host
vim.g.python3_host_prog = vim.fn.expand('~/mambaforge/bin/python')

-- Setup lazy.nvim
require("lazy").setup("plugins", {
    change_detection = {
        notify = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
}) 
