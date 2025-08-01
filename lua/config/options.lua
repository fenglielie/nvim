-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.listchars = "tab:▷ ,trail:·,nbsp:␣"

opt.conceallevel = 0

opt.wrap = true
opt.linebreak = true
opt.showbreak = "↪ "

opt.relativenumber = false
