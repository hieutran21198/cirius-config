local wezterm = require("wezterm")

return {
	color_scheme = "GruvboxDarkHard",
	use_fancy_tab_bar = false,
	colors = {
		tab_bar = {
			active_tab = {
				bg_color = "#1e1e2e",
				fg_color = "#cdd6f4",
				intensity = "Bold",
			},
			inactive_tab = {
				bg_color = "#313244",
				fg_color = "#9399b2",
			},
			inactive_tab_hover = {
				bg_color = "#11111b",
				fg_color = "#cdd6f4",
			},
			new_tab = {
				bg_color = "#181825",
				fg_color = "#cdd6f4",
			},
			new_tab_hover = {
				bg_color = "#1e1e2e",
				fg_color = "#cdd6f4",
			},
		},
	},
	window_frame = {
		inactive_titlebar_bg = "#171723",
		active_titlebar_bg = "#171723",
		inactive_titlebar_fg = "#9399b2",
		active_titlebar_fg = "#cdd6f4",
	},
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
	cursor_blink_ease_in = "EaseIn",
	cursor_blink_ease_out = "EaseOut",
	cursor_blink_rate = 800,
	cursor_thickness = 1.0,
	default_cursor_style = "BlinkingBar",
	line_height = 1,
	window_background_opacity = 1,
	animation_fps = 120,
	font_size = 12,
	adjust_window_size_when_changing_font_size = false,
	font_rules = {
		{
			intensity = "Bold",
			font = wezterm.font("JetbrainsMono Nerd Font Mono"),
			italic = false,
		},
	},
	enable_scroll_bar = false,
}
