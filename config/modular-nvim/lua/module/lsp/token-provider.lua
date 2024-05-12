local M = {}

M.gopls = {
	full = true,
	legend = {
		tokenTypes = {
			"namespace",
			"type",
			"class",
			"enum",
			"interface",
			"struct",
			"typeParameter",
			"parameter",
			"variable",
			"property",
			"enumMember",
			"event",
			"function",
			"method",
			"macro",
			"keyword",
			"modifier",
			"comment",
			"string",
			"number",
			"regexp",
			"operator",
		},
		tokenModifiers = {
			"declaration",
			"definition",
			"readonly",
			"static",
			"deprecated",
			"abstract",
			"async",
			"modification",
			"documentation",
			"defaultLibrary",
		},
	},
	range = true,
}

return function(server_name)
	return M[server_name] or {}
end
