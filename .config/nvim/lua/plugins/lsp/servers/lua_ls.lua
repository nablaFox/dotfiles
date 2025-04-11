local handlers = require("plugins.lsp.handlers")

return {
	root_dir = require("lspconfig/util").root_pattern("init.lua"),
	on_attach = handlers.format_on_save,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},

			diagnostics = {
				globals = {
					'vim',
				},
			},

			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},

			telemetry = {
				enable = false,
			},
		}
	}
}
