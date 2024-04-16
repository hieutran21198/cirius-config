local ui = require("ui")
local macos = require("macos")
-- local linux = require("linux")
local util = require("util")

local keybindings = require("keybindings")

local config = {
	default_prog = { "/usr/bin/fish", "-l" },
	use_ime = false, -- terminal should not use IME
	front_end = "WebGpu", -- unleases the power of GPU
	webgpu_power_preference = "HighPerformance", -- use high performance
	warn_about_missing_glyphs = false,
	selection_word_boundary = " \t\n{}[]()\"'`,;:│=&!%",
	launch_menu = {
		{
			args = { "btop" },
		},
	},
}

return util.merge_table(config, keybindings, ui, macos)
