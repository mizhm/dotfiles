-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local o = vim.opt

--linebreak
o.clipboard = "unnamedplus"
o.linebreak = true
o.breakindent = true
o.textwidth = 120
o.wrap = false

o.shell = "/usr/bin/fish"
