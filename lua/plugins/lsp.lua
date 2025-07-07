return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    init = function()
    end,
    -- see also `:h lspconfig-new`, https://www.lazyvim.org/configuration/examples
    ---@class PluginLspOpts
    opts = function(_, opts)
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      -- lspconfig.ideals.setup({
      --   capabilities = capabilities,
      -- })
      -- table.insert(opts, value)
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      }
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        -- disable gr since conflict with substitute
        -- substitute mappings changed to "<leader>S"
        { "gr", false },--giving up gr to default nvim lsp.
        -- add a keymap
        { "<leader>sr", "<Cmd>FzfLua lsp_references<CR>", desc = "Telescope lsp_references" } --"grr"
      })

      -- thanks https://github.com/SuduIDE/ideals/issues/59#issuecomment-1348761041
      local lspconfig = require("lspconfig") --vim.lsp
      local configs = require("lspconfig.configs") --vim.lsp.configs
      local util = require("lspconfig.util") --vim.lsp.util

      --https://neovim.io/doc/user/lsp.html
      --vim.lsp.config['ideals'] = {
      vim.lsp.config('ideals', {
      --configs.ideals = {
        default_config = {
        },
          --cmd = { "/Applications/IntelliJ IDEA CE.app/Contents/MacOS/idea", "lsp-server" },
        -- TODO: check tcp-way https://github.com/Kotlin/kotlin-lsp/blob/main/scripts/neovim.md#tcp-way
          cmd = { "nc", "localhost", "8989" },
          filetypes = {
            --"ideals", --Start by LspStart manually.
            "kotlin",
            "gradle",
            "groovy",
            "java",
          },
          --[[root_dir = function(bufnr, on_dir)
            local cwd = vim.fn.getcwd() --vim.loop.cwd()
            local root = util.root_pattern(".idea")(pattern)
          on_dir(util.root_pattern('.idea', 'build.gradle.kts')(fname))
            --return util.path.is_descendant(cwd, root) and cwd or root
          end,]]
        root_markers= { "build.gradle*", ".idea"},
          autostart = false,
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          vim.o.autowrite = false
          -- Auto-formatting can be disabled with:
          vim.b.autoformat = false -- buffer-local
          local wk = require("which-key")
          wk.add({
            { "<leader>i", group = "ideals", mode = { "n", "v" } },
          })
          vim.keymap.set(
            "n",
            "<leader>ii",
            [[<cmd>exec "!'/Applications/Android Studio.app/Contents/MacOS/studio' --line ".line('.')." --column ".(col('.')-1)." %:p"<CR>]],
            { buffer = true, noremap = true, desc = "Open in A.Studio" }
          )
          vim.keymap.set(
            "n",
            "<leader>is",
            [[<cmd>!osascript -e 'tell application "System Events" to keystroke "s" using {command down}'; sleep 0.3<CR>]],
            { buffer = true, noremap = true, desc = "Save in A.Studio" }
          )
        end,
      })
      --vim.lsp.enable('ideals') --no autostart!!

      --[[opts.servers.ideals = {
        on_attach = function()
        end,
      }]]
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
