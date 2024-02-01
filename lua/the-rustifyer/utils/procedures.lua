-- Contains general purpose procedures
--

local M = {}

-- param
function M.load_plugin_extra_config(plug_name, lazy_plug)
    local plug_config_path = me .. '.plugins.config.ui.' .. plug_name
    local plug_config_mod = require(plug_config_path)

    -- Adding any extra keys loaded for the plugin definition
    for key, value in pairs(plug_config_mod) do
        lazy_plug[key] = value -- todo add the mod name
    end

    return lazy_plug
end

return M
