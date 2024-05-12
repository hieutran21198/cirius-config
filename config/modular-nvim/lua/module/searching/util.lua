local M = {}

local get_selected_text_in_visual_mode = function()
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

M.search_selected_text_in_visual_mode = function()
	local text = get_selected_text_in_visual_mode()
	require("telescope.builtin").live_grep({ default_text = text })
end

return M
