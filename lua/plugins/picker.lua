return {
	{
		"nvim-mini/mini.pick",
		version = "*",
		dependencies = {
			"nvim-mini/mini.extra"
		},
		config = function()
			require("mini.pick").setup({
				mappings = {
					choose_marked = "<C-CR>",
				},
			})

			vim.keymap.set("n", "<leader>f", ":Pick files<CR>", { desc = "Search files" })
			vim.keymap.set("n", "<leader>h", ":Pick help<CR>", { desc = "Search help" })
			vim.keymap.set("n", "<leader>g", ":Pick grep_live<CR>", { desc = "Search live grep" })

			vim.keymap.set("n", "<leader>r", function ()
				MiniExtra.pickers.oldfiles() 
			end, { desc = "Search [r]ecent files" })

			vim.keymap.set("n", "<leader><CR>", function ()
				MiniExtra.pickers.marks({scope = "global"})
			end, { desc = "Search [m]arks" } )

			vim.keymap.set("n", "<leader>:", function ()
				MiniExtra.pickers.commands()
			end, { desc = "Search [:] commands" } )
		end,
	},
	{
		"nvim-mini/mini.extra",
		version = "*",
		dependencies = {
			"nvim-mini/mini.files",
		},
		config = function()
			require("mini.extra").setup()

			vim.keymap.set("n", "<leader>sd", function()
				MiniExtra.pickers.diagnostic()
			end, { desc = "Search diagnostics" })

			vim.keymap.set("n", "<leader>sr", function()
				MiniExtra.pickers.lsp({ scope = "references" })
			end, { desc = "Search references under cursor" })

			vim.keymap.set("n", "<leader>sm", function()
				MiniExtra.pickers.marks()
			end, { desc = "Search marks" })

			vim.keymap.set("n", "<leader>sp", function()
				MiniExtra.pickers.registers()
			end, { desc = "Search registers (pastes)" })

			vim.keymap.set("n", "<leader>sg", function()
				MiniExtra.pickers.git_files({ scope = "modified" })
			end, { desc = "Search git files (modified)" })

			vim.keymap.set("n", "<leader>ss", function()
				MiniExtra.pickers.lsp({ scope = "document_symbol" })
			end, { desc = "Search document symbols" })

			vim.keymap.set("n", "<leader>sc", function()
				MiniPick.builtin.files({}, {
					source = {
						cwd = "~/.config/nvim",
					},
				})
			end, { desc = "Open nvim configs with file explorer" })
		end,
	},
}
