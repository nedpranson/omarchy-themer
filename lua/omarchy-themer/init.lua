local M = {}
M.loaded = false

local defaults = {
  theme_module = nil,

  theme_changed = function ()
  end
}

local options

local theme_module_path
local theme_module_file

local function lazy_reload()
  local files = require("lazy.manage.reloader").files
  if not files[theme_module_path] then
    return
  end

  -- Check if correct module changed
  if require("lazy.manage.reloader").eq(theme_module_file, files[theme_module_path]) then
    return
  end
  theme_module_file = vim.deepcopy(files[theme_module_path])

  -- Load theme module temporarily
  local ok, theme_spec = pcall(require, options.theme_module)
  if not ok then
    return
  end
  package.loaded[options.theme_module] = nil

  for _, spec in ipairs(theme_spec) do
    if spec[1] == "LazyVim/LazyVim" and spec.opts and spec.opts.colorscheme then
      -- Clear all highlight groups before applying new theme
      vim.cmd("highlight clear")
      if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
      end

      -- Install missing plugins (can happen when loading new colorscheme)
      require("lazy.core.loader").install_missing()

      local plugins = vim.tbl_keys(require("lazy.core.config").plugins)

      -- Load every plugin including new colorscheme 
      require("lazy.core.loader").load(plugins, { cmd = "Lazy load" }, { force = false })

      -- Find the theme plugin and reload it
      local theme_plugin_name = nil
      for _, spec in ipairs(theme_spec) do
        if spec[1] and spec[1] ~= "LazyVim/LazyVim" then
          theme_plugin_name = spec.name or require("lazy.core.plugin").Spec.get_name(spec[1])
          break
        end
      end

      -- Reset some opts to default so colorscheme can set it properly
      vim.o.background = "dark"
      vim.o.termguicolors = true

      -- Reload theme plugin and LazyVim, so new theme would apply
      if theme_plugin_name then
        require("lazy.core.loader").reload(theme_plugin_name)
      end

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

  theme_module_path = require("lazy.util").find_root(options.theme_module) .. ".lua"
  theme_module_file = vim.uv.fs_stat(theme_module_path)

  if not theme_module_file then
    require("lazy.util").error("Invalid 'theme_module' is specified", { stacktrace = true })
    options.theme_module = nil
    return
  end

  if M.loaded then
    return
  end
  M.loaded = true

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyReload",
    callback = function ()
      if options.theme_module then
        lazy_reload()
      end
    end,
  })
end

return M
