-- Plugins that takes care of installing or handling other 3rd party tools
--
local managers = {}

managers.mason = {'williamboman/mason.nvim', no_extra_config = true}
managers.mason_tool_installer = {'WhoIsSethDaniel/mason-tool-installer.nvim'}

return managers
