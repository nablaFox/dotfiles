local keys = {
	{ '<leader>ff',  '<cmd>Telescope find_files theme=ivy previewer=true find_command=rg,--no-ignore,--hidden,--files<CR>', desc = 'Search files' },
	{ '<leader>fh',  '<cmd>Telescope find_files hidden=true<CR>',                                                           desc = 'Find hidden files' },
	{ '<leader>fs',  '<cmd>Telescope grep_string<CR>',                                                                      desc = 'Grep string' },
	{ '<leader>fo',  '<cmd>Telescope oldfiles<CR>',                                                                         desc = 'Find old files' },
	{ '<leader>ft',  '<cmd>Telescope colorscheme<CR>' },
	{ '<C-x>b',      '<cmd>Telescope buffers<CR>',                                                                          desc = 'Find buffer' },
	{ '<C-f>',       '<cmd>Telescope current_buffer_fuzzy_find<CR>',                                                        desc = 'Search in current file' },
	{ '<C-x>f',      '<cmd>Telescope live_grep<CR>',                                                                        desc = 'Grep through files' },
	{ '<leader>k',   '<cmd>Telescope keymaps<CR>',                                                                          desc = 'Search keymaps' },
	{ '<leader>n',   '<cmd>Telescope notify theme=dropdown<CR>',                                                            desc = 'Notifications history' },
	{ '<leader>gbc', '<cmd>Telescope git_bcommits<CR>',                                                                     desc = 'Git bcommits' },
	{ '<leader>gc',  '<cmd>Telescope git_commits<CR>',                                                                      desc = 'Git commits' },
	{ '<leader>p',   '<cmd>Telescope neovim-project discover theme=dropdown<CR>',                                           desc = 'Workspaces' },
	{
		'<C-p>',
		function()
			local is_git_repo = vim.fn.system('git rev-parse --is-inside-work-tree')
			if is_git_repo:match('true') then
				require('telescope.builtin').git_files()
			else
				require('telescope.builtin').find_files()
			end
		end,
		desc = 'Palette'
	}
}

local opts = function()
	local actions = require('telescope.actions')
	local layout_action = require('telescope.actions.layout')
	local state_action = require('telescope.actions.state')
	local builtin = require('telescope.builtin')

	local function change_cwd(prompt_bufnr, cwd)
		local current_query = state_action.get_current_line()
		actions.close(prompt_bufnr)

		builtin.find_files({
			cwd = cwd,
			default_text = current_query
		})
	end

	local hidden = false
	local function toggle_hidden_files(prompt_bufnr)
		hidden = not hidden
		local current_query = state_action.get_current_line()
		actions.close(prompt_bufnr)

		builtin.find_files({
			hidden = hidden,
			default_text = current_query
		})
	end

	return {
		defaults = {
			file_ignore_patterns = {
				'node_modules', 'build', 'dist', 'yarn.lock',
			},
			mappings = {
				n = {
					['<C-p>'] = layout_action.toggle_preview,
					['<A-s>'] = toggle_hidden_files,
					['<A-a>'] = function(prompt_bufnr) change_cwd(prompt_bufnr, '$HOME') end,
					['<A-d>'] = function(prompt_bufnr) change_cwd(prompt_bufnr, '$HOME/.config/nvim/') end
				},
				i = {
					['<C-p>'] = layout_action.toggle_preview,
					['<A-s>'] = toggle_hidden_files,
					['<A-a>'] = function(prompt_bufnr) change_cwd(prompt_bufnr, '$HOME') end,
					['<A-d>'] = function(prompt_bufnr) change_cwd(prompt_bufnr, '$HOME/.config/nvim/') end
				},
			}
		},
		pickers = {
			find_files = { theme = 'dropdown', previewer = false },
			git_files = { theme = 'dropdown', previewer = false },
			current_buffer_fuzzy_find = { theme = 'dropdown', previewer = false },
		},
	}
end

function FindDotFiles()
	require('telescope.builtin').find_files({
		cwd = os.getenv('HOME') .. '/.config/nvim'
	})
end

function FindHomeFiles()
	require('telescope.builtin').find_files({
		cwd = os.getenv('HOME')
	})
end

command('FindHome', ':lua FindHomeFiles()', {})
command('FindDots', ':lua FindDotFiles()', {})

return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.4',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = keys,
	opts = opts,
	lazy = false
}
