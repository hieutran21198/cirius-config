local util = require("module.completion.util")

local M = {
	{
		"hrsh7th/nvim-cmp",
		event = "VeryLazy",
		keys = {},
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"dcampos/cmp-snippy",
			"nvim-lua/plenary.nvim",
			"roobert/tailwindcss-colorizer-cmp.nvim",
			{
				"hrsh7th/cmp-cmdline",
				config = function()
					local cmp = require("cmp")

					cmp.setup.cmdline({ "/", "?" }, {
						mapping = cmp.mapping.preset.cmdline(),
						sources = {
							{ name = "buffer" },
						},
					})

					cmp.setup.cmdline(":", {
						mapping = cmp.mapping.preset.cmdline(),
						sources = cmp.config.sources({
							{ name = "path" },
						}, {
							{ name = "cmdline" },
						}),
					})
				end,
			},
		},
		opts = function()
			local cmp = require("cmp")
			local formatter = require("tailwindcss-colorizer-cmp").formatter
			return {
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = formatter,
				},
				completion = {
					completeopt = "menu,menuone",
				},
				window = {
					completion = {
						side_padding = 0,
						scrollbar = false,
					},
					documentation = {},
				},
				snippet = {
					expand = function(args)
						require("snippy").expand_snippet(args.body)
					end,
				},
				experimental = {
					ghost_text = { hlgroup = "Comment" },
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "copilot" },
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
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm(),
					["<Tab>"] = cmp.mapping(util.next_suggestion, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(util.previous_suggestion, { "i", "s" }),
				},
			}
		end,
		config = function(_, opts)
			local cmp = require("cmp")
			cmp.setup(opts)
		end,
	},
}

return M
