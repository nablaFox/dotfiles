return {
	{
		'windwp/nvim-ts-autotag',
		config = true
	},
	{
		'abecodes/tabout.nvim',
		opts = {
			tabkey = '<C-à>',
			backwards_tabkey = '<A-à>',
			act_as_tab = false,
		}
	},
	{
		'nvim-treesitter/nvim-treesitter',
		priority = 999,
		opts = {
			autotag = {
				enable = true,
			},
			ensure_installed = {
				'cpp',
				'python',
				'vim',
				'sql',
				'lua',
				'json',
				'c',
				'javascript',
				'typescript',
				'css',
				'bash',
				'json',
				'markdown',
				'markdown_inline',
				'vue'
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<CR>',
					scope_incremental = '<CR>',
					node_incremental = '<TAB>',
					node_decremental = '<S-TAB>',
				}
			}
		},
		main = 'nvim-treesitter.configs'
	}
}
