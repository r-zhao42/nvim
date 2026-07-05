return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme catppuccin")
		end,
	},
	{ "sainnhe/gruvbox-material", priority = 1000 },
	{
		"https://github.com/echasnovski/mini.icons",
		config = function()
			require("mini.icons").setup()
		end,
	},
	-- {
	-- 	"nvim-mini/mini.hipatterns",
	-- 	version = "*",
	-- 	config = function()
	-- 		local hipatterns = require("mini.hipatterns")
	-- 		hipatterns.setup({
	-- 			highlighters = {
	-- 				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
	-- 				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
	-- 				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
	-- 				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
	-- 				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
	--
	-- 				-- Highlight hex color strings (`#rrggbb`) using that color
	-- 				hex_color = hipatterns.gen_highlighter.hex_color(),
	-- 			},
	-- 		})
	--
	--
	-- 		vim.cmd("colorscheme neopywal")
	-- 	end,
	-- },
	"RedsXDD/neopywal.nvim"
}
