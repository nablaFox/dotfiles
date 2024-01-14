create_group('user_cmds', { clear = true })

aucmd('FileType', {
	pattern = 'help',
	command = 'wincmd L',
	group = 'user_cmds'
})

aucmd('RecordingEnter', {
	pattern = '*',
	callback = function()
		vim.opt_local.cmdheight = 1
	end,
	group = 'user_cmds'
})

-- aucmd('RecordingLeave', {
-- 	pattern = '*',
-- 	callback = function()
-- 		local timer = vim.loop.new_timer()
-- 		timer:start(
-- 			50,
-- 			0,
-- 			vim.schedule_wrap(function()
-- 				vim.opt_local.cmdheight = 0
-- 			end)
-- 		)
-- 	end,
-- 	group = 'user_cmds'
-- })
