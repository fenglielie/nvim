return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local config = opts.sections

    -- rewrite lualine_z
    config.lualine_z = {
      { "encoding" },
      {
        "fileformat",
        icons_enabled = true,
        symbols = {
          unix = "LF",
          dos = "CRLF",
          mac = "CR",
        },
      },
    }

    return opts
  end,
}
