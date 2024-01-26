-- Holds code that deals with manual instalations required
-- by the setup that aren't handled by the package manager
-- and that they probably are system wide installed
--
local function install_ripgrep()
    local success = vim.fn.system("cargo install ripgrep") == 0
    if success then
        print("ripgrep installed successfully!")
    else
        print("Error installing ripgrep. Please check your setup.")
    end
end

install_ripgrep()
