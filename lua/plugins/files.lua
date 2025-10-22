return {
	{
		'nvim-mini/mini.files',
		version = '*',
		config = function()
			require('mini.files').setup()
			vim.keymap.set('n', '-', ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0), true)<CR>",
				{ desc = "Open file explorer" })
		end
	},
}
