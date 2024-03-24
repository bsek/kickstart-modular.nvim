local lsp_utils = require 'custom.lsp.utils'

local M = {}

function M.on_attach(_, bufnr)
  -- Jump to the definition of the word under your cursor.
  -- This is where a variable was first declared, or where a function is defined, etc.
  -- To jump back, press <C-t>.
  lsp_utils.map(bufnr, 'gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

  -- Find references for the word under your cursor.
  lsp_utils.map(bufnr, 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

  -- Jump to the implementation of the word under your cursor.
  -- Useful when your language has ways of declaring types without an actual implementation.
  lsp_utils.map(bufnr, 'gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

  -- Jump to the type of the word under your cursor.
  -- Useful when you're not sure what type a variable is and you want to see
  -- the definition of its *type*, not where it was *defined*.
  lsp_utils.map(bufnr, 'gt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T] Definition')

  -- Fuzzy find all the symbols in your current document.
  -- Symbols are things like variables, functions, types, etc.
  lsp_utils.map(bufnr, '<leader>cs', require('telescope.builtin').lsp_document_symbols, 'Document [S]ymbols')

  -- Fuzzy find all the symbols in your current workspace.
  -- Similar to document symbols, except searches over your entire project.
  lsp_utils.map(bufnr, '<leader>cws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- Rename the variable under your cursor.
  -- Most Language Servers support renaming across files, etc.
  lsp_utils.map(bufnr, '<leader>cr', vim.lsp.buf.rename, '[R]ename')

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  lsp_utils.map(bufnr, '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  -- Opens a popup that displays documentation about the word under your cursor
  -- See `:help K` for why this keymap.
  lsp_utils.map(bufnr, 'K', vim.lsp.buf.hover, 'Hover Documentation')

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  lsp_utils.map(bufnr, 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  -- Codelens
  lsp_utils.map(bufnr, '<leader>cc', vim.lsp.codelens.run, 'Run Codelens')
  lsp_utils.map(bufnr, '<leader>cC', vim.lsp.codelens.refresh, 'Refresh & Display Codelens', { 'n', 'v' })
end

return M
