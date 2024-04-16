local M = {
	adapters = {
		delve = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/packages/delve/dlv",
				args = { "dap", "-l", "127.0.0.1:${port}" },
			},
		},
		chrome = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/chrome-debug-adapter",
		},
	},
	configurations = {
		go = {
			{
				type = "delve",
				name = "Compile module and debug this file",
				request = "launch",
				program = "./${relativeFileDirname}",
			},
			{
				type = "delve",
				name = "Compile module and debug this file (test)",
				request = "launch",
				mode = "test",
				program = "./${relativeFileDirname}",
			},
		},
		typescript = {
			{
				name = "Debug with Chromium",
				type = "chrome",
				request = "attach",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				port = 9222,
				webRoot = "${workspaceFolder}",
			},
		},
	},
}

M.configurations.javascript = M.configurations.typescript
M.configurations.javascriptreact = M.configurations.typescript
M.configurations.typescriptreact = M.configurations.typescript

return M
