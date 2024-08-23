-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

--vim.api.nvim_create_autocmd("LspAttach", {
--  callback = function(args)
--    local bufnr = args.buf
--    local client = vim.lsp.get_client_by_id(args.data.client_id)
--    if client.name == "ideals" then
--    end
--  end,
--})
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.kt{s,}", "*.java", "*.gradle*" },
  callback = function(args)
    --vim.cmd('checktime')
    --[[vim.cmd(
    --  [[exec "!'/Applications/Android Studio.app/Contents/MacOS/studio' --line ".line('.')." --column ".(col('.')-1)." %:p"]]
    --)]]
  end,
})
