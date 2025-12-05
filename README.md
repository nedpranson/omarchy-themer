# Omarchy Themer

Loads Omarchy themes into Neovim with support for hot-reloading on theme change.

As there is no simple way to configure Omarchy themes with other Neovim configurations,
this plugin provides a seamless alternative for integrating Omarchy's custom theme loading and swapping capabilities.

## Table of contents

- [Installing](#installing)
- [Linking Omarchy Themes](#linking-omarchy-themes)
- [Post Processing](#post-processing)

# Installing

> [!NOTE]
> Only [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager is supported.

This plugin can be installed either [alongside LazyVim](#installing-alongside-lazyvim) or through a [custom plugin](#installing-with-a-custom-plugin) that sets the colorscheme via its `opts` table.

## Installing alongside LazyVim

Best suited for those already using (or planning to use) [LazyVim](https://github.com/LazyVim/LazyVim);
it can also function independently without this dependency - look at [Installing with a custom plugin.](#installing-with-a-custom-plugin)

```lua
return {
  "nedpranson/omarchy-themer",
  dependencies = {
    "LazyVim/LazyVim",
  },
  opts = {
    -- path to linked theme module
    -- see 'Linking Omarchy Themes' section for more details
    theme_module = "plugins.theme",

    -- optional post-processing hook
    -- transparency example shown below in 'Post Processing'
    theme_changed = function()
      -- ApplyTransparency()
    end,
  },
}
```

## Installing with a custom plugin

Normally Omarchy relies on [LazyVim](https://github.com/LazyVim/LazyVim) to select Neovim themes, so LazyVim is required.
However, its presence can be emulated by using `dir` and `name` options in lazy’s [plugin specification](https://lazy.folke.io/spec#spec-source),
allowing you to point to a local directory and provide a custom plugin as a stand-in.

Installing [LightVim](https://github.com/nedpranson/LightVim) is recommended, but any minimal plugin stub works.

```lua
return {
  "nedpranson/omarchy-themer",
  dependencies = {
    { dir = "path/to/custom/plugin", name = "LazyVim" },
  },
  opts = {
    -- path to linked theme module
    -- see 'Linking Omarchy Themes' section for more details
    theme_module = "plugins.theme",

    -- optional post-processing hook
    -- transparency example shown below in 'Post Processing'
    theme_changed = function()
      -- ApplyTransparency()
    end,
  },
}
```

# Linking Omarchy Themes

After installation, Omarchy's theme spec at `~/.config/omarchy/current/theme/neovim.lua` needs to be linked into a module imported by lazy.nvim,
ensuring that it is recognized and loaded as part of the plugin specification.

The simplest way to achieve this is creating a symbolic link:

```sh
# link it to your lazy.nvim plugin module directory
ln -s ~/.config/omarchy/current/theme/neovim.lua \
      ~/.config/nvim/lua/plugins/theme.lua
```

After linkage, don't forget to update `theme_module` inside the plugin's `opts`.

# Post Processing

Post processing applies additional adjustments after the theme is loaded, and here it can be used to configure transparency across Neovim and its plugins.

Here is an example that makes common elements transparent — don’t forget to call it via `theme_changed` callback inside plugin's `opts`:

```lua
-- ~/.config/nvim/plugin/after/transparency.lua
function ApplyTransparency()
  -- transparent background
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
  vim.api.nvim_set_hl(0, "Terminal", { bg = "none" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
  vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
  vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "none" })

  -- transparent background for neotree
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
  vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { bg = "none" })
  vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "none" })
  vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "none" })

  -- transparent background for nvim-tree
  vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { bg = "none" })
  vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })

  -- transparent notify background
  vim.api.nvim_set_hl(0, "NotifyINFOBody", { bg = "none" })
  vim.api.nvim_set_hl(0, "NotifyERRORBody", { bg = "none" })
  vim.api.nvim_set_hl(0, "NotifyWARNBody", { bg = "none" })
  vim.api.nvim_set_hl(0, "NotifyTRACEBody", { bg = "none" })
  vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { bg = "none" })
  vim.api.nvim_set_hl(0, "NotifyINFOTitle", { bg = "none" })
  vim.api.nvim_set_hl(0, "NotifyERRORTitle", { bg = "none" })
  vim.api.nvim_set_hl(0, "NotifyWARNTitle", { bg = "none" })
  vim.api.nvim_set_hl(0, "NotifyTRACETitle", { bg = "none" })
  vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { bg = "none" })
  vim.api.nvim_set_hl(0, "NotifyINFOBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "NotifyERRORBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "NotifyWARNBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { bg = "none" })
end

ApplyTransparency()
```
