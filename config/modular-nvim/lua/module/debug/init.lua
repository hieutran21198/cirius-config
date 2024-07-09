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
	{
		"leoluz/nvim-dap-go",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-go").setup({
				dap_configurations = {
					{
						type = "go",
						name = "Attach remote",
						mode = "remote",
						request = "attach",
					},
				},
				-- delve configurations
				delve = {
					path = "dlv",
					initialize_timeout_sec = 20,
					port = "${port}",
					-- additional args to pass to dlv
					args = {},
					build_flags = "",
					detached = true,
					cwd = nil,
				},
			})
		end,
	},
}
