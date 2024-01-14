vim.opt.writebackup = false
vim.opt.backup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = 'yes'

function _G.check_back_space()
	local col = vim.fn.col('.') - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
imap('<TAB>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
	'trigger completion with characters ahead and navigate completions', opts)

imap('<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], 'previous completion', opts)

imap('<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
	'make <CR> to accept selected completion', opts)

imap('<c-space>', 'coc#refresh()', 'trigger completion', { silent = true, expr = true })

nmap('[g', '<Plug>(coc-diagnostic-prev)', 'next diagnostic', { silent = true })
nmap(']g', '<Plug>(coc-diagnostic-next)', 'previous diagnostic', { silent = true })

nmap('gd', '<Plug>(coc-definition)', 'go to definition', { silent = true })
nmap('gy', '<Plug>(coc-type-definition)', 'go to type definition', { silent = true })
nmap('gi', '<Plug>(coc-implementation)', 'go to implementation', { silent = true })
nmap('gr', '<Plug>(coc-references)', 'references', { silent = true })

function _G.show_docs()
	local cw = vim.fn.expand('<cword>')
	if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
		vim.api.nvim_command('h ' .. cw)
	elseif vim.api.nvim_eval('coc#rpc#ready()') then
		vim.fn.CocActionAsync('doHover')
	else
		vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
	end
end

nmap('K', '<CMD>lua _G.show_docs()<CR>', 'show docs', { silent = true })

create_group('CocGroup')
aucmd('CursorHold', {
	group = 'CocGroup',
	command = "silent call CocActionAsync('highlight')",
	desc = 'Highlight symbol under cursor on CursorHold'
})

nmap('<leader>rn', '<Plug>(coc-rename)', 'rename symbol', { silent = true })

aucmd('User', {
	group = 'CocGroup',
	pattern = 'CocJumpPlaceholder',
	command = "call CocActionAsync('showSignatureHelp')",
	desc = 'Update signature help on jump placeholder'
})

opts = { silent = true, nowait = true }
xmap('<leader>a', '<Plug>(coc-codeaction-selected)', 'code actions', opts)
nmap('<leader>a', '<Plug>(coc-codeaction-selected)', 'code actions', opts)

nmap('<leader>ac', '<Plug>(coc-codeaction-cursor)', 'code actions at the cursor position', opts)
nmap('<leader>as', '<Plug>(coc-codeaction-source)', 'code actions for the current file', opts)
nmap('<leader>qf', '<Plug>(coc-fix-current)', 'quick fix', opts)

nmap('<leader>re', '<Plug>(coc-codeaction-refactor)', 'refactor', { silent = true })
xmap('<leader>r', '<Plug>(coc-codeaction-refactor-selected)', 'refactor selected', { silent = true })
nmap('<leader>r', '<Plug>(coc-codeaction-refactor-selected)', 'refactor selected', { silent = true })

nmap('<leader>cl', '<Plug>(coc-codelens-action)', 'code lens', opts)

xmap('if', '<Plug>(coc-funcobj-i)', 'select inside function', opts)
omap('if', '<Plug>(coc-funcobj-i)', 'select inside function', opts)
xmap('af', '<Plug>(coc-funcobj-a)', 'select around function', opts)
omap('af', '<Plug>(coc-funcobj-a)', 'select around function', opts)
xmap('ic', '<Plug>(coc-classobj-i)', 'select inside class', opts)
omap('ic', '<Plug>(coc-classobj-i)', 'select inside class', opts)
xmap('ac', '<Plug>(coc-classobj-a)', 'select around class', opts)
omap('ac', '<Plug>(coc-classobj-a)', 'select around class', opts)

opts = { silent = true, nowait = true, expr = true }
nmap('<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', 'Scroll float window down/Normal scroll', opts)
nmap('<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', 'Scroll float window up/Normal scroll', opts)
imap('<C-f>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', 'Scroll float down/Cursor right',
	opts)
imap('<C-b>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', 'Scroll float up/Cursor left', opts)
vmap('<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', 'Scroll float window down/Normal scroll', opts)
vmap('<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', 'Scroll float window up/Normal scroll', opts)

nmap('<C-a>', '<Plug>(coc-range-select)', 'select range', { silent = true })
xmap('<C-a>', '<Plug>(coc-range-select)', 'select range', { silent = true })

command('Format', "call CocAction('format')", {})
command('Fold', "call CocAction('fold', <f-args>)", { nargs = '?' })
command('OR', "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

opts = { silent = true, nowait = true }
nmap('<space>a', ':<C-u>CocList diagnostics<cr>', 'Show diagnostic list', opts)
nmap('<space>e', ':<C-u>CocList extensions<cr>', 'Show extension list', opts)
nmap('<space>c', ':<C-u>CocList commands<cr>', 'Show command list', opts)
nmap('<space>o', ':<C-u>CocList outline<cr>', 'Show outline list', opts)
nmap('<space>s', ':<C-u>CocList -I symbols<cr>', 'Show symbol list', opts)
nmap('<space>j', ':<C-u>CocNext<cr>', 'Jump to next item', opts)
nmap('<space>k', ':<C-u>CocPrev<cr>', 'Jump to previous item', opts)

return {
	{
		'neoclide/coc.nvim',
		branch = 'release',
		lazy = false
	}
}
