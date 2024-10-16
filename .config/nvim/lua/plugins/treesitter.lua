return {
	{
		'windwp/nvim-ts-autotag',
		opts = {}
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		enabled = true,
		config = function()
			local ts_config = require("nvim-treesitter.configs")
			ts_config.setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
				},
			})
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = vim.fn.argc(-1) == 0,
		priority = 999,
		opts_extend = { "ensure_installed" },
		opts = {
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
			highlight = { enable = true },
			indent = { enable = true },
		},
		main = 'nvim-treesitter.configs'
	}
}
