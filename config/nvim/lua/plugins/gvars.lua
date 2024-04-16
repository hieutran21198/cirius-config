--- @class OnSetupLspOpts
--- @field setup boolean | nil
--- @field config table | nil

_G.gs = {
	undotree_WindowLayout = 4,
}

_G.opts = {
	numberwidth = 6,
}

-- TODO: refactor it.
_G.border_shape = "single" -- none, single, double, shadow
_G.lsp_hover_border_shape = "single"
_G.noice_border_shape = "rounded"
_G.lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
_G.reverse_ui = true

_G.minimap = false
--- @type { [string]: OnSetupLspOpts | nil | fun(def: OnSetupLspOpts): OnSetupLspOpts | nil}
_G.on_setup_lsp_opts = {
	-- use default setup
	lua_ls = nil,
	ols = nil,
	gleam = nil,
	tsserver = function(def)
		if def.config == nil then
			print("it should not be nil for tsserver")
			return def
		end

		if def.config.settings == nil then
			def.config.settings = {}
		end

		def.config.settings.typescript = {
			tsserver = {},
		}

		return def
	end,
	-- use default setup
	gopls = function(def)
		if def.config == nil then
			print("it should not be nil for gopls")
			return def
		end

		if def.config.settings == nil then
			def.config.settings = {}
		end

		def.config.settings.gopls = {
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
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			usePlaceholders = true,
			completeUnimported = true,
			staticcheck = true,
			matcher = "Fuzzy",
			diagnosticsDelay = "500ms",
			symbolMatcher = "fuzzy",
		}

		local default_on_attach = def.config.on_attach

		def.config.on_attach = function(client, bufnr)
			if type(default_on_attach) == "function" then
				default_on_attach(client, bufnr)
			end

			local semantic = client.config.capabilities.textDocument.semanticTokens
			local provider = client.server_capabilities.semanticTokensProvider

			if semantic then
				client.server_capabilities.semanticTokensProvider = vim.tbl_deep_extend("force", provider or {}, {
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
				})
			end
		end

		return def
	end,
	angularls = function(def)
		local util = require("lspconfig.util")
		if def.config == nil then
			return def
		end

		def.config.root_dir = util.root_pattern("angular.json", "nx.json")

		return def
	end,
	golangci_lint_ls = function(def)
		if def.config == nil then
			return def
		end

		def.config.on_attach = nil
		return def
	end,
	jsonls = function(def)
		if def.config == nil then
			return def
		end

		def.config.settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		}

		return def
	end,
	yamlls = function(def)
		if def.config == nil then
			return def
		end

		def.config.settings = {
			yaml = {
				schemaStore = {
					enable = false,
					url = "",
				},
				schemas = require("schemastore").yaml.schemas(),
			},
		}
		return def
	end,
}
_G.null_ls_sources = function()
	local nls = require("null-ls")
	local builtins = nls.builtins

	return {
		-- cloudFormation
		builtins.diagnostics.cfn_lint,

		-- terraform
		builtins.diagnostics.terraform_validate,
		builtins.diagnostics.tfsec,

		-- github
		builtins.diagnostics.actionlint,

		-- go
		builtins.code_actions.gomodifytags,
		builtins.code_actions.impl,
		-- builtins.diagnostics.golangci_lint,
		builtins.formatting.goimports,
		-- builtins.formatting.gofumpt,
		builtins.formatting.goimports_reviser,

		-- git
		builtins.code_actions.gitrebase,
		builtins.diagnostics.commitlint,

		-- nix
		builtins.code_actions.statix,
		builtins.diagnostics.deadnix,

		-- lua
		builtins.formatting.stylua,

		-- typescript
		builtins.formatting.prettierd,

		-- fish
		builtins.diagnostics.fish,

		-- shell
		builtins.formatting.shellharden,
		builtins.hover.printenv,
		builtins.diagnostics.dotenv_linter,

		-- stylesheet
		builtins.diagnostics.stylelint,

		-- sql
		builtins.diagnostics.sqlfluff.with({
			extra_args = { "--dialect", "postgres" },
		}),
		builtins.formatting.sql_formatter,
	}
end

return {}
