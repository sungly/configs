-- file format
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
          extra_args = { "--print-width", "120" },
        }),
        require("none-ls.diagnostics.eslint_d"),
      },
    })

    vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, {})
    vim.keymap.set("v", "<Leader>1f", vim.lsp.buf.format, bufopts)

    vim.opt.textwidth = 300
  end,
}
