local handlers = require("plugins.lsp.handlers")

return {
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
		"--clang-tidy",
		"--clang-tidy-checks=*"
	},
	on_attach = handlers.format_on_save,
}
