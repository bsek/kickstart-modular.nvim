return {
  { -- Autoformat
    'stevearc/conform.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.formatters_by_ft, {
        xml = { 'xmllint' },
        sql = { 'pg_format' },
      })
    end,
  },
}
