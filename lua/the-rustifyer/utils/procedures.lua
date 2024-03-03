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
-- Helper function for creating keymaps in normal mode
function M.nnoremap(rhs, lhs, bufopts, desc)
    bufopts.desc = desc
    vim.keymap.set("n", rhs, lhs, bufopts)
end

---
-- Helper function for creating keymaps in visual mode
function M.vnoremap(rhs, lhs, bufopts, desc)
    bufopts.desc = desc
    vim.keymap.set("n", rhs, lhs, bufopts)
end

---
-- Helper to encapsulate the logic of delete a buffer with `minibufremove`
function M.minibufremove()
    print('Attempting to delete current buffer')
    local bd = require("mini.bufremove").delete
    if vim.bo.modified then
        local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
        if choice == 1 then             -- Yes
            vim.cmd.write()
            bd(0)
        elseif choice == 2 then             -- No
            bd(0, true)
        end
    else
        print('Deleting saved buffer')
        bd(0)
    end
    print('Buffer successfully delete')
end

---
-- Helper to create a remap that toggles between relative and absolute numbers
function M.toggle_line_numbers()
    local enabled_rel_line_nums = vim.wo.relativenumber == true
    if enabled_rel_line_nums then
        vim.cmd('set number norelativenumber')
    else
        vim.cmd('set number relativenumber')
    end
end


---
-- Helper to create a remap that toggles the visualization of the folding column
function M.toggle_folding_column()
    local foldcolumn_visible = vim.o.foldcolumn == '1'

    if foldcolumn_visible then
        vim.cmd('set foldcolumn=0')
    else
        vim.cmd('set foldcolumn=1')
    end
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

    local success, plug_config_mod = pcall(
        function()
            return require(plug_config_path)
        end
    )

    if not success or plug_config_mod == nil then return nil end -- early guard for plugins that do not  provide
    -- extra config at all, or that they must be configured with a setup callback after require them

    -- Adding any extra keys loaded for the plugin definition
    for key, value in pairs(plug_config_mod) do
        lazy_plug[key] = value
    end

    return lazy_plug
end

return M

