return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {},
			},
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			"saghen/blink.cmp",
			"nvim-mini/mini.pick",
			"nvim-mini/mini.extra",
		},
		config = function()
			require("mason").setup()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local opts = { noremap = true, silent = true }
			local on_attach = function(_, bufnr)
				local keymap = vim.keymap
				opts.buffer = bufnr

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", function()
					MiniExtra.pickers.lsp({ scope = "definition" })
				end, opts)

				opts.desc = "Show LSP references"
				vim.keymap.set("n", "<leader>gr", function()
					MiniExtra.pickers.lsp({ scope = "references" })
				end, opts)

				opts.desc = "Show LSP implementation"
				vim.keymap.set("n", "gi", function()
					MiniExtra.pickers.lsp({ scope = "implementation" })
				end, opts)

				opts.desc = "Show LSP code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				vim.keymap.set("n", "<leader>sd", function()
					MiniExtra.pickers.diagnostic()
				end, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1 })
					vim.cmd("normal! zz")
				end, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1 })
					vim.cmd("normal! zz")
				end, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rl", ":LspRestart | LspStart<CR>", opts)
			end

			local servers = {
				lua_ls = {},
			}
			local ensure_installed = vim.tbl_keys(servers)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						server.on_attach = on_attach
						vim.lsp.config(server_name, server)
						vim.lsp.enable(server_name)
					end,
				},
			})

			vim.lsp.config("sourcekit", {
				cmd = {
					"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
				},
				filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp" },
				capabilities = capabilities,
				on_attach = on_attach,
			})

			vim.lsp.enable("sourcekit")
		end,
	},
	-- {
	-- 	"nvim-mini/mini.completion",
	-- 	dependencies = {
	-- 		"nvim-mini/mini.icons",
	-- 	},
	-- 	version = false,
	-- 	config = function()
	-- 		require("mini.completion").setup()
	-- 	end,
	-- },
	{
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			"folke/lazydev.nvim",
		},
		opts = {
			keymap = {
				preset = "default",
			},

			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				documentation = { auto_show = false, auto_show_delay_ms = 500 },
			},
			sources = {
				default = { "lsp", "path", "snippets", "lazydev" },
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},
			fuzzy = { implementation = "lua" },

			signature = { enabled = true },
		},
	},
}
