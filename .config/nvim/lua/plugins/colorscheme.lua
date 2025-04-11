return {
	'Mofiqul/vscode.nvim',
	config = function()
		require('vscode').setup({
			transparent = true,
			disable_nvimtree_bg = true,
		})

		vim.cmd([[
			colorscheme vscode
			hi LineNr ctermbg=241 ctermbg=none
			hi Search ctermbg=193 ctermfg=234 cterm=bold
			hi Pmenu ctermbg=235 ctermfg=255
			hi PmenuSel ctermbg=78 ctermfg=232 cterm=bold
			hi PmenuSbar ctermbg=235
			hi CursorColumn ctermbg=235 guibg=none
			hi Normal ctermbg=none ctermfg=15
			hi EndOfBuffer ctermbg=none
			hi CursorLine cterm=none ctermbg=none ctermfg=none guibg=none guifg=none
			hi CursorLineNr ctermbg=none ctermfg=7
			hi Folded ctermbg=none ctermfg=none cterm=none

			" telescope
			hi TelescopeMatching ctermfg=blue

			" gitsigns
			hi! link SignColumn LineNr
			hi GitSignsDelete ctermfg=red
			hi GitSignsChange ctermfg=5
			hi GitSignsAdd ctermfg=green

			" notify
			hi NotifyWARNBorder ctermfg=blue
			hi NotifyWARNTitle  ctermfg=blue cterm=bold
			hi NotifyWARNIcon ctermfg=blue cterm=bold

			hi NotifyINFOBorder ctermfg=151
			hi NotifyINFOTitle  ctermfg=151 cterm=bold
			hi NotifyINFOIcon ctermfg=151 cterm=bold

			hi NotifyDEBUGBorder ctermfg=5
			hi NotifyDEBUGTitle  ctermfg=5 cterm=bold
			hi NotifyDEBUGIcon ctermfg=5 cterm=bold

			hi NotifyERRORBorder ctermfg=1
			hi NotifyERRORTitle ctermfg=1 cterm=bold
			hi NotifyERRORIcon ctermfg=1 cterm=bold

			" tree
			hi Directory ctermfg=15
			hi NvimTreeGitNew ctermfg=10
			hi NvimTreeGitDirty ctermfg=223
			hi NvimTreeGitStaged ctermfg=151
			hi NvimTreeGitDeleted ctermfg=1
			hi NvimTreeGitIgnored ctermfg=153

			" indent
			hi IblIndent ctermfg=235
			hi IblScope ctermfg=236

			" lsp
			hi DiagnosticUnderlineWarn cterm=undercurl guisp=#F89880
			hi DiagnosticUnderlineError cterm=undercurl guisp=#e34444
			hi DiagnosticUnderlineHint cterm=undercurl guisp=#80abe0
		]])
	end
}
