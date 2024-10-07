return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("catppuccin")

    local gray = "#808080"
    local yellow = "#fcf403"

    local lineNmbr = { bg = "none", fg = gray }
    local focusLineNmbr = { bg = "none", fg = yellow }

    -- Line number
    vim.api.nvim_set_hl(0, "LineNrAbove", lineNmbr)
    vim.api.nvim_set_hl(0, "LineNr", focusLineNmbr)
    vim.api.nvim_set_hl(0, "LineNrBelow", lineNmbr)
  end,
}
