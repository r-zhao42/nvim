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

-- Plugins
vim.pack.add({
	{ src = "https://github.com/RedsXDD/neopywal.nvim" },
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
-- MINI
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/echasnovski/mini.icons" },
	{ src = "https://github.com/echasnovski/mini.files.git" },
	{ src = "https://github.com/echasnovski/mini.extra" }
})

-- LSP 
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

vim.cmd.colorscheme 'neopywal'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('html', {
capabilities = capabilities,
})

vim.lsp.enable({ "lua_ls", "ts_ls", "pyright", "html"})

-- Mini.Icons
require('mini.icons').setup()

-- Mini.pick

require "mini.pick".setup()

vim.keymap.set('n', '<leader>f', ":Pick files<CR>", { desc = "Search files" })
vim.keymap.set('n', '<leader>h', ":Pick help<CR>", { desc = "Search help" })
vim.keymap.set('n', '<leader>g', ":Pick grep_live<CR>", { desc = "Search live grep" })


-- Mini.Files
require('mini.files').setup()
vim.keymap.set('n', '-', ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0), true)<CR>", { desc = "Open file explorer" })
vim.keymap.set('n', '<leader>sc', ":lua MiniFiles.open('~/.config/nvim')<CR>", { desc = "Open nvim configs with file explorer" })

-- Mini.Extra 
require('mini.extra').setup()
vim.keymap.set('n', 'sd', function() MiniExtra.pickers.diagnostic() end, { desc = "Search diagnostics" })
vim.keymap.set('n', 'sr', function() MiniExtra.pickers.lsp({ scope = "references" }) end, { desc = "Search references under cursor" })
vim.keymap.set('n', 'sm', function() MiniExtra.pickers.marks() end, { desc = "Search marks" })
vim.keymap.set('n', 'sp', function() MiniExtra.pickers.registers() end, { desc = "Search registers (pastes)" })

vim.keymap.set('n', 'sg', function() MiniExtra.pickers.git_files({ scope = 'modified'}) end, { desc = "Search git files (modified)" })

-- Mason
require('mason').setup()

-- Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "tsx", "javascript", "html", "css" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  } 
}
