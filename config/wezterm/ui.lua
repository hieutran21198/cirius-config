local wezterm = require("wezterm")

return {
	color_scheme = "theme2 (terminal.sexy)",
	use_fancy_tab_bar = true,
	enable_tab_bar = true,
	window_padding = {
		left = 25,
		right = 25,
		top = 25,
		bottom = 25,
	},
	inactive_pane_hsb = {
		brightness = 1,
	},
	show_new_tab_button_in_tab_bar = true,
	tab_bar_at_bottom = true,
	cursor_blink_ease_in = "Linear",
	cursor_blink_ease_out = "EaseOut",
	cursor_blink_rate = 800,
	cursor_thickness = 1.0,
	default_cursor_style = "SteadyBlock",
	line_height = 1,
	window_background_opacity = 1,
	animation_fps = 120,
	max_fps = 120,
	font_size = 11.25,
	adjust_window_size_when_changing_font_size = false,
	font_rules = {
		{
			intensity = "Bold",
			font = wezterm.font("JetbrainsMono Nerd Font Mono"),
		},
	},
	enable_scroll_bar = true,
}
