local M = {}

M.focus_or_close = function()
	local win = vim.api.nvim_get_current_win()
	if vim.bo.filetype == "NvimTree" then
		vim.api.nvim_win_close(win, true)
	else
		vim.cmd("NvimTreeRefresh")
		vim.cmd("NvimTreeFocus")
	end
end

return M
