return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    lualine.setup {
      options = {
        theme = "catppuccin", -- Set theme to catppuccin
      },
      sections = {
        lualine_x = {
          {
            lazy_status.updates, -- Display updates
            cond = lazy_status.has_updates, -- Show only if updates are available
            color = { fg = "#ff9e64" }, -- Set color for updates
          },
          { "encoding" }, -- Show file encoding
          { "fileformat" }, -- Show file format
          { "filetype" }, -- Show file type
        },
      },
    }
  end,
}
