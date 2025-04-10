return {
	"neovim/nvim-lspconfig",

	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
		"saadparwaiz1/cmp_luasnip"
	},

	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup()

		local cmp = require("cmp")

		cmp.setup {
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				},
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "buffer" },
			},
		}

		-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		-- 	focusable = false,
		-- })

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		capabilities.textDocument.completion.completionItem.snippetSupport = true

		local on_attach = function(client, bufnr)
			if client.name == "volar" or client.name == "ts_ls" or client.name == 'svelte' then
				return
			end

			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ async = false })
					end,
				})
			end
		end

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach
				})
			end,
		})

		local lspconfig = require("lspconfig")

		lspconfig.clangd.setup {
			cmd = {
				"clangd",
				"--offset-encoding=utf-16",
				"--clang-tidy",
				"--clang-tidy-checks=*"
			},
			on_attach = on_attach,
		}

		lspconfig.eslint.setup {
			on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "EslintFixAll"
				})
			end,
		}

		lspconfig.volar.setup {
			filetypes = { 'vue' },
			init_options = {
				vue = {
					hybridMode = false,
				},
			},
		}

		lspconfig.emmet_language_server.setup({
			capabilities = capabilities,
			filetypes = { "vue", "html", "svelte" },
		})

		lspconfig.ts_ls.setup {
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = "/home/icecube/.bun/install/global/node_modules/@vue/typescript-plugin",
						languages = { "javascript", "typescript", "vue" },
					},
				},
			},
			filetypes = {
				"javascript",
				"typescript",
				"vue",
			},
		}

		lspconfig.hls.setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				haskell = {
					formattingProvider = "ormolu",

				},
			},

		}

		-- Diagnostics style
		vim.o.updatetime = 250

		vim.diagnostic.config({
			virtual_text = false,
			signs = false,
			underline = true,
			update_in_insert = false,
			float = {
				source = "always",
				border = "rounded"
			},
		})

		vim.cmd [[
            hi DiagnosticUnderlineWarn cterm=undercurl guisp=#F89880
            hi DiagnosticUnderlineError cterm=undercurl guisp=#e34444
            hi DiagnosticUnderlineHint cterm=undercurl guisp=#80abe0
        ]]

		function OpenDiagnosticIfNoFloat()
			for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
				if vim.api.nvim_win_get_config(winid).zindex then
					return
				end
			end

			vim.diagnostic.open_float(0, {
				scope = "cursor",
				focusable = false,
				close_events = {
					"CursorMoved",
					"CursorMovedI",
					"BufHidden",
					"InsertCharPre",
					"WinLeave",
				},
			})
		end

		vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
		vim.api.nvim_create_autocmd({ "CursorHold" }, {
			pattern = "*",
			command = "lua OpenDiagnosticIfNoFloat()",
			group = "lsp_diagnostics_hold",
		})

		-- keybindings
		nmap('[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', 'go to previous diagnostic')
		nmap(']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', 'go to next diagnostic')

		nmap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', 'rename symbol')

		nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>', 'go to definition')
		nmap('gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'go to type definition')
		nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', 'go to implementation')
		nmap('gr', '<cmd>lua vim.lsp.buf.references()<CR>', 'list references')

		local opts = { silent = true, nowait = true }
		xmap('<leader>a', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', 'code actions', opts)
		nmap('<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', 'code actions', opts)
		nmap('<leader>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', 'code actions at cursor', opts)
		nmap('<leader>as', '<cmd>lua vim.lsp.buf.code_action()<CR>', 'source code actions', opts)
		nmap('<leader>qf', '<cmd>lua vim.lsp.buf.code_action({ only = "quickfix" })<CR>', 'quick fix', opts)

		nmap('<leader>re', '<cmd>lua vim.lsp.buf.code_action({ only = "refactor" })<CR>', 'refactor', { silent = true })
		xmap('<leader>r', '<cmd>lua vim.lsp.buf.range_code_action({ only = "refactor" })<CR>', 'refactor selected',
			{ silent = true })
		nmap('<leader>r', '<cmd>lua vim.lsp.buf.range_code_action({ only = "refactor" })<CR>', 'refactor selected',
			{ silent = true })

		nmap('<leader>cl', '<cmd>lua vim.lsp.codelens.run()<CR>', 'code lens action', opts)

		nmap('<space>a', '<cmd>Telescope diagnostics<CR>', 'Show diagnostic list', opts)
		nmap('<space>e', '<cmd>Telescope lsp_extensions<CR>', 'Show extension list', opts)
		nmap('<space>c', '<cmd>Telescope commands<CR>', 'Show command list', opts)
		nmap('<space>o', '<cmd>Telescope lsp_document_symbols<CR>', 'Show outline', opts)
		nmap('<space>s', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', 'Show symbol list', opts)
	end,
}
