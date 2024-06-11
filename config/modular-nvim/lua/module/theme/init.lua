local themes = {
	{
		"ellisonleao/gruvbox.nvim",
		opts = {
			terminal_colors = true,
			transparent_mode = true,
		},
	},
	{ "rebelot/kanagawa.nvim" },
	{ "EdenEast/nightfox.nvim" },
	{ "nyoom-engineering/oxocarbon.nvim" },
	{ "Mofiqul/vscode.nvim" },
	{ "bluz71/vim-moonfly-colors" },
}

for _, theme in ipairs(themes) do
	theme.lazy = true
	theme.priority = 1000
	theme.event = "VeryLazy"
end

local theme_names = {
	"gruvbox",
	"kanagawa-wave",
	"kanagawa-dragon",
	"kanagawa-lotus",
	"nightfox",
	"oxocarbon",
	"vscode",
	"moonfly",
}

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
		"zaldih/themery.nvim",
		keys = {
			{ "<leader>ft", "<cmd>Themery<cr>", desc = "Change themes", mode = "n" },
		},
		dependencies = themes,
		config = function()
			local theme_items = {}
			for _, theme in ipairs(theme_names) do
				table.insert(theme_items, {
					name = theme,
					colorscheme = theme,
				})
			end

			require("themery").setup({
				themes = theme_items,
				themeConfigFile = "~/.config/nvim/lua/module/theme/theme.lua",
				livePreview = true,
			})
		end,
	},
}
