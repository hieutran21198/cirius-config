return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufEnter",
		opts = {
			ensure_installed = {
				"bash",
				"go",
				"lua",
				"typescript",
				"javascript",
			},
			auto_install = true,
			sync_install = true,
		},
		config = function(_, opts)
			local ts = require("nvim-treesitter.configs")

			ts.setup(opts)
		end,
	},
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {},
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			local illuminate = require("illuminate")
			illuminate.configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
			})
		end,
	},
	{
		"code-biscuits/nvim-biscuits",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		},
	},
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup()

			local kopts = { noremap = true, silent = true }

			vim.api.nvim_set_keymap("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

			vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>noh<CR>", kopts)
		end,
	},
	{
		"smoka7/hop.nvim",
		cmd = { "HopWord" },
		opts = { keys = "etovxqpdygfblzhckisuran" },
	},
	{
		"godlygeek/tabular",
	},
}
