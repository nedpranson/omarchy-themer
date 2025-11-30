local M = {}
M.loaded = false

M.opts = {
  theme_changed = function ()
  end,
}

local function lazy_reload()
  local theme = require("lazyvim").opts.colorscheme
  local plugins = vim.tbl_keys(require("lazy.core.config").plugins)

  -- Clear all highlight groups before applying new theme
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  -- Reset background to default so colorscheme can set it properly (light themes will set to light)
  vim.o.background = "dark"

  -- Install missing plugins (can happen when loading new colorscheme)
  require("lazy.core.loader").install_missing()

  -- Load every plugin including new colorscheme and reload LazyVim, so new theme would apply
  require("lazy.core.loader").load(plugins, { cmd = "Lazy load" }, { force = false })
  require("lazy.core.loader").reload("LazyVim")

  if theme ~= require("lazyvim").opts.colorscheme then
    pcall(M.opts.theme_changed)
    vim.cmd("redraw!")
  end
end

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})

  if M.loaded then
    return
  end
  M.loaded = true

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyReload",
    callback = lazy_reload,
  })
end

return M
