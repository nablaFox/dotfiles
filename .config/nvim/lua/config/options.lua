vim.cmd([[
    syntax enable
	let mapleader = ","
	set scrolloff=8
	set exrc
    set number
	set laststatus=0
    set ruler
    set visualbell
    set wrap
    set autoindent
    set smartindent
    set tabstop=4
    set shiftwidth=4
    set noexpandtab
    set clipboard+=unnamedplus
    set cursorline
    set nowrap
	set noshowmode
	set noshowcmd
	cnoreabbrev h vert h
]])

vim.api.nvim_exec([[
	au! BufRead,BufNewFile *.vert,*.frag,*.comp,*.rchit,*.rmiss,*.rahit set filetype=glsl
]], false)

if os.getenv('SSH_CLIENT') then
	vim.g.clipboard = {
		name = 'lemonade',
		copy = {
			['+'] = 'lemonade copy',
			['*'] = 'lemonade copy',
		},
		paste = {
			['+'] = 'lemonade paste',
			['*'] = 'lemonade paste',
		},
		cache_enabled = 1,
	}
end
