return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local adapter_config = require("module.debug.adapter")

			for name, adapter in pairs(adapter_config or {}) do
				if adapter.setup ~= nil then
					dap.adapters[name] = adapter.setup
				end

				if adapter.config ~= nil then
					dap.configurations[name] = adapter.config
				end
			end
		end,
	},
}
