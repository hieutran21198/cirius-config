local M = {
	{
		"nvim-tree/nvim-tree.lua",
		event = "VeryLazy",
		keys = require("module.file-tree.keymap"),
		opts = {
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			view = {
				side = "left",
				number = true,
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
			diagnostics = {
				enable = true,
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
}

return M
