-- none-ls
return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'mason.nvim' },
    opts = function(_, opts)
      opts.root_dir = opts.root_dir or require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git')
    end,
  },
}
