local M = {}

M.border = function(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

M.icons = {
	Namespace = "󰌗",
	Text = "󰉿",
	Method = "󰆧",
	Function = "󰆧",
	Constructor = "",
	Field = "󰜢",
	Variable = "󰀫",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈚",
	Reference = "󰈇",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "󰙅",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰊄",
	Table = "",
	Object = "󰅩",
	Tag = "",
	Array = "[]",
	Boolean = "",
	Number = "",
	Null = "󰟢",
	String = "󰉿",
	Calendar = "",
	Watch = "󰥔",
	Package = "",
	Copilot = "",
	Codeium = "",
	TabNine = "",
}

M.has_word_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end

	local place = vim.api.nvim_win_get_cursor(0)
	local line, col = unpack(place)

	if col == 0 then
		return false
	end

	return vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

M.next_suggestion = function(fallback)
	local cmp = require("cmp")

	if cmp.visible() and M.has_word_before() then
		cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
		return
	end

	local snippy = require("snippy")
	if snippy.can_expand_or_advance() then
		snippy.expand_or_advance()
		return
	end

	fallback()
end

M.previous_suggestion = function(fallback)
	local cmp = require("cmp")

	if cmp.visible() and M.has_word_before() then
		cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
		return
	end

	local snippy = require("snippy")
	if snippy.can_jump(-1) then
		snippy.previous()
		return
	end

	fallback()
end

return M
