local M = {}
M.loaded = false

local defaults = {
  theme_module = nil,

  theme_changed = function ()
  end
}

local options

local function lazy_reload()
  -- Load theme module temporarily
  local ok, theme_spec = pcall(require, options.theme_module)
  if not ok then
    require("lazy.util").error("Invalid 'theme_module' is specified", { once = true, stacktrace = true })
    return
  end
  package.loaded[options.theme_module] = nil

  for _, spec in ipairs(theme_spec) do
    if spec[1] == "LazyVim/LazyVim" and spec.opts and spec.opts.colorscheme then
      if spec.opts.colorscheme == require("lazyvim.config").colorscheme then
        break
      end

      local plugins = vim.tbl_keys(require("lazy.core.config").plugins)

      -- Clear all highlight groups before applying new theme
      vim.cmd("highlight clear")
      if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
      end

      -- Reset some opts to default so colorscheme can set it properly
      vim.o.background = "dark"
      vim.o.termguicolors = true

      -- Install missing plugins (can happen when loading new colorscheme)
      require("lazy.core.loader").install_missing()

      -- Load every plugin including new colorscheme and reload LazyVim, so new theme would apply
      require("lazy.core.loader").load(plugins, { cmd = "Lazy load" }, { force = false })
      require("lazy.core.loader").reload("LazyVim")

      pcall(options.theme_changed)
      vim.cmd("redraw!")

      break
    end
  end
end

function M.setup(opts)
  options = vim.tbl_deep_extend("force", defaults, opts or {})
  if options.theme_module == nil then
    require("lazy.util").error("Option 'theme_module' is not specified", { stacktrace = true })
    return
  end

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
