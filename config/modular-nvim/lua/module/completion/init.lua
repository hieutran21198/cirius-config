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
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
			"dcampos/cmp-snippy",
			"lukas-reineke/cmp-under-comparator",
			"nvim-lua/plenary.nvim",
			"onsails/lspkind.nvim",
			"ray-x/cmp-treesitter",
			"roobert/tailwindcss-colorizer-cmp.nvim",
		},
		opts = function()
			local cmp = require("cmp")
			local formatter = require("tailwindcss-colorizer-cmp").formatter

			return {
				formatting = {
					fields = { "kind", "abbr", "menu" },
					-- format = function(_, item)
					-- 	local icon = util.icons[item.kind] or ""
					--
					-- 	icon = " " .. icon .. " "
					-- 	item.kind = icon
					-- 	item.menu = "   (" .. item.kind .. ")"
					--
					-- 	return item
					-- end,
					format = formatter,
				},
				completion = {
					completeopt = "menu,menuone",
				},
				window = {
					completion = {
						side_padding = 0,
						-- winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
						scrollbar = false,
						-- border = util.border("CmpBorder"),
					},
					documentation = {
						-- border = util.border("CmpDocBorder"),
						-- winhighlight = "Normal:CmpDoc",
					},
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
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
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
