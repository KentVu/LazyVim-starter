return {
  {
    "neovim/nvim-lspconfig",
    -- init = function() end,
    -- see also `:h lspconfig-new`, https://www.lazyvim.org/configuration/examples
    ---@class PluginLspOpts
    opts = function(_, opts)
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        -- disable gr since conflict with substitute
        -- substitute mappings changed to "<leader>S"
        { "gr", false },--giving up gr to default nvim lsp.
        -- add a keymap
        { "<leader>sr", "<Cmd>Telescope lsp_references<CR>", desc = "Telescope lsp_references" } --"grr"
      })

      -- thanks https://github.com/SuduIDE/ideals/issues/59#issuecomment-1348761041
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local configs = require("lspconfig.configs")
      local util = require("lspconfig.util")

      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      }

      configs.ideals = {
        default_config = {
          --cmd = { "/Applications/IntelliJ IDEA CE.app/Contents/MacOS/idea", "lsp-server" },
          cmd = { "nc", "localhost", "8989" },
          filetypes = {
            --"ideals", --Start by LspStart manually.
            "kotlin",
            "gradle",
            "groovy",
            "java",
          },
          root_dir = function(pattern)
            local cwd = vim.loop.cwd()
            local root = util.root_pattern(".idea")(pattern)
            return util.path.is_descendant(cwd, root) and cwd or root
          end,
          autostart = false,
        },
        --on_attach = function(client, bufnr) end,
      }

      -- lspconfig.ideals.setup({
      --   capabilities = capabilities,
      -- })
      -- table.insert(opts, value)
      local wk = require("which-key")
      wk.register({
        mode = { "n", "v" },
        ["<leader>i"] = { name = "+ideals" },
      })
      opts.servers.ideals = {
        capabilities = capabilities,
        on_attach = function()
          vim.o.autowrite = false
          vim.keymap.set(
            "n",
            "<leader>ii",
            [[<cmd>exec "!'/Applications/Android Studio.app/Contents/MacOS/studio' --line ".line('.')." --column ".(col('.')-1)." %:p"<CR>]],
            { buffer = true, noremap = true, desc = "Open in A.Studio" }
          )
        end,
      }
      --opts.setup.ideals = function(server, opts)
      --  -- return true if you don't want this server to be setup with lspconfig
      --  return false
      --end
      --local mason_registry = require("mason-registry")
      --local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
      --  .. "/node_modules/@vue/language-server"
      --opts.servers.tsserver = {
      --  init_options = {
      --    plugins = {
      --      {
      --        name = "@vue/typescript-plugin",
      --        location = vue_language_server_path,
      --        languages = { "vue" },
      --      },
      --    },
      --  },
      --  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      --  settings = {},
      --}
      --opts.setup.tsserver = { }
    end,
  },
  {
    "jmederosalvarado/roslyn.nvim",
    config = function()
      require("roslyn").setup({
        --dotnet_cmd = "dotnet", -- this is the default
        --roslyn_version = "4.8.0-3.23475.7", -- this is the default
        --on_attach = <on_attach you would pass to nvim-lspconfig>, -- required
        --capabilities = <capabilities you would pass to nvim-lspconfig>, -- required
      })
    end,
  },
}
