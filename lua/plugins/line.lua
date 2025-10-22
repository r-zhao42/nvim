return {
	{
		"nvim-mini/mini.statusline",
		version = "*",
		dependencies = {
			"nvim-mini/mini-git",
			"nvim-mini/mini.icons",
			"nvim-mini/mini.diff",
		},
		config = function()
			require('mini.git').setup()
			require('mini.diff').setup()
			require("mini.statusline").setup()
		end,
	},
}
