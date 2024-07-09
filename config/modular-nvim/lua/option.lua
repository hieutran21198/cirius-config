local gs = {
	mapleader = " ",
	maplocalleader = "\\",
	root_spec = { "lsp", { ".git", "lua" }, "cwd" },
	loaded_netrw = 1,
	loaded_netrwPlugin = 1,
}

local opts = {
	timeout = true,
	autowrite = true, -- Enable auto write
	clipboard = "unnamedplus", -- Sync with system clipboard
	completeopt = "menu,menuone,noselect",
	conceallevel = 3, -- Hide * markup for bold and italic
	confirm = true, -- Confirm to save changes before exiting modified buffer
	cursorline = true, -- Enable highlighting of the current line
	expandtab = true, -- Use spaces instead of tabs
	formatoptions = "jcroqlnt", -- tcqj
	grepformat = "%f:%l:%c:%m",
	grepprg = "rg --vimgrep",
	ignorecase = true, -- Ignore case
	inccommand = "nosplit", -- preview incremental substitute
	laststatus = 3, -- global statusline
	list = true, -- Show some invisible characters (tabs...
	mouse = "a", -- Enable mouse mode
	number = true, -- Print line number
	pumblend = 10, -- Popup blend
	pumheight = 10, -- Maximum number of entries in a popup
	relativenumber = false, -- Relative line numbers
	scrolloff = 4, -- Lines of context
	shiftround = true, -- Round indent
	shiftwidth = 2, -- Size of an indent
	showmode = false, -- Dont show mode since we have a statusline
	sidescrolloff = 8, -- Columns of context
	signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time
	smartcase = true, -- Don't ignore case with capitals
	smartindent = true, -- Insert indents automatically
	spelllang = { "en" },
	splitbelow = true, -- Put new windows below current
	splitkeep = "screen",
	splitright = true, -- Put new windows right of current
	tabstop = 2, -- Number of spaces tabs count for
	termguicolors = true, -- True color support
	timeoutlen = 300,
	undofile = true,
	undolevels = 10000,
	updatetime = 200, -- Save swap file and trigger CursorHold
	virtualedit = "block", -- Allow cursor to move where there is no text in visual block mode
	wildmode = "longest:full,full", -- Command-line completion mode
	winminwidth = 5, -- Minimum window width
	wrap = false, -- Disable line wrap
	fillchars = {
		foldopen = "",
		foldclose = "",
		fold = " ",
		foldsep = " ",
		diff = "╱",
		eob = " ",
	},
	listchars = {
		space = " ",
		tab = "  ",
	},
	foldlevel = 99,
	sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",
}

local M = {}

--- @class SetupOptionInput
--- @field gs table<string, any> | nil
--- @field opts table<string, any> | nil

--- @param args SetupOptionInput | nil
M.setup = function(args)
	args = args or {}

	for k, v in pairs(vim.tbl_deep_extend("force", gs, args.gs)) do
		vim.g[k] = v
	end

	for k, v in pairs(vim.tbl_deep_extend("force", opts, args.opts)) do
		vim.opt[k] = v
	end

	vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
end

return M
