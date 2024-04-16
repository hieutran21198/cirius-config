local M = {}

M.merge_table = function(...)
	local config = {}

	for _, tbl in ipairs({ ... }) do
		for k, v in pairs(tbl) do
			config[k] = v
		end
	end

	return config
end

M.is_macos = function()
	return os.getenv("HOME") == "/Users/$(whoami)"
end

return M
