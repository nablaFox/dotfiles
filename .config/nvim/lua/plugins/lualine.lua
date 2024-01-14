local custom_icon = {
	function()
		return '󰣇 '
	end,
	color = { fg = '#92d0d0', gui = 'bold' },
	padding = { left = 1, right = 1 },
}

local opts = {
	options = {
		component_separators = { left = '|', right = '|' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			'NvimTree',
			'Lazy',
		},
		ignore_focus = {
			'NvimTree'
		},
	},
	sections = {
		lualine_x = { 'filetype', custom_icon }
	}
}

local function theme()
	local custom_codedark = require('lualine.themes.codedark')

	custom_codedark.normal.a.bg = '#92b292'
	custom_codedark.normal.a.fg = '#232323'
	custom_codedark.normal.b.fg = '#92b292'

	custom_codedark.insert.a.bg = '#7aa2f7'
	custom_codedark.insert.b.fg = '#7aa2f7'

	custom_codedark.visual.a.bg = '#bb9af7'
	custom_codedark.visual.b.fg = '#bb9af7'

	custom_codedark.replace.a.bg = '#f7768e'
	custom_codedark.replace.b.fg = '#f7768e'

	return custom_codedark
end

local function config()
	opts.options.theme = theme()
	require('lualine').setup(opts)
end

return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = config
}
