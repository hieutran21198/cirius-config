local focus_or_close_nvimtree = function()
	local win = vim.api.nvim_get_current_win()

	if vim.bo.filetype == "NvimTree" then
		vim.api.nvim_win_close(win, true)
	else
		vim.cmd("NvimTreeFocus")
	end
end

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

local on_esc = function()
	--* clear highlight
	vim.cmd("nohlsearch")
end

local test_run = function()
	require("neotest").run.run()
end

local test_attach = function()
	require("neotest").run.attach()
end

local test_stop = function()
	require("neotest").run.stop()
end

local test_current_file = function()
	require("neotest").run.run(vim.fn.expand("%"))
end

local test_output = function()
	require("neotest").output_panel.toggle()
end

local test_clear = function()
	require("neotest").clear()
end

_G.set_keymaps_on_attach = function(_, bufnr)
	local which_key = require("which-key")

	--* for common usage.
	--* normal mode
	local nopts = { mode = "n", noremap = true, silent = true, buffer = bufnr }
	which_key.register({
		["K"] = {
			"<cmd>Lspsaga hover_doc<cr>",
			"Lsp Hover",
		},
	}, nopts)
	which_key.register({
		["["] = {
			["e"] = {
				function()
					require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
				end,
				"Prev Diagnostic",
			},
		},
	}, nopts)
	which_key.register({
		["]"] = {
			["e"] = {
				function()
					require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
				end,
				"Next Diagnostic",
			},
		},
	}, nopts)

	which_key.register({
		["<leader>"] = {
			l = {
				name = "Lsp",
				["f"] = { "<cmd>Lspsaga finder<cr>", "Finder" },
				["r"] = { "<cmd>Lspsaga rename mode=n<cr>", "Rename" },
				["K"] = { "<cmd>Lspsaga hover_doc<cr>", "Hover" },
				["d"] = { "<cmd>Lspsaga goto_definition<cr>", "Definition" },
				["D"] = { "<cmd>Lspsaga goto_type_definition<cr>", "Type Definition" },
				["a"] = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
				-- ["a"] = { vim.lsp.buf.code_action, "Code Action" },
				["o"] = { "<cmd>Lspsaga outline<CR>", "Outline" },
				["R"] = { "<cmd>LspRestart<cr>", "Restart" },
				["l"] = { "<cmd>LspLog<cr>", "Log" },
				["c"] = { "<cmd>LspInfo<cr>", "Client Info" },
			},
		},
	}, nopts)
end

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true,
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list?
				},
				presets = {
					operators = true, -- adds help for operators like d, y, ...
					motions = true, -- adds help for motions
					text_objects = true, -- help for text objects triggered after entering an operator
					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = true, -- bindings for prefixed with g
				},
			},
			key_labels = {
				["<space>"] = "SPC",
				["<cr>"] = "RET",
				["<tab>"] = "TAB",
			},
			motions = {
				count = true,
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group
			},
			popup_mappings = {
				scroll_down = "<c-d>", -- binding to scroll down inside the popup
				scroll_up = "<c-u>", -- binding to scroll up inside the popup
			},
			window = {
				border = _G.border_shape, -- none, single, double, shadow
				position = "bottom", -- bottom, top
				margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
				padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
				winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
				zindex = 1000, -- positive value to position WhichKey above other floating windows.
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "left", -- align columns left, center or right
			},
			ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
			hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
			show_help = true, -- show a help message in the command line for using WhichKey
			show_keys = true, -- show the currently pressed key and its label as a message in the command line
			triggers = "auto",
			triggers_nowait = {
				"`",
				"'",
				"g`",
				"g'",
				'"',
				"<c-r>",
				"z=",
			},
			triggers_blacklist = {
				i = { "j", "k" },
				v = { "j", "k" },
			},
			disable = {
				buftypes = {},
				filetypes = {},
			},
		},
		config = function(_, opts)
			local whichkey = require("which-key")
			whichkey.setup(opts)

			whichkey.register({
				["<esc>"] = { on_esc, "Escape" },
			}, {
				mode = "n",
				silent = true,
				nowait = true,
				noremap = true,
			})

			whichkey.register({
				["f"] = {
					function()
						local text = vim.getVisualSelection()
						print(text)
						require("telescope.builtin").live_grep({ default_text = text })
					end,
					"Search current selection",
				},
			}, {
				mode = "v",
				silent = true,
				nowait = true,
				noremap = true,
			})

			whichkey.register({
				["<tab>"] = {
					"<cmd>Tabular spaces<cr>",
					"Tabular",
				},
				-- shift right by indent
				[">"] = {
					">gv",
					"Shift Right",
				},

				-- shift left by indent
				["<"] = {
					"<gv",
					"Shift Left",
				},
			}, {
				mode = "v",
				silent = true,
				nowait = true,
				noremap = true,
			})

			whichkey.register({
				["<leader>"] = {
					["w"] = {
						name = "Window",
						["h"] = { "<C-w>h", "Left" },
						["j"] = { "<C-w>j", "Down" },
						["k"] = { "<C-w>k", "Up" },
						["l"] = { "<C-w>l", "Right" },
					},
					["p"] = {
						name = "Picker",
						["i"] = { "<cmd>IconPickerYank<cr>", "Icon" },
						["h"] = { "<cmd>IlluminateToggle<cr>", "Highlight (Words under cursor)" },
						["u"] = { "<cmd>Telescope undo<cr>", "Undo" },
					},
					["e"] = { focus_or_close_nvimtree, "NvimTree" },
					["b"] = {
						name = "Buffer",
						["e"] = { "<cmd>BufferLineSortByExtension<cr>", "Sort (By extension)" },
						["E"] = { "<cmd>BufferLineSortByRelativeDirectory<cr>", "Sort (By directory)" },
						["f"] = { "<cmd>NoNeckPain<cr>", "Center" },
						["c"] = { "<cmd>bd|e#<cr>", "Close all except current" },
					},
					["g"] = {
						name = "Git",
						b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Blame" },
					},
					["P"] = {
						name = "Packages",
						u = { "<cmd>Lazy update<cr>", "Update" },
						i = { "<cmd>Lazy install<cr>", "Install" },
						s = { "<cmd>Lazy sync<cr>", "Sync" },
						x = { "<cmd>Lazy clean<cr>", "Clean" },
					},

					["t"] = {
						name = "Test",
						["n"] = { test_run, "Nearest" },
						["f"] = { test_current_file, "File" },
						["a"] = { test_attach, "Attach" },
						["s"] = { test_stop, "Stop" },
						["o"] = { test_output, "Output" },
						["c"] = { test_clear, "Clear" },
					},
					["d"] = { "<cmd>DapUiToggle<cr>", "Debug UI" },
					["D"] = {
						name = "Debug",
						["u"] = { "<cmd>DapUiToggle<cr>", "UI" },
					},
					["f"] = {
						name = "Finders",
						["f"] = { "<cmd>Telescope find_files<cr>", "Files" },
						["s"] = { "<cmd>Telescope live_grep<cr>", "Grep" },
						["r"] = { "<cmd>Telescope resume<cr>", "Recent" },
						["u"] = { "<cmd>UndotreeToggle<cr>", "Undo Tree" },
					},
					["l"] = {
						name = "Lsp",
						["F"] = { "<cmd>FormatWrite<cr>", "Format" },
						["t"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble diagnostics" },
					},
				},
			}, {
				mode = "n",
				silent = true,
				nowait = true,
				noremap = true,
			})
		end,
	},
}
