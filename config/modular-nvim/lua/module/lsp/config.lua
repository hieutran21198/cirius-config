local custom_opts = {}
local custom_on_attach = nil

local M = {
	disable_semantic_tokens = true,
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	signature_help = true,
	use_alternative_keymaps = false,
	set_alt_mappings = function(_, _) end,
}

M.set_custom_on_attach = function(on_attach)
	custom_on_attach = on_attach
end

M.override_semantic_token_provider = function(client, new_provider)
	local semantic = client.config.capabilities.textDocument.semanticTokens
	local provider = client.server_capabilities.semanticTokensProvider

	if semantic then
		client.server_capabilities.semanticTokensProvider = vim.tbl_deep_extend("force", provider or {}, new_provider)
	end
end

M.override_opts = function(server_name, default_opts)
	local custom_server_opts = custom_opts[server_name]
	if not custom_server_opts then
		return default_opts
	end

	if type(custom_server_opts) == "function" then
		custom_server_opts = custom_server_opts(default_opts)
	end

	return vim.tbl_deep_extend("force", default_opts, custom_server_opts or {})
end

--- @param opts table | function
--- @param language string
--- @return nil
M.set_custom_opts = function(language, opts)
	if custom_opts[language] ~= nil then
		return
	end

	custom_opts[language] = opts
end

M.on_init = function(client, _)
	if M.disable_semantic_tokens and client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

M.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

M.on_attach = function(client, bufnr)
	if custom_on_attach ~= nil then
		custom_on_attach(client, bufnr)
	end

	local get_token_provider = require("module.lsp.token-provider")
	M.override_semantic_token_provider(client, get_token_provider(client.name))

	if not M.use_alternative_keymaps then
		local lsp_buf = vim.lsp.buf
		local map = vim.keymap.set
		local function opts(desc)
			return { buffer = bufnr, desc = "LSP " .. desc }
		end

		map("n", "<leader>ld", lsp_buf.definition, opts("Go to definition"))
		map("n", "K", lsp_buf.hover, opts("hover information"))
		map("n", "<leader>li", lsp_buf.implementation, opts("Go to implementation"))
		map("n", "<leader>lr", lsp_buf.rename, opts("Rename"))
		map("n", "<leader>lf", lsp_buf.formatting, opts("formatting"))
		map("n", "<leader>lD", lsp_buf.type_definition, opts("Go to type definition"))
		map({ "n", "v" }, "<leader>la", lsp_buf.code_action, opts("Code action"))
	else
		M.set_alt_mappings(client.name, bufnr)
	end
end

M.make_lsp_opts = function(overrideOpts)
	local default_opts = {
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
	}
	return vim.tbl_deep_extend("force", default_opts, overrideOpts or {})
end

return M
