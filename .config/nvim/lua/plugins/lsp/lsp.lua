local keys = {
  { "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>",                                 desc = "rename symbol", },
  { "gd",         "<cmd>lua vim.lsp.buf.definition()<CR>",                             desc = "go to definition", },
  { "gy",         "<cmd>lua vim.lsp.buf.type_definition()<CR>",                        desc = "go to type definition", },
  { "gi",         "<cmd>lua vim.lsp.buf.implementation()<CR>",                         desc = "go to implementation", },
  { "gr",         "<cmd>lua vim.lsp.buf.references()<CR>",                             desc = "list references", },
  { "<leader>re", "<cmd>lua vim.lsp.buf.code_action({ only = 'refactor' })<CR>",       desc = "refactor", },
  { "<leader>r",  "<cmd>lua vim.lsp.buf.range_code_action({ only = 'refactor' })<CR>", desc = "refactor selected", },
  { "<leader>a",  "<cmd>lua vim.lsp.buf.code_action()<CR>",                            desc = "code actions",           nowait = true },
  { "<leader>ac", "<cmd>lua vim.lsp.buf.code_action()<CR>",                            desc = "code actions at cursor", nowait = true },
  { "<leader>as", "<cmd>lua vim.lsp.buf.code_action()<CR>",                            desc = "source code actions",    nowait = true },
  { "<leader>qf", "<cmd>lua vim.lsp.buf.code_action({ only = 'quickfix' })<CR>",       desc = "quick fix",              nowait = true },
  { "<leader>cl", "<cmd>lua vim.lsp.codelens.run()<CR>",                               desc = "code lens action",       nowait = true },
}

local ensure_installed = {
  'lua_ls',
  'clangd',
  'eslint',
  'html',
  'jsonls',
  'cssls',
  'ts_ls',
  'hls',
}

return {
  {
    'williamboman/mason.nvim',
    build = ":MasonUpdate",
    config = true,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'mason.nvim' },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = ensure_installed,
        automatic_installation = true,
      })
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')

      cmp.setup {
        mapping = {
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
        },
      }
    end,
  },

  {
    'neovim/nvim-lspconfig',

    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
    },

    config = function()
      local handlers = require("plugins.lsp.handlers")

      require('mason-lspconfig').setup_handlers {
        function(server_name)
          local setup_path = 'plugins.lsp.servers.' .. server_name

          local success, setup = pcall(require, setup_path)

          if success then
            require('lspconfig')[server_name].setup(setup)
          else
            require('lspconfig')[server_name].setup {
              on_attach = handlers.format_on_save,
            }
          end
        end
      }

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
    end,

    keys = keys,
  },
}
