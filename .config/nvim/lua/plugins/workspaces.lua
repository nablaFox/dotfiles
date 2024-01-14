local function init()
	create_group('Workspaces')
	aucmd({ 'User' }, {
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
			'~/.config/eww',
			'~/Work/*',
			'~/Work/Notes/Programmazione-1'
		},
		last_session_on_startup = false
	},
	init = init,
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
		{ 'nvim-telescope/telescope.nvim', tag = '0.1.4' },
		{ 'Shatur/neovim-session-manager' },
	},
	priority = 100,
	lazy = false
}
