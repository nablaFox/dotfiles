local function map(mode, comb, cmd, desc, opts)
	local custom_opts = {
		noremap = true,
		silent = true,
		desc = desc
	}

	if opts ~= nil then
		custom_opts = opts
		custom_opts.desc = desc
	end

	vim.api.nvim_set_keymap(mode, comb, cmd, custom_opts)
end

function nmap(comb, cmd, desc, opts)
	map('n', comb, cmd, desc, opts)
end

function vmap(comb, cmd, desc, opts)
	map('v', comb, cmd, desc, opts)
end

function imap(comb, cmd, desc, opts)
	map('i', comb, cmd, desc, opts)
end

function xmap(comb, cmd, desc, opts)
	map('x', comb, cmd, desc, opts)
end

function omap(comb, cmd, desc, opts)
	map('o', comb, cmd, desc, opts)
end

function command(name, action, opts)
	vim.api.nvim_create_user_command(name, action, opts)
end

function create_group(group, opts)
	if opts == nil then opts = {} end
	return vim.api.nvim_create_augroup(group, opts)
end

function aucmd(event, opts)
	vim.api.nvim_create_autocmd(event, opts)
end

function status_bar_off()
	vim.o.laststatus = 0
	vim.o.cmdheight = 0
end

function status_bar_on()
	vim.o.laststatus = 2
	vim.o.cmdheight = 1
end

function toggle_status_bar()
	vim.o.laststatus = vim.o.laststatus == 0 and 2 or 0
end

local taskCounter = 0
function AddTask(num, opts)
	local Terminal = require('toggleterm.terminal').Terminal

	local default_opts = {
		close_on_exit = false,
	}

	if opts == nil then opts = {} end
	opts = vim.tbl_extend('force', default_opts, opts)

	local task = Terminal:new(opts);

	taskCounter = taskCounter + 1
	local hash = string.format('task%d', taskCounter)

	_G['_TASK_TOGGLE' .. hash] = function()
		task:toggle()
	end

	local key = '<C-' .. num .. '>'
	nmap(key, '<cmd>lua _TASK_TOGGLE' .. hash .. '()<CR>', 'Toggle task ' .. num)
end
