local util = require("module.searching.util")

return {
	telescope = {
		{
			"<leader>f",
			util.search_selected_text_in_visual_mode,
			desc = "Search selected text",
			mode = "v",
		},
		{
			"<leader>fu",
			"<cmd>Telescope undo<cr>",
			desc = "Show file changed history",
			mode = "n",
		},
		{
			"<leader>ff",
			"<cmd>Telescope find_files<cr>",
			desc = "Find files",
			mode = "n",
		},
		{
			"<leader>fs",
			"<cmd>Telescope live_grep<cr>",
			desc = "Search string <Grep>",
			mode = "n",
		},
		{
			"<leader>fb",
			"<cmd>Telescope buffers<cr>",
			desc = "Openned buffers",
			mode = "n",
		},
		{
			"<leader>fr",
			"<cmd>Telescope resume<cr>",
			desc = "Reopen last telescope window",
			mode = "n",
		},
	},
}
