return {
	'tomasiser/vim-code-dark',
	priority = 1000,
	config = function()
		vim.cmd([[
			colorscheme codedark
			hi LineNr ctermbg=241 ctermbg=none
			hi Search ctermbg=193 ctermfg=234 cterm=bold
			hi Pmenu ctermbg=235 ctermfg=255
			hi PmenuSel ctermbg=78 ctermfg=232 cterm=bold
			hi PmenuSbar ctermbg=235
			hi Visual ctermbg=235 guibg=none
			hi CursorColumn ctermbg=235 guibg=none
			hi Normal ctermbg=none ctermfg=15
			hi EndOfBuffer ctermbg=none
			hi CursorLine cterm=none ctermbg=none ctermfg=none guibg=none guifg=none
			hi CursorLineNr ctermbg=none ctermfg=7
			hi Folded ctermbg=none ctermfg=none cterm=none

			" syntax highlighting
			hi @punctuation.special ctermfg=75
			hi @text ctermfg=15
			hi @text.emphasis ctermfg=15
			hi @punctuation.bracket.markdown_inline ctermfg=242
			hi! link @keyword.return Statement
			hi @tag.delimiter ctermfg=246
			hi! link @tag.attribute.vue @property
			hi! link @tag.attribute.html @property
			hi @text.html cterm=none
			hi! link @type.qualifier.cpp @keyword.cpp			

			" telescope
			hi TelescopeMatching ctermfg=blue

			" alpha
			hi AlphaShortcut ctermfg=121 cterm=bold
			hi AlphaButtonText ctermfg=151
			hi AlphaButtonText ctermfg=151
			hi AlphaButtonText ctermfg=151
			hi EndOfBuffer ctermfg=234

			" gitsigns
			hi! link SignColumn LineNr
			hi GitSignsDelete ctermfg=red
			hi GitSignsChange ctermfg=5
			hi GitSignsAdd ctermfg=green

			" coc
			hi CocWarningHighlight cterm=undercurl guisp=#F89880
			hi CocErrorHighlight cterm=undercurl guisp=#e34444
			hi CocUnusedHighlight cterm=undercurl gui=undercurl guisp=#80abe0
			hi CocMenuSel cterm=bold ctermbg=none
			hi CocFloatSbar ctermbg=233 ctermfg=233
			hi CocFloating ctermbg=233
			hi CocFloatThumb ctermbg=233
			hi CocHighlightText ctermbg=235

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
		]])
	end
}
