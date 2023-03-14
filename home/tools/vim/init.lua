-- Solarized colorscheme
vim.o.background = 'dark'
vim.cmd("colorscheme solarized")

-- Show line numbers
vim.o.number = true

-- Disable vi compatiblity
vim.o.compatible = false

-- Allow switching buffers without writing
vim.o.hidden = true

-- Persist undos across sessions
vim.o.undofile = true
vim.o.undodir = os.getenv('HOME') .. '/.vim/undo-dir'

-- Default tabstops
local tab_width = 2
vim.bo.tabstop = tab_width
vim.bo.softtabstop = tab_width
vim.bo.shiftwidth = tab_width
vim.bo.expandtab = true
vim.wo.cc = 80

-- Setup lualine
require('lualine').setup({
  options = {
    theme = 'solarized_dark',
  }
})

-- Keybinds
vim.keymap.set('n', '<Tab>', '<C-^>')
vim.keymap.set('n', '<C-p>', require('telescope.builtin').git_files)
vim.keymap.set('n', '<leader>rg', require('telescope.builtin').live_grep)
