return {
	'rcarriga/nvim-notify',
	opts = {
		render = 'compact',
		stages = 'static',
	},
	init = function()
		vim.opt.termguicolors = true
		vim.notify = require('notify')
		vim.opt.termguicolors = false
		require('telescope').load_extension('notify')
	end
}
