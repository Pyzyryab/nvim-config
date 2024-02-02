-- Contains general purpose procedures
--

local M = {}

---
-- Variadic prodecure to generate a lua module name, typically used
-- on the `require` calls
-- @param ... variadic string args
-- @return a Lua module path
function M.generate_mod_require_path(...)
    local total_args = select("#", ...)
    local args = { ... }
    return table.concat(args, '.')
end

---
-- Load extra configuration for a Lazy plugin.
-- This function loads additional configuration for a Lazy plugin from a separate
-- module and merges it into the provided `lazy_plug` table.
--
-- @param plug_category The name of the category where the plugin
--        configuration lives
-- @param plug_name The name of the Lazy plugin.
-- @param lazy_plug The existing Lazy plugin configuration table.
-- @return The modified Lazy plugin configuration table with additional settings.
--
function M.load_plugin_extra_config(plug_category, plug_name, lazy_plug)
    local plug_config_path = M.generate_mod_require_path(
        'the-rustifyer.plugins.config', plug_category, plug_name
    )
    local success, plug_config_mod = pcall(function() return require(plug_config_path) end)
    if not success then return nil end -- early guard for plugins that doesn't provide extra (or no) config at all

    -- Adding any extra keys loaded for the plugin definition
    for key, value in pairs(plug_config_mod) do
        lazy_plug[key] = value
    end

    return lazy_plug
end

return M

