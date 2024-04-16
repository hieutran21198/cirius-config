return {
	{
		"mfussenegger/nvim-dap",
		event = "User BaseFile",
		dependencies = {
			{
				"jay-babu/mason-nvim-dap.nvim",
				"jbyuki/one-small-step-for-vimkind",
				dependencies = { "nvim-dap" },
				cmd = { "DapInstall", "DapUninstall" },
				opts = { handlers = {} },
			},
			{
				"rcarriga/nvim-dap-ui",
				opts = { floating = { border = "rounded" } },
				config = function(_, opts)
					local dap, dapui = require("dap"), require("dapui")
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close()
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close()
					end
					dapui.setup(opts)
				end,
			},
			{
				"rcarriga/cmp-dap",
				dependencies = { "nvim-cmp" },
				config = function()
					require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
						sources = {
							{ name = "dap" },
						},
					})
				end,
			},
		},
		config = function()
			local dap = require("dap")
			local dap_uc = require("user_config.debug")

			for _, adapter in ipairs(dap_uc.adapters or {}) do
				dap.adapters[adapter.name] = adapter.config
			end

			for _, configuration in ipairs(dap_uc.configurations or {}) do
				dap.configurations[configuration.name] = configuration.config
			end
		end,
	},

	{
		"nvim-neotest/neotest",
		cmd = { "Neotest" },
		dependencies = {
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-jest",
		},
		opts = function()
			return {
				adapters = {
					require("neotest-go"),
					require("neotest-jest"),
				},
			}
		end,
		config = function(_, opts)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
			require("neotest").setup(opts)
		end,
	},
	{
		"andythigpen/nvim-coverage",
		cmd = {
			"Coverage",
			"CoverageLoad",
			"CoverageLoadLcov",
			"CoverageShow",
			"CoverageHide",
			"CoverageToggle",
			"CoverageClear",
			"CoverageSummary",
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("coverage").setup()
		end,
	},
}
