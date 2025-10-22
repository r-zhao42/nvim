return {
	{
		"nvim-mini/mini.starter",
		dependencies = "nvim-mini/mini.files",
		version = "*",
		config = function()
			local starter = require("mini.starter")
			starter.setup({
				items = {
					{ name = "Files", action = function() require('mini.files').open() end, section = "Builtin actions" },
					starter.sections.recent_files(5, true, true),
					starter.sections.builtin_actions(),
				},
				content_hooks = {
					starter.gen_hook.adding_bullet(),
					starter.gen_hook.aligning("center", "center"),
				},
			})
		end,
	},
}
