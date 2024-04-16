local M = {}

M.default = function()
	--* cmp
	local cmp = require("cmp")
	local cmp_utils = require("plugins.dev.cmp.util")

	return {
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = cmp_utils.format_fn,
		},
		snippet = {
			expand = function(args)
				local snippy = require("snippy")
				snippy.expand_snippet(args.body)
			end,
		},
		experimental = {
			ghost_text = { hlgroup = "Comment" },
		},
		mapping = cmp.mapping.preset.insert({
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<C-e>"] = cmp.mapping.abort(),
			["<S-Tab>"] = cmp.mapping(cmp_utils.select_previous, { "i", "s" }),
			["<Tab>"] = cmp.mapping(cmp_utils.select_next, { "i", "s" }),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "copilot", group_index = 2 },
			{ name = "snippy" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "treesitter" },
			{ name = "path" },
			{ name = "buffer" },
		}),
		sorting = {
			priority_weight = 2,
			comparators = {
				require("copilot_cmp.comparators").prioritize,
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				require("cmp-under-comparator").under,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
	}
end

return M
