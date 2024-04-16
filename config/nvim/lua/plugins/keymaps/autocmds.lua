local M = {}

M.setup = function()
	vim.api.nvim_create_autocmd("BufWinEnter", {
		desc = "Make q close help, man, quickfix, dap floats",
		callback = function(args)
			local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
			if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) then
				vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true, nowait = true })
			end
		end,
	})

	vim.api.nvim_create_autocmd("CmdwinEnter", {
		desc = "Make q close command history (q: and q?)",
		callback = function(args)
			vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true, nowait = true })
		end,
	})
end

return M
