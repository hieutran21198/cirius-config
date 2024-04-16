local M = {}

M.select_next = function(fallback)
	local cmp = require("cmp")
	local snippy = require("snippy")

	if cmp.visible() then
		cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
	else
		if snippy.can_expand_or_advance() then
			snippy.expand_or_advance()
		else
			fallback()
		end
	end
end

M.select_previous = function(fallback)
	local cmp = require("cmp")
	local snippy = require("snippy")

	if cmp.visible() then
		cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
	else
		if snippy.can_jump(-1) then
			snippy.previous()
		else
			fallback()
		end
	end
end

M.format_fn = function(entry, vim_item)
	local lspkind = require("lspkind")

	local fallback_finds = {
		String = "󰦨",
		Copilot = "",
	}

	local kind = lspkind.presets.default[vim_item.kind]
	if kind == nil then
		kind = fallback_finds[vim_item.kind]

		if kind == nil then
			print("kind not found: " .. vim_item.kind)
			kind = ""
		end
	end

	vim_item.kind = kind

	local sources = {
		nvim_lsp = "[LSP]",
		snippy = "[Snippets]",
		nvim_lua = "[Lua]",
		copilot = "[Copilot]",
	}

	local source = sources[entry.source.name]
	if source == nil then
		source = "[" .. entry.source.name .. "]"
	end

	vim_item.menu = source

	return vim_item
end

return M
