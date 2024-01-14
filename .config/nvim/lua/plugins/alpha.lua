local if_nil = vim.F.if_nil
local leader = 'SPC'

local function button(sc, txt, keybind, keybind_opts)
	local sc_ = sc:gsub('%s', ''):gsub(leader, '<leader>')

	local opts = {
		position = 'center',
		shortcut = sc,
		cursor = 3,
		width = 20,
		align_shortcut = 'right',
		hl_shortcut = 'AlphaShortcut',
		hl = 'AlphaButtonText'
	}

	if keybind then
		keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
		opts.keymap = { 'n', sc_, keybind, keybind_opts }
	end

	local function on_press()
		local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. '<Ignore>', true, false, true)
		vim.api.nvim_feedkeys(key, 't', false)
	end

	return {
		type = 'button',
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end

local banner = {
	'   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ',
	'    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
	'          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ',
	'           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
	'          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
	'   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
	'  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
	' ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
	' ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ',
	'      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ',
	'       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ',
}

local header = {
	type = 'group',
	val = {
		{
			type = 'padding',
			val = 11
		},
		{
			type = 'text',
			val = banner,
			opts = { position = 'center', hl = 'Hydra' }
		},
	}
}

local buttons = {
	type = 'group',
	val = {
		{
			type = 'text',
			val = '    iceCube󰐰 ',
			opts = { position = 'center', hl = 'Statement' }
		},
		{
			type = 'padding',
			val = 1
		},
		{
			type = 'group',
			val = {
				button('N', '  Start Editing', ':ene <BAR> startinsert <CR>'),
				button('S', '󰁯  Resume', ':NeovimProjectLoadRecent <CR>'),
				button('F', '󰈞  Find Files', ':Telescope find_files<CR>'),
				button('R', '󱋡  Recents', ':Telescope oldfiles<CR>'),
				button('W', '󰈭  Find Word', ':Telescope live_grep<CR>'),
			},
			opts = { spacing = 1, position = 'center' }
		}
	},
}

local footer = {
	type = 'group',
	val = {
		{
			type = 'text',
			val = 'Less is more',
			opts = { position = 'center', hl = 'AlphaFooter', wrap = 'overflow' }
		}
	},
	opts = {
		spacing = 0,
		width = 10
	}
}

local section = {
	type = 'group',
	val = {
		header,
		buttons,
		footer
	},
	opts = {
		margin = 5,
		spacing = 4
	}
}

local function init()
	create_group('AlphaGroup')

	aucmd({ 'VimEnter' }, {
		pattern = '*',
		group = 'AlphaGroup',
		callback = function()
			if next(vim.fn.argv()) == nil then
				status_bar_off()
			end
		end,
		desc = 'Disable the status bar on the starting page'
	})

	aucmd({ 'User' }, {
		pattern = 'AlphaClosed',
		group = 'AlphaGroup',
		callback = status_bar_on,
		desc = 'Re-enable the status bar after leaving the starting page'
	})
end

return {
	'goolord/alpha-nvim',
	opts = {
		layout = { section }
	},
	init = init
}
