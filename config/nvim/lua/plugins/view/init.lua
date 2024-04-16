return {
	{
		"ziontee113/icon-picker.nvim",
		event = "VeryLazy",
		dependencies = {
			"stevearc/dressing.nvim",
		},
		opts = {
			disable_legacy_commands = true,
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		event = "VeryLazy",
		opts = {
			sync_root_with_cwd = true,
			view = {
				side = _G.reverse_ui and "right" or "left",
				number = false,
				width = 50,
			},
			renderer = {
				highlight_git = true,
				highlight_diagnostics = false,
				indent_markers = {
					enable = true,
					inline_arrows = false,
				},
				icons = {
					git_placement = "after",
				},
			},
			update_focused_file = {
				enable = true,
			},
			diagnostics = {
				enable = false,
			},
			modified = {
				enable = true,
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim" },
		opts = {
			extensions = {
				undo = {},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)

			telescope.load_extension("undo")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local bufferline = require("bufferline")

			bufferline.setup({
				options = {
					groups = {
						options = {
							toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
						},
						items = {
							{
								name = "Tests", -- Mandatory
								highlight = { underline = true, sp = "blue" }, -- Optional
								priority = 2, -- determines where it will appear relative to other groups (Optional)
								icon = "", -- Optional
								matcher = function(buf) -- Mandatory
									return buf.name:match("%_test") or buf.name:match("%_spec")
								end,
							},
							{
								name = "Docs",
								highlight = { undercurl = true, sp = "green" },
								auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
								matcher = function(buf)
									return buf.name:match("%.md") or buf.name:match("%.txt")
								end,
								separator = { -- Optional
									style = require("bufferline.groups").separator.tab,
								},
							},
						},
					},
					themable = true,
					max_name_length = 15,
					max_prefix_length = 15,
					truncate_names = false,
					tab_size = 45,
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level, _, _)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "center",
							separator = true,
						},
					},
					show_buffer_icons = true,
					sort_by = "relative_directory",
				},
			})
		end,
	},
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- 	config = function()
	-- 		local notify = require("notify")
	-- 		notify.setup({
	-- 			timeout = 50,
	-- 			max_width = 60,
	-- 			minimum_width = 60,
	-- 			fps = 60,
	-- 			stages = "fade",
	-- 		})
	-- 		local noice = require("noice")
	--
	-- 		noice.setup({
	-- 			lsp = {
	-- 				progress = {
	-- 					enabled = false,
	-- 					format = "lsp_progress",
	-- 					format_done = "lsp_progress_done",
	-- 					throttle = 1000 / 30, -- frequency to update lsp progress message
	-- 					view = "mini",
	-- 				},
	-- 				override = {
	-- 					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 					["vim.lsp.util.stylize_markdown"] = true,
	-- 					["cmp.entry.get_documentation"] = true,
	-- 				},
	-- 				signature = {
	-- 					enabled = true,
	-- 				},
	-- 				hover = {
	-- 					enabled = true,
	-- 				},
	-- 			},
	--
	-- 			presets = {
	-- 				bottom_search = false, -- use a classic bottom cmdline for search
	-- 				command_palette = true, -- position the cmdline and popupmenu together
	-- 				long_message_to_split = true, -- long messages will be sent to a split
	-- 				inc_rename = false, -- enables an input dialog for inc-rename.nvim
	-- 				lsp_doc_border = true, -- add a border to hover docs and signature help
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("config.evil-lualine")
		end,
	},
}
