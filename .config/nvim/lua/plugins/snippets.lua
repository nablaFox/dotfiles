return {
	{
		'SirVer/ultisnips',
		init = function()
			vim.g.UltiSnipsExpandTrigger = '<C-l>'
			vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
			vim.g.UltiSnipsJumpBackwardTrigger = '<C-k>'
		end
	},
	{
		'honza/vim-snippets',
	}
}
