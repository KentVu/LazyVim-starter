return {
  { "tpope/vim-fugitive" },
  {
    "zk-org/zk-nvim",
    config = function()
      require("zk").setup({
        -- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
        -- or select" (`vim.ui.select`).
        picker = "fzf_lua",
        lsp = {
          -- `config` is passed to `vim.lsp.start(config)`
          config = {
            name = "zk",
            cmd = { "zk", "lsp" },
            filetypes = { "markdown" },
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start()`
          },

          -- automatically attach buffers in a zk notebook that match the given filetypes
          auto_attach = {
            enabled = true,
          },
        },
      })
    end,
  },
  {
    "glacambre/firenvim",
    enabled = false,
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
  },
}
