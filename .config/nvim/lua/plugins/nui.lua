local function ask_exit_component()
	local Input = require('nui.input')
	local event = require('nui.utils.autocmd').event

	local input = Input({
		relative = 'editor',
		position = {
			row = '50%',
			col = '50%',
		},
		size = {
			width = 30,
		},
		border = {
			style = 'rounded',
			text = {
				top = 'You sure?',
				top_align = 'center',
			},
		},
		win_options = {
			winhighlight = 'Normal:Normal,FloatBorder:Normal',
		},
	}, {
		prompt = '> ',
		on_submit = function(input)
			if input == 'y' then
				vim.cmd('qa!')
			end
		end
	})

	input:on(event.BufLeave, function()
		input:unmount()
	end)

	return input
end

function AskToExit()
	ask_exit_component():mount()
end

return {
	'MunifTanjim/nui.nvim',
	lazy = false,
}
