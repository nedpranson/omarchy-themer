# Omarchy Themer

Loads Omarchy themes into Neovim with support for hot-reloading on theme change.

As there is no simple way to configure Omarchy themes with other Neovim configurations,
this plugin provides a seamless alternative for integrating Omarchy's custom theme loading and swapping capabilities.

# Quickstart

## Requirements

- Neovim 0.12.0 or later

## Installation

Install using the native Neovim package manager:

```lua
vim.pack.add({
    "https://github.com/nedpranson/omarchy-themer",
})

require("omarchy-themer").setup()
```

# Post Processing

Post processing applies additional adjustments after the theme is loaded and can be used to configure transparency across Neovim and its plugins.

Here is an example that makes common elements transparent, blending Neovim between user's terminal.

```lua
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
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
    end,
})
```
