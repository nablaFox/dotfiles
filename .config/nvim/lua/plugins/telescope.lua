local keys = {
	{ '<leader>ff',  '<cmd>Telescope find_files theme=ivy previewer=true find_command=rg,--no-ignore,--hidden,--files<CR>', desc = 'search files' },
	{ '<leader>fh',  '<cmd>Telescope find_files hidden=true<CR>',                                                           desc = 'sind hidden files' },
	{ '<leader>fs',  '<cmd>Telescope grep_string<CR>',                                                                      desc = 'srep string' },
	{ '<leader>fo',  '<cmd>Telescope oldfiles<CR>',                                                                         desc = 'sind old files' },
	{ '<leader>ft',  '<cmd>Telescope colorscheme<CR>' },
	{ '<C-x>b',      '<cmd>Telescope buffers<CR>',                                                                          desc = 'find buffer' },
	{ '<C-f>',       '<cmd>Telescope current_buffer_fuzzy_find<CR>',                                                        desc = 'search in current file' },
	{ '<C-x>f',      '<cmd>Telescope live_grep<CR>',                                                                        desc = 'grep through files' },
	{ '<leader>k',   '<cmd>Telescope keymaps<CR>',                                                                          desc = 'search keymaps' },
	{ '<leader>n',   '<cmd>Telescope notify theme=dropdown<CR>',                                                            desc = 'notifications history' },
	{ '<leader>gbc', '<cmd>Telescope git_bcommits<CR>',                                                                     desc = 'git bcommits' },
	{ '<leader>gc',  '<cmd>Telescope git_commits<CR>',                                                                      desc = 'git commits' },
	{ '<leader>gb',  '<cmd>Telescope git_branches<CR>',                                                                     desc = 'git commits' },
	{ "<space>a",    "<cmd>Telescope diagnostics<CR>",                                                                      desc = "show diagnostic list",  nowait = true },
	{ "<space>e",    "<cmd>Telescope lsp_extensions<CR>",                                                                   desc = "show extension list",   nowait = true },
	{ "<space>c",    "<cmd>Telescope commands<CR>",                                                                         desc = "show command list",     nowait = true },
	{ "<space>o",    "<cmd>Telescope lsp_document_symbols<CR>",                                                             desc = "show outline",          nowait = true },
	{ "<space>s",    "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",                                                    desc = "show symbol list",      nowait = true },
	{
		'<C-p>',
		function()
			local is_git_repo = vim.fn.system('git rev-parse --is-inside-work-tree')
			if is_git_repo:match('true') then
				require('telescope.builtin').git_files({ show_untracked = true })
			else
				require('telescope.builtin').find_files()
			end
		end,
		desc = 'Palette'
	},
}

local opts = function()
	require('telescope').load_extension('fzf')
	local actions = require('telescope.actions')
	local layout_action = require('telescope.actions.layout')
	local state_action = require('telescope.actions.state')
	local builtin = require('telescope.builtin')

	local show_hidden = false
	local function toggle_hidden_files(prompt_bufnr)
		show_hidden = not show_hidden

		local current_query = state_action.get_current_line()
		actions.close(prompt_bufnr)

		builtin.find_files({
			hidden = show_hidden,
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
				},
				i = {
					['<C-p>'] = layout_action.toggle_preview,
					['<A-s>'] = toggle_hidden_files,
				},
			}
		},
		pickers = {
			find_files = { theme = 'dropdown', previewer = false },
			git_files = { theme = 'dropdown', previewer = false },
			current_buffer_fuzzy_find = { theme = 'dropdown', previewer = false },
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = false,
				override_file_sorter = true,
				case_mode = 'smart_case'
			}
		}
	}
end

return {
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make"
	},
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = keys,
		opts = opts,
		lazy = false
	}
}
