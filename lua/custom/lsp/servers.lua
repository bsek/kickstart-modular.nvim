local M = {}

local lsp_utils = require 'custom.lsp.utils'

local function lsp_init()
  -- LSP diagnostics configuration
  local config = {
    diagnostic = {
      virtual_text = {
        severity = {
          min = vim.diagnostic.severity.WARN,
        },
      },
      underline = false,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = true,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
      },
    },
  }

  -- Diagnostic configuration
  vim.diagnostic.config(config.diagnostic)
end

function M.setup(_, opts)
  -- run when client attaches
  lsp_utils.on_attach(function(client, bufnr)
    require('custom.lsp.keymaps').on_attach(client, bufnr)

    -- call setup (on_attach) function for server
    if opts.setup[client.name] then
      opts.setup[client.name](client, bufnr)
    end
    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end)

  lsp_init() -- diagnostics, handlers

  -- LSP servers and clients are able to communicate to each other what features they support.
  --  By default, Neovim doesn't support everything that is in the LSP specification.
  --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
  --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
  local defaultCapabilities = lsp_utils.capabilities()

  -- Ensure the servers and tools are installed
  require('mason').setup()

  require('mason-lspconfig').setup {
    handlers = {
      function(server_name)
        local server = opts.servers[server_name] or {}
        -- add lsp specific capabilities
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = defaultCapabilities,
        }, server or {})
        -- setup lspconfig
        require('lspconfig')[server_name].setup(server_opts)
      end,
    },
  }
end

return M
