--
-- ========== BEFORE LOAD PLUGINS ==========
--
if not table.unpack then
	table.unpack = unpack
end

require("option").setup({
	gs = {},
	opts = {},
})

-- before load modules
local lsp_module_config = require("module.lsp.config")
lsp_module_config.set_custom_opts("gopls", {
	settings = {
		gopls = { semanticTokens = true },
	},
})
lsp_module_config.disable_semantic_tokens = false
lsp_module_config.use_alternative_keymaps = true

lsp_module_config.set_alt_mappings = function(_, bufnr)
	require("which-key").add({
		{ "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", buffer = bufnr, desc = "Toggle Breakpoint", nowait = true },
		{ "<leader>dd", "<cmd>lua require'dap'.continue()<cr>", buffer = bufnr, desc = "Launch/Continue Debugger", nowait = true },
		{ "<leader>di", "<cmd>lua require('dap').step_into()<cr>", buffer = bufnr, desc = "Step Into", nowait = true },
		{ "<leader>do", "<cmd>lua require('dap').step_over()<cr>", buffer = bufnr, desc = "Step Over", nowait = true },
		{ "<leader>dr", "<cmd>lua require'dap'.repl.open()<cr>", buffer = bufnr, desc = "REPL", nowait = true },

		{ "<leader>gb", "<cmd>lua require('gitsigns').blame_line()<cr>", buffer = bufnr, desc = "Blame Line", nowait = true },
		{ "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<cr>", buffer = bufnr, desc = "Preview Hunk", nowait = true },
		{ "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", buffer = bufnr, desc = "Reset Hunk", nowait = true },

		{ "<leader>lD", "<cmd>Lspsaga goto_type_definition<cr>", buffer = bufnr, desc = "Go to type definition", nowait = true },
		{ "<leader>la", "<cmd>Lspsaga code_action<cr>", buffer = bufnr, desc = "Code action", nowait = true },
		{ "<leader>ld", "<cmd>Lspsaga goto_definition<cr>", buffer = bufnr, desc = "Go to definition", nowait = true },
		{ "<leader>lf", "<cmd>Lspsaga finder<cr>", buffer = bufnr, desc = "Finder", nowait = true },
		{ "<leader>lo", "<cmd>Lspsaga outline<cr>", buffer = bufnr, desc = "Outline", nowait = true },
		{ "<leader>lr", "<cmd>Lspsaga rename mode=n<cr>", buffer = bufnr, desc = "Rename", nowait = true },
		{ "K", "<cmd>Lspsaga hover_doc<cr>", buffer = bufnr, desc = "LSP Hover", nowait = true },
		{ "[e", '<cmd>lua require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>', buffer = bufnr, desc = "Prev diagnostic", nowait = true },
		{ "]e", '<cmd>lua require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })<cr>', buffer = bufnr, desc = "Next diagnostic", nowait = true },

		{ "<leader>uy", "<cmd>Telescope yaml_schema<cr>", buffer = bufnr, desc = "Select Yaml Schema", nowait = true },

		{ "<leader>x", buffer = bufnr, group = "Trouble", nowait = true },
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", buffer = bufnr, desc = "Trouble", nowait = true },
	})
end

vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "Make q close help, man, quickfix, dap floats",
	callback = function(args)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
		if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) then
			vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true, nowait = true })
		end
	end,
})

vim.api.nvim_create_user_command("WipeWindowlessBufs", function()
	local bufinfos = vim.fn.getbufinfo({ buflisted = true })
	vim.tbl_map(function(bufinfo)
		if bufinfo.changed == 0 and (not bufinfo.windows or #bufinfo.windows == 0) then
			vim.api.nvim_buf_delete(bufinfo.bufnr, { force = false, unload = false })
		end
	end, bufinfos)
end, { desc = "Wipeout all buffers not shown in a window" })

vim.api.nvim_create_autocmd("CmdwinEnter", {
	desc = "Make q close command history (q: and q?)",
	callback = function(args)
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true, nowait = true })
	end,
})

--
-- ========== LOAD PLUGINS ==========
--
require("plugin-manager").setup({
	branch = "stable",
})

--
-- ========== AFTER LOAD PLUGINS ==========
--
local wk = require("which-key")
wk.add({
	{ "<leader>f", group = "Finder" },
	{ "<leader>w", group = "Windows" },
	{ "<leader>l", group = "LSP" },
	{ "<leader>g", group = "GIT" },
	{ "<leader>b", group = "Buffer" },
	{ "<leader>t", group = "Testing" },
	{ "<leader>d", group = "Debugger" },
	{ "<leader>u", group = "Utilities" },
})

wk.add({
	{ "<esc>", "<cmd>nohlsearch<cr>", desc = "Clear highlights", nowait = true },
	{ "<leader>bc", "<cmd>WipeWindowlessBufs<cr>", desc = "Wipe hidden", nowait = true },
	{ "<leader>wh", "<C-w>h", desc = "Jump left", nowait = true },
	{ "<leader>wj", "<C-w>j", desc = "Jump below", nowait = true },
	{ "<leader>wk", "<C-w>k", desc = "Jump above", nowait = true },
	{ "<leader>wl", "<C-w>l", desc = "Jump right", nowait = true },
})

wk.add({
	{ "D", '"_D', desc = "Delete without yanking", nowait = true },
	{ "d", '"_d', desc = "Delete without yanking", nowait = true },
	{ "d", '"_d', desc = "Delete without yanking", mode = "v", nowait = true },
	{ "d", '"_d', desc = "Delete without yanking", mode = "x", nowait = true },
})

vim.cmd([[ colorscheme carbonfox ]])
