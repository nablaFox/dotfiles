return {
	'nvim-tree/nvim-tree.lua',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		sort = {
			sorter = 'case_sensitive'
		},
		view = {
			width = 31
		},
		renderer = {
			group_empty = true,
			highlight_git = true,
			icons = {
				git_placement = 'after',
				modified_placement = 'before',
				glyphs = {
					git = {
						unstaged = '',
						staged = '',
						unmerged = '',
						renamed = '',
						untracked = '',
						deleted = '',
						ignored = '',
					},
				}
			}
		},
		filters = {
			-- dotfiles = true,
			custom = { '^\\.git$' },
			exclude = { '.nvim.lua', '.env' }
		},
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		update_focused_file = {
			enable = true,
			-- update_root = true
		},
	},
	keys = {
		{ '<C-n>', '<cmd>NvimTreeToggle<CR>', desc = 'toggles the tree' },
	},
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	lazy = false
}
