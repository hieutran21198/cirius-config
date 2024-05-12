local M = {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
		},
		keys = require("module.searching.keymap").telescope,
		opts = {
			extensions = {
				undo = {},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("undo")
			telescope.load_extension("projects")
		end,
	},
}

return M
