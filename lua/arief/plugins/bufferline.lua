return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  after = "catppuccin", -- Ensure bufferline is loaded after catppuccin
  config = function()
    local mocha = require("catppuccin.palettes").get_palette "mocha" -- Load color palette

    require("bufferline").setup {
      highlights = require("catppuccin.groups.integrations.bufferline").get {
        styles = { "italic", "bold" }, -- Set text styles
        custom = {
          all = {
            fill = { bg = "#000000" }, -- Background color for all modes
          },
          mocha = {
            background = { fg = mocha.text }, -- Text color for mocha theme
          },
          latte = {
            background = { fg = "#000000" }, -- Text color for latte theme
          },
        },
      },
      options = {
        mode = "tabs", -- Use tabs mode
        separator_style = "slant", -- Use slant separator style
      },
    }
  end,
}
