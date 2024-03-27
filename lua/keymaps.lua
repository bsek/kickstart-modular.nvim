-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '>d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', '<d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>xe', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>xf', vim.diagnostic.setloclist, { desc = 'Open diagnostic Quick[f]ix list' })

-- Resize window using <Option> + arrow keys
vim.keymap.set('n', '<A-Down>', ':resize +1<CR>', default_opts)
vim.keymap.set('n', '<A-Right>', ':vertical resize +1<CR>', default_opts)
vim.keymap.set('n', '<A-Left>', ':vertical resize -1<CR>', default_opts)
vim.keymap.set('n', '<A-Up>', ':resize -1<CR>', default_opts)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Save file mac
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<D-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- Indent correctly when entering instert mode
vim.keymap.set('n', 'i', function()
  if #vim.fn.getline '.' == 0 then
    return [["_cc]]
  else
    return 'i'
  end
end, expr_opts)

-- Center search results
vim.keymap.set('n', 'n', 'nzz', default_opts)
vim.keymap.set('n', 'N', 'Nzz', default_opts)

-- Visual line wraps
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", expr_opts)
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
vim.keymap.set('v', '<', '<gv', default_opts)
vim.keymap.set('v', '>', '>gv', default_opts)

-- Paste over currently selected text without yanking it
vim.keymap.set('v', 'p', '"_dP', default_opts)

-- Switch buffer with tab and shift-tab
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', default_opts)
vim.keymap.set('n', '<Tab>', ':bnext<CR>', default_opts)

-- Move selected line / block of text in visual mode
vim.keymap.set('x', 'K', ":move '<-2<CR>gv-gv", default_opts)
vim.keymap.set('x', 'J', ":move '>+1<CR>gv-gv", default_opts)

-- Quit all
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

-- vim: ts=2 sts=2 sw=2 et
