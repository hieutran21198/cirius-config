local M = {
	{
		"dcampos/nvim-snippy",
		dependencies = { "honza/vim-snippets" },
		event = "VeryLazy",
		config = function()
			local snippy = require("snippy")
			snippy.setup({
				snippet_dirs = { vim.fn.stdpath("config") .. "/snippets" },
				local_snippet_dir = ".nvim/snippets",
				virtual_markers = {
					enabled = true,
					-- Marker for all placeholders (non-empty)
					default = "",
					-- Marker for all empty tabstops
					empty = "",
					-- Marker highlighing
					hl_group = "SnippyMarker",
				},
			})
		end,
	},
}

return M
