local config = require("module.lsp.config")
local server_config = require("module.lsp.server-config")

local formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local M = {
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
	},
	-- {
	-- 	"hinell/lsp-timeout.nvim",
	-- 	dependencies = { "neovim/nvim-lspconfig" },
	-- },
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			"ray-x/guihua.lua",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			symbol_in_winbar = {
				enable = true,
				separator = " ",
				delay = 1000,
				color_mode = true,
			},
			finder = {
				keys = {
					toggle_or_open = "<CR>",
					vsplit = "<C-v>",
					split = "<C-x>",
					quit = "q",
				},
			},
			diagnostic = {
				enable = true,
				show_code_action = true,
			},
			outline = {
				enable = true,
				close_after_jump = true,
				toggle_or_jump = "<CR>",
				win_width = 50,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		opts = {
			ensure_installed = {
				"bash",
				"go",
				"lua",
			},
			auto_install = true,
			sync_install = true,
		},
		config = function(_, opts)
			local ts = require("nvim-treesitter.configs")
			ts.setup(opts)
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		opts = function()
			return {
				sources = server_config.make_nls_sources(),
				default_timeout = 300,
				update_in_insert = false,
				debug = false,
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = formatting_augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									bufnr = bufnr,
									filter = function(cli)
										return cli.name == "null-ls"
									end,
								})
							end,
						})
					end
				end,
			}
		end,
		config = function(_, opts)
			local nls = require("null-ls")
			nls.setup(opts)
		end,
	},
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
		opts = {
			ui = {
				icons = {
					package_pending = " ",
					package_installed = "󰄳 ",
					package_uninstalled = " 󰚌",
				},
				max_concurrent_installers = 10,
			},
			ensure_installed = require("modular-config").ensure_installed_lsp,
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({})
			mason_lspconfig.setup_handlers({
				function(server_name)
					local server_opts = config.override_opts(server_name, config.make_lsp_opts())
					require("lspconfig")[server_name].setup(server_opts)
				end,
			})

			vim.api.nvim_create_user_command("MasonInstallAll", function()
				if opts.ensure_installed and #opts.ensure_installed > 0 then
					vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
				end
			end, {})
		end,
	},
}

return M
