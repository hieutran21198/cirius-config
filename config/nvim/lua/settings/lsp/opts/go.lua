local on_attach = nil

local semantic_token_providers = {
	full = true,
	legend = {
		tokenTypes = {
			"namespace",
			"type",
			"class",
			"enum",
			"interface",
			"struct",
			"typeParameter",
			"parameter",
			"variable",
			"property",
			"enumMember",
			"event",
			"function",
			"method",
			"macro",
			"keyword",
			"modifier",
			"comment",
			"string",
			"number",
			"regexp",
			"operator",
		},
		tokenModifiers = {
			"declaration",
			"definition",
			"readonly",
			"static",
			"deprecated",
			"abstract",
			"async",
			"modification",
			"documentation",
			"defaultLibrary",
		},
	},
	range = true,
}

return function(opts)
	-- assign on_attach one time.
	if on_attach == nil and opts.on_attach ~= nil then
		on_attach = opts.on_attach
	end

	local custom_opts = {
		-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-config
		settings = {
			gopls = {
				semanticTokens = true,
				analyses = {
					unreachable = true,
					nilness = true,
					unusedparams = true,
					useany = true,
					unusedwrite = true,
					ST1003 = true,
					undeclaredname = true,
					fillreturns = true,
					nonewvars = true,
					fieldalignment = false,
					shadow = true,
				},
				codelenses = {
					generate = true, -- show the `go generate` lens.
					gc_details = false, -- Show a code lens toggling the display of gc's choices.
					test = true,
					tidy = true,
					vendor = true,
					regenerate_cgo = true,
					upgrade_dependency = true,
				},
				hints = {
					assignVariableTypes = false,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = false,
					rangeVariableTypes = false,
				},
				usePlaceholders = true,
				completeUnimported = true,
				staticcheck = true,
				matcher = "Fuzzy",
				diagnosticsDelay = "500ms",
				symbolMatcher = "fuzzy",
			},
		},
		on_attach = function(client, bufnr)
			if on_attach then
				on_attach(client, bufnr)
			end

			local semantic = client.config.capabilities.textDocument.semanticTokens
			local provider = client.server_capabilities.semanticTokensProvider

			if not semantic then
				return
			end

			client.server_capabilities.semanticTokensProvider = vim.tbl_deep_extend("force", provider or {}, semantic_token_providers)
		end,
	}

	return vim.tbl_deep_extend("force", opts or {}, custom_opts)
end
