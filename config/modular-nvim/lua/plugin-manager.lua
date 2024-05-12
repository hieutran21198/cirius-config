local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazy_path,
	})
end

vim.opt.rtp:prepend(lazy_path)

local M = {}

---@class SetupLazyInput
---@field path string | nil
---@field branch string | nil
---@field lazy_opts table | nil

---@param input SetupLazyInput | nil
M.setup = function(input)
	input = input or {}

	local p = input.path or lazy_path
	local b = input.branch or "stable"

	if not vim.loop.fs_stat(p) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=" .. b,
			p,
		})
	end

	vim.opt.rtp:prepend(p)

	local ok, lazy = pcall(require, "lazy")
	if not ok then
		print("Failed to load lazy.nvim")
		return
	end

	local lazy_opts = {
		change_detection = {
			enabled = false,
			notify = false,
		},
	}

	lazy.setup("module", vim.tbl_deep_extend("force", lazy_opts, input.lazy_opts or {}))
end

return M
