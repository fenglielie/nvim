-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "：", function()
  vim.notify("Please switch to English input before typing ':'", vim.log.levels.WARN)
end, { noremap = true, silent = true })
