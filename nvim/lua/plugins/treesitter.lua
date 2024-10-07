return { 
  'nvim-treesitter/nvim-treesitter',
  build=":TSUpdate",
  config = function()
    local config = require('nvim-treesitter.configs')
    config.setup({
      ensure_install = {"lua", "javascript", "typescript"},
      highlight = { enable = true },
      indent = { endable = true }
    })
  end
}
