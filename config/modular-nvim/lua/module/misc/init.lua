return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = { skip = true },
				},
			},
			lsp = {
				progress = {
					enabled = false,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				config = function()
					require("notify").setup({ background_colour = "#000000" })
				end,
			},
		},
		config = function(_, opts)
			require("noice").setup(opts)
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		opts = {
			detection_methods = { "lsp", "pattern" },
			patterns = {
				".git",
				"_darcs",
				".hg",
				".bzr",
				".svn",
				"Makefile",
				"package.json",
				"Taskfile.*",
			},
			ignore_lsp = {},
			exclude_dirs = {},
			show_hidden = false,
			silent_chdir = true,
			scope_chdir = "global",
			datapath = vim.fn.stdpath("data"),
		},
		config = function(_, opts)
			require("project_nvim").setup(opts)
		end,
	},
	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		cmd = "WhichKey",
		opts = {},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			local normal_group = {
				f = "Finder",
				w = "Windows manager",
				l = "LSP",
				g = "Git",
			}

			for k, name in pairs(normal_group) do
				wk.register({ ["<leader>"] = { [k] = { name = name } } }, { nowait = true, silent = true, mode = "n" })
			end
		end,
	},
	{ "godlygeek/tabular" },
	{
		"ggandor/leap.nvim",
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "<leader>s", "<Plug>(leap)", { desc = "Jump to word" })
		end,
	},
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
		opts = {
			rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
		},
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim" },
		config = function()
			require("rest-nvim").setup({})
		end,
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = function()
			require("dashboard").setup({
				theme = "hyper",
				config = {
					week_header = {
						enable = true,
					},
					shortcut = {
						{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "Files",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
					},
				},
			})
		end,
	},
}
