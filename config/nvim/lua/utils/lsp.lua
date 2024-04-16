local M = {}

M.create_capabilities = function(...)
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	for _, v in ipairs({ ... }) do
		if type(v) == "function" then
			capabilities = v(capabilities)
		else
			print("passed invalid argument to create_capabilities")
			print(v)
		end
	end

	return capabilities
end

return M
