local keys = {
	{ '<leader>p', '<cmd>Telescope neovim-project discover theme=dropdown previewer=false<CR>', desc = 'workspaces' },
	{ '<space>q',  '<cmd>NeovimProjectLoadRecent<CR>',                                          desc = 'resume project' }
}

local function init()
	vim.api.nvim_create_augroup('Workspaces', { clear = true })

	vim.api.nvim_create_autocmd({ 'User' }, {
		pattern = 'SessionLoadPost',
		group = 'Workspaces',
		callback = function()
			require('nvim-tree.api').tree.toggle(false, true)
		end,
		desc = 'Open neovim tree when loading sessions'
	})

	vim.opt.sessionoptions:append('globals')
end

return {
	'coffebar/neovim-project',
	opts = {
		projects = {
			'~/Projects/*',
			'~/.config/nvim',
			'~/Work/*',
		},
		last_session_on_startup = false
	},
	init = init,
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
		{ 'nvim-telescope/telescope.nvim' },
		{ 'Shatur/neovim-session-manager' },
	},
	priority = 100,
	keys = keys,
	lazy = false
}
