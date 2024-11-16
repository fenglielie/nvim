return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local config = opts.sections

    -- rewrite lualine_z
    config.lualine_z = { { "encoding" }, { "fileformat" } }

    return opts
  end,
}
