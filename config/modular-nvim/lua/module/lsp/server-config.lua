local M = {}

M.make_nls_sources = function()
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
		builtins.formatting.goimports,
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
		builtins.formatting.sqlfluff.with({
			extra_args = { "--dialect", "postgres" },
		}),
	}
end

return M
