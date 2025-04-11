local keys = {
	{ '<Leader>lg', ':lua _LAZYGIT_TOGGLE()<CR>', desc = 'toggle lazygit' },
}

return {
	'akinsho/toggleterm.nvim',
	opts = {
		open_mapping = [[ù]],
		size = 20,
		hide_numbers = true,
		terminal_mappings = true,
		shading_factor = 2,
		shade_filetypes = {},
		shade_terminals = true,
		start_in_insert = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		auto_scroll = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
			winblend = 0
		}
	},
	init = function()
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

		function _LAZYGIT_TOGGLE()
			lazygit:toggle()
		end
	end,
	keys = keys,
	lazy = true
}
