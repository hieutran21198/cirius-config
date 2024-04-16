local M = {
	formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {}),
}

M.enable_inlay_hints = function(client, bufnr)
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(bufnr, true)
	end
end

M.format_on_save = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = M.formatting_augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = M.formatting_augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					bufnr = bufnr,
					filter = function(cli)
						return cli.name == "null-ls"
					end,
				})
			end,
		})
	end
end

return M
