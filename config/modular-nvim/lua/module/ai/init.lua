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
	{
		"Exafunction/codeium.nvim",
		event = "BufEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
				enable_chat = true,
			})
		end,
	},
}

return M
