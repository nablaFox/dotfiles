return {
	{
		'numToStr/Comment.nvim',
		lazy = false,
		config = true
	},
	{
		'nvim-tree/nvim-web-devicons',
		lazy = true
	},
	{
		'karb94/neoscroll.nvim',
		config = true,
		opts = {
			mappings = {
				'<C-u>', '<C-d>', '<C-b>', 'zb',
				'<C-y>', '<C-e>', 'zt', 'zz'
			}
		}
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		opts = {
			scope = {
				show_start = false,
				show_end = false,
			},
		},
	},
	{
		'tpope/vim-surround',
		version = '*',
		event = 'VeryLazy',
	},
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		config = true
	},
	{ 'folke/zen-mode.nvim' },
	{ 'github/copilot.vim', lazy = false },
	{
		'ggandor/leap.nvim',
		config = function()
			require('leap').add_default_mappings()
			require('leap').opts.special_keys.next_group = '<è>'
		end
	},
	{
		'klen/nvim-config-local',
		opts = {
			config_files = { '.nvim.lua' },
			silent = true,
			lookup_parents = true,
			autocommands_create = true
		}
	},
	{ 'chrisgrieser/nvim-spider', lazy = true },
	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
	}
}
