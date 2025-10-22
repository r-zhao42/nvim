vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrap = false
vim.opt.swapfile = false
vim.g.mapleader = " "
vim.g.have_nerd_font = true
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.conceallevel = 1

vim.keymap.set('n', '<leader>o', ':update<CR> :so<CR>', { desc = 'Source current file' })
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"0p', { desc = 'Paste from the register 0 (yank register)' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'Format buffer' })
vim.keymap.set('n', '<leader>cc', '<cmd>cclose<cr>', { desc = 'Close quickfix list' })


vim.cmd(":hi statusline guibg=NONE")

vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)

-- Highlight on Yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Set wrap true on markdowon file
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'markdown',
	desc = 'Set text wrap to true when opening .md files',
	group = vim.api.nvim_create_augroup('MarkdownWrap', { clear = true }), 
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
	end,
})

require("config.lazy")
