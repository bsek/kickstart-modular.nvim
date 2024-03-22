return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'kotlin-language-server',
        'ktlint',
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      vim.list_extend(opts.servers, {
        kotlin_language_server = {},
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        kotlin = { 'ktlint' },
      },
    },
  },
}
