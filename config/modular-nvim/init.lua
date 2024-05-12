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
	local wk = require("which-key")
	local normal_opts = { buffer = bufnr, nowait = true, silent = true, mode = "n" }

	wk.register({
		["<leader>"] = {
			g = {
				name = "Git",
				r = { "<cmd>lua require('gitsigns').reset_hunk()<cr>", "Reset Hunk" },
				p = { "<cmd>lua require('gitsigns').preview_hunk()<cr>", "Preview Hunk" },
				b = { "<cmd>lua require('gitsigns').blame_line()<cr>", "Blame Line" },
			},
			l = {
				name = "LSP",
				f = { "<cmd>Lspsaga finder<cr>", "Finder" },
				r = { "<cmd>Lspsaga rename mode=n<cr>", "Rename" },
				d = { "<cmd>Lspsaga goto_definition<cr>", "Go to definition" },
				D = { "<cmd>Lspsaga goto_type_definition<cr>", "Go to type definition" },
				a = { "<cmd>Lspsaga code_action<cr>", "Code action" },
				o = { "<cmd>Lspsaga outline<cr>", "Outline" },
			},
			x = {
				name = "Trouble",
				x = { "<cmd>Trouble diagnostics toggle<cr>", "Trouble" },
			},
			u = {
				name = "Utilities",
				y = { "<cmd>Telescope yaml_schema<cr>", "Select Yaml Schema" },
			},
		},
		["[e"] = { '<cmd>lua require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>', "Prev diagnostic" },
		["]e"] = { '<cmd>lua require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })<cr>', "Next diagnostic" },
		K = { "<cmd>Lspsaga hover_doc<cr>", "LSP Hover" },
	}, normal_opts)
end

require("plugin-manager").setup({
	branch = "stable",
})

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

local wk = require("which-key")
local normal_opts = { nowait = true, silent = true, mode = "n" }
wk.register({
	["<leader>"] = {
		w = {
			h = { "<C-w>h", "Jump to window on the left" },
			j = { "<C-w>j", "Jump to window below" },
			k = { "<C-w>k", "Jump to window above" },
			l = { "<C-w>l", "Jump to window on the right" },
		},
	},
	["<esc>"] = { "<cmd>nohlsearch<cr>", "Clear search highlights" },
}, normal_opts)

require("module.theme.theme")
