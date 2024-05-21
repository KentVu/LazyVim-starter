return {
  { "wakatime/vim-wakatime" },
  {
    "gbprod/substitute.nvim",
    opts = function()
      local substitute = require("substitute")
      local exchange = require("substitute.exchange")
      -- vim.keymap.set("n", "<leader>ex", require("substitute").operator, { noremap = true, desc = "Substitute" }),
      vim.keymap.set("n", "gr", substitute.operator, { noremap = true, desc = "ReplaceWithReg@Substitute" })
      vim.keymap.set("x", "gr", substitute.visual, { noremap = true, desc = "ReplaceWithReg@Substitute" })
      vim.keymap.set("n", "cx", exchange.operator, { noremap = true, desc = "Substitute.Exchange" })
      vim.keymap.set("n", "cxx", exchange.line, { noremap = true, desc = "Substitute.Exchange line" })
      vim.keymap.set("x", "X", exchange.operator, { noremap = true, desc = "Substitute.Exchange" })
      return {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<C-Tab>",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
    },
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "ys",
        delete = "ds",
        replace = "cs",
      },
    },
  },
  {
    "folke/flash.nvim",
    -- stylua: ignore
    keys = {
      {
        "s", mode = { "n", "x", "o" },
        function()
          require("flash").jump({
            search = {
              mode = function(str)
                return "\\<" .. str
              end,
            },
          })
        end, desc = "Flash beginning of words only" },
      { "S", mode = { "x", "o" }, false },
    },
  },
  -- nvim already has g text object?!
  -- { "kana/vim-textobj-entire" },
  -- Performance
  {
    "LunarVim/bigfile.nvim",
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "chrisgrieser/nvim-spider",
    keys = {
      {
        mode = { "i", "n", "o", "x" },
        -- "<S-Right>",
        "<M-f>",
        "<cmd>lua require('spider').motion('w')<CR>",
        desc = "[Spider]next subword start (w)",
      },
      {
        mode = { "i", "n", "o", "x" },
        "<M-b>",
        "<cmd>lua require('spider').motion('b')<CR>",
        desc = "[Spider]previous subword start (b)",
      },
    },
  },
}
