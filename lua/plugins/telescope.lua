return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      file_ignore_patterns = { "%.git/", "node_modules/", "%.cache/" }, -- 添加 .git 目录过滤
    },
  },
}
