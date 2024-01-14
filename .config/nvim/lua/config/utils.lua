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

-- string interpolation
F = {}

local load = load

if _VERSION == 'Lua 5.1' then
	load = function(code, name, _, env)
		local fn, err = loadstring(code, name)
		if fn then
			setfenv(fn, env)
			return fn
		end
		return nil, err
	end
end

local function scan_using(scanner, arg, searched)
	local i = 1
	repeat
		local name, value = scanner(arg, i)
		if name == searched then
			return true, value
		end
		i = i + 1
	until name == nil
	return false
end

local function snd(_, b) return b end

local function format(_, str)
	local outer_env = _ENV and
		(snd(scan_using(debug.getlocal, 3, '_ENV')) or snd(scan_using(debug.getupvalue, debug.getinfo(2, 'f').func, '_ENV')) or _ENV) or
		getfenv(2)
	return (str:gsub('%b{}', function(block)
		local code, fmt = block:match('{(.*):(%%.*)}')
		code = code or block:match('{(.*)}')
		local exp_env = {}
		setmetatable(exp_env, {
			__index = function(_, k)
				local ok, value = scan_using(debug.getupvalue, debug.getinfo(6, 'f').func, k)
				if ok then return value end
				ok, value = scan_using(debug.getlocal, 7, k)
				if ok then return value end
				return rawget(outer_env, k)
			end
		})
		local fn, err = load('return ' .. code, 'expression `' .. code .. '`', 't', exp_env)
		if fn then
			return fmt and string.format(fmt, fn()) or tostring(fn())
		else
			error(err, 0)
		end
	end))
end

setmetatable(F, {
	__call = format
})
