local M = {
	{
		"zbirenbaum/copilot.lua",
		event = "VeryLazy",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
			copilot_node_command = vim.fn.expand("$HOME") .. "/.local/share/nvm/v18.18.0/bin/node",
		},
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "copilot.lua", "hrsh7th/nvim-cmp" },
		config = function()
			require("copilot_cmp").setup({
				event = { "InsertEnter", "LspAttach" },
				fix_pairs = true,
			})
		end,
	},
}

return M
