require("plugins.gvars")

require("config.options").setup({
	gs = _G.gs,
	opts = _G.opts,
})

require("plugin-manager").setup({
	path = _G.lazy_path,
	branch = "stable",
})

require("plugins.keymaps.autocmds")
