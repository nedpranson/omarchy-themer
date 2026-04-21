local M = {}
M.loaded = false

local function eval_plugin(plugin)
    local spec = {
        opts = plugin.opts,
        config = plugin.config,
    }

    if plugin[1] then
        local owner, repo = plugin[1]:match("^([^/]+)/([^/]+)$")

        spec.url = "https://github.com/" .. owner .. "/" .. repo .. ".git"
        spec.name = repo
    end

    if plugin.url then
        spec.url = plugin.url
    end

    if plugin.name then
        spec.name = plugin.name
    end

    if plugin.dependencies then
        local deps = {}

        if type(deps[1]) ~= "table" then
            plugin.dependencies = { plugin.dependencies }
        end

        for _, dep in ipairs(plugin.dependencies) do
            local s = eval_plugin(dep)
            table.insert(deps, s)
        end

        spec.dependencies = deps
    end

    return spec
end

local function load_spec(spec)
    if spec.dependencies then
        for _, dep in ipairs(spec.dependencies) do
            load_spec(dep)
        end
    end

    vim.pack.add({
        { src = spec.url, name = spec.name },
    })

    if type(spec.config) == "function" then
        spec.config(spec)
    elseif spec.opts then
        require(spec.name).setup(spec.opts)
    end
end

local function load_theme(path)
    local chunk, err = loadfile(path)
    if not chunk then
        error(err)
    end

    local result = chunk()
    local theme

    for _, plugin in ipairs(result) do
        local spec = eval_plugin(plugin)
        if spec.url == "https://github.com/LazyVim/LazyVim.git" then
            theme = spec.opts and spec.opts.colorscheme
        else
            load_spec(spec)
        end
    end

    if type(theme) == "function" then
        theme()
    else
        vim.cmd.colorscheme(theme or "habamax")
    end
end

function M.setup()
    if M.loaded then
        return
    end

    local omarchy = vim.fn.expand("~/.config/omarchy/current")
    local watcher = vim.uv.new_fs_event()

    local ok = pcall(function() 
        watcher:start(omarchy, {}, function(err, filename, events)
            if not err and filename == "theme.name" then
                vim.schedule(function ()
                    pcall(load_theme, omarchy .. "/theme/neovim.lua")
                end)
            end
        end)
    end)

    if ok then
        M.loaded = true
        pcall(load_theme, omarchy .. "/theme/neovim.lua")
    end
end

return M
