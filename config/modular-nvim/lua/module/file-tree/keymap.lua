local util = require("module.file-tree.util")

return {
	{ "<leader>e", util.focus_or_close, desc = 'Focus or close the "File Tree"' },
}
