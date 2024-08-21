return {
	{ "<leader>tn", "<cmd>lua require('neotest').run.run()<cr>", desc = "Test nearest", mode = "n" },
	{ "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Test file", mode = "n" },
	{ "<leader>td", "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<cr>", desc = "Debug nearest test", mode = "n" },
	{ "<leader>ts", "<cmd>lua require('neotest').run.stop()<cr>", desc = "Stop", mode = "n" },
	{ "<leader>tr", "<cmd>lua require('neotest').output_panel.toggle()<cr>", desc = "Toggle result", mode = "n" },
}
