return {
	{ "stevearc/dressing.nvim" },
	{
		"ziontee113/icon-picker.nvim",
		event = "VeryLazy",
		opts = {
			disable_legacy_commands = true,
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"folke/trouble.nvim",
		},
		opts = function(_, opts)
			local ok, trouble = pcall(require, "trouble")
			if ok then
			end

			return opts
		end,
	},
	{
		"zaldih/themery.nvim",
		keys = {
			{ "<leader>ft", "<cmd>Themery<cr>", desc = "Change themes", mode = "n" },
		},
		dependencies = {
			{
				"/ellisonleao/gruvbox.nvim",
				event = "VeryLazy",
				opts = {
					terminal_colors = true, -- add neovim terminal colors
					transparent_mode = true,
				},
			},
		},
		config = function()
			require("themery").setup({
				themes = {
					{
						name = "gruvbox",
						colorscheme = "gruvbox",
					},
				},
				themeConfigFile = "~/.config/nvim/lua/module/theme/theme.lua",
				livePreview = true,
			})
		end,
	},
}
