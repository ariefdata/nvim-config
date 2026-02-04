-- return {
--   "catppuccin/nvim",
--   priority = 1000,
--   config = function()
--     vim.cmd("colorscheme catppuccin")
--   end
-- }
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = true, -- Aktifkan transparansi
      integrations = {
        nvimtree = true,
        treesitter = true,
        telescope = true,
        cmp = true,
        bufferline = true,
      },
    })
    vim.cmd("colorscheme catppuccin")
  end,
}
