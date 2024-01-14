return {
	'jackMort/ChatGPT.nvim',
	event = 'VeryLazy',
	config = function()
		require('chatgpt').setup({
			popup_input = {
				submit = '<CR>'
			}
		})
	end,
	dependencies = {
		'MunifTanjim/nui.nvim',
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope.nvim'
	},
	enabled = false
}
