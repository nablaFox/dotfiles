local widget = 'controlpanel'

AddTask(1, {
	cmd = F 'eww open {widget}',
})

AddTask(0, {
	cmd = F 'eww close {widget} && eww open {widget}'
})

AddTask(7, {
	cmd = 'eww logs'
})

AddTask(9, {
	cmd = 'eww daemon'
})

AddTask(8, {
	cmd = 'eww kill'
})
