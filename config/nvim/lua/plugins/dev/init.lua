local lsp_utils = require("utils.lsp")
local on_attach_utils = require("utils.on_attach")

return {
	{ "imsnif/kdl.vim" },
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui" }, types = true },
			})
		end,
	},
	"gpanders/editorconfig.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local nls = require("null-ls")

			nls.setup({
				sources = _G.null_ls_sources(),
				default_timeout = 3000,
				update_in_insert = false,
				debug = false,
				on_attach = function(client, bufnr)
					on_attach_utils.format_on_save(client, bufnr)
					_G.set_keymaps_on_attach(client, bufnr)
				end,
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			"neovim/nvim-lspconfig",
			"ray-x/guihua.lua",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local saga = require("lspsaga")
			saga.setup({
				symbol_in_winbar = {
					enable = true,
					separator = " ",
					delay = 300,
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
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"folke/which-key.nvim", -- for keybindings
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp", -- for autocompletion
			"b0o/schemastore.nvim",
		},
		config = function()
			--* setup mason and mason-lspconfig
			local mason = require("mason")
			mason.setup()

			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				ensure_installed = { "lua_ls", "gopls", "angularls@17.1.0" },
			})

			--- @return OnSetupLspOpts
			local get_def = function()
				local override_cap_fn = require("cmp_nvim_lsp").default_capabilities
				local cap = lsp_utils.create_capabilities(override_cap_fn)

				return {
					setup = true,
					config = {
						capabilities = cap,
						on_attach = function(client, bufnr)
							on_attach_utils.enable_inlay_hints(client, bufnr)
							_G.set_keymaps_on_attach(client, bufnr)
						end,
					},
				}
			end

			mason_lspconfig.setup_handlers({
				function(server_name)
					local user_opts = _G.on_setup_lsp_opts[server_name]
					--- @type OnSetupLspOpts
					local def_opts = get_def()

					if type(user_opts) == "function" then
						user_opts = user_opts(def_opts)
					end

					local opts = user_opts or def_opts
					if not opts.setup then
						return
					end

					require("lspconfig")[server_name].setup(opts.config or {})
				end,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		keys = {},
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"neovim/nvim-lspconfig",
			"dcampos/nvim-snippy",
			"dcampos/cmp-snippy",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"ray-x/cmp-treesitter",
			"lukas-reineke/cmp-under-comparator",
			"zbirenbaum/copilot.lua",
			"zbirenbaum/copilot-cmp",
			"nvim-lua/plenary.nvim",
			"onsails/lspkind.nvim",
		},
		config = function()
			--* snippets
			local snippy = require("snippy")
			snippy.setup({})

			--* ai
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
			require("copilot_cmp").setup()

			--* cmp
			local cmp = require("cmp")
			local default_opts = require("plugins.dev.cmp.opts").default()
			cmp.setup(default_opts)

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
	{
		"zeioth/garbage-day.nvim",
		event = "User BaseFile",
		opts = {
			aggressive_mode = false,
			excluded_lsp_clients = {
				"null-ls",
				"jdtls",
			},
			grace_period = (60 * 15),
			wakeup_delay = 3000,
			notifications = false,
			retries = 3,
			timeout = 1000,
		},
	},
	{
		"andymass/vim-matchup",
		event = "VeryLazy",
		config = function()
			vim.g.matchup_matchparen_deferred = 1 -- work async
			vim.g.matchup_matchparen_offscreen = {} -- disable status bar icon
		end,
	},
}
