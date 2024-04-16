return {
	{
		"/ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "hard", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = true,
			})
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	-- {
	-- 	"Mofiqul/vscode.nvim",
	-- 	init = function()
	-- 		vim.opt.background = "dark"
	-- 	end,
	-- 	config = function()
	-- 		require("vscode").setup({
	-- 			transparent = true,
	-- 		})
	--
	-- 		require("vscode").load()
	-- 	end,
	-- },
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	--
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			transparent = true,
	-- 			-- borderless telescope
	-- 			on_highlights = function(hl, c)
	-- 				local prompt = "#2d3149"
	-- 				hl.TelescopeNormal = {
	-- 					bg = c.bg_dark,
	-- 					fg = c.fg_dark,
	-- 				}
	-- 				hl.TelescopeBorder = {
	-- 					bg = c.bg_dark,
	-- 					fg = c.bg_dark,
	-- 				}
	-- 				hl.TelescopePromptNormal = {
	-- 					bg = prompt,
	-- 				}
	-- 				hl.TelescopePromptBorder = {
	-- 					bg = prompt,
	-- 					fg = prompt,
	-- 				}
	-- 				hl.TelescopePromptTitle = {
	-- 					bg = prompt,
	-- 					fg = prompt,
	-- 				}
	-- 				hl.TelescopePreviewTitle = {
	-- 					bg = c.bg_dark,
	-- 					fg = c.bg_dark,
	-- 				}
	-- 				hl.TelescopeResultsTitle = {
	-- 					bg = c.bg_dark,
	-- 					fg = c.bg_dark,
	-- 				}
	-- 			end,
	-- 		})
	--
	-- 		vim.cmd("colorscheme tokyonight-night")
	-- 	end,
	-- },
	-- {
	-- 	"bluz71/vim-moonfly-colors",
	-- 	name = "moonfly",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	init = function()
	-- 		vim.g.moonflyNormalFloat = true
	-- 		vim.g.moonflyCursorColor = true
	-- 		vim.g.moonflyVirtualTextColor = true
	-- 		vim.g.moonflyWinSeparator = 2
	-- 		vim.g.moonflyNormalFloat = true
	-- 		vim.g.moonflyTransparent = true
	-- 		vim.g.moonflyUnderlineMatchParent = true
	-- 		vim.opt.fillchars = { horiz = "━", horizup = "┻", horizdown = "┳", vert = "┃", vertleft = "┫", vertright = "┣", verthoriz = "╋" }
	-- 	end,
	-- 	config = function()
	-- 		vim.cmd("colorscheme moonfly")
	-- 	end,
	-- },
}
