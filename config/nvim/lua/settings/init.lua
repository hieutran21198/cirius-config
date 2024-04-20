-- seting interface
local M = {
	lsp = {
		-- opt wrappers custom configuration of each language before setup.
		opt_wrappers = {
			lua_ls = function(opts)
				return opts
			end,
			-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-config
			gopls = require("settings.lsp.opts.go"),
		},
	},
}

return M
