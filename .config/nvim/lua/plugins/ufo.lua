return {
	{
		'luukvbaal/statuscol.nvim',
		config = function()
			local builtin = require('statuscol.builtin')
			require('statuscol').setup({
				relculright = true,
				segments = {
					{ text = { builtin.foldfunc },      click = 'v:lua.ScFa' },
					{ text = { '%s' },                  click = 'v:lua.ScSa' },
					{ text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' }
				}
			})
		end,
		lazy = false
	},
	{
		'kevinhwang91/nvim-ufo',
		keys = {
			{ 'zR', ':lua require("ufo").openAllFolds()<CR>',  desc = 'open all folds' },
			{ 'zM', ':lua require("ufo").closeAllFolds()<CR>', desc = 'close all folds' }
		},
		config = function()
			vim.o.foldcolumn = '1'
			vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			require('ufo').setup({
				provider_selector = function()
					return { 'treesitter', 'indent' }
				end
			})
		end,
		dependencies = { 'kevinhwang91/promise-async' },
		lazy = false
	} }
