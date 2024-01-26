-- Holds code that deals with manual instalations required
-- by the setup that aren't handled by the package manager
-- and that they probably are system wide installed
--

-- system-wide.lua

-- system-wide.lua

local state_file = vim.fn.stdpath('data') .. '/ripgrep_state'

-- Function to check if ripgrep is installed
local function is_ripgrep_installed()
  local output = vim.fn.system('cargo install ripgrep 2>&1')
  return not string.match(output, 'error: failed to compile') and not string.match(output, 'Already installed')
end

-- Check if the state file exists
if vim.fn.filereadable(state_file) == 1 then
  -- Read the state from the file
  vim.g.ripgrep_installed = vim.fn.readfile(state_file)[1] == 'true'
else
  -- Set initial state if the file doesn't exist
  vim.g.ripgrep_installed = false
end

-- Function to install ripgrep asynchronously
local function install_ripgrep_async()
  vim.fn.jobstart(
    'cargo install ripgrep',
    {
      on_exit = function(_, code)
        if code == 0 then
          print("ripgrep installed successfully!")
          -- Write the state to the file
          vim.fn.writefile({tostring(vim.g.ripgrep_installed)}, state_file)
        else
          print("Error installing ripgrep. Please check your setup.")
        end
      end,
    }
  )
end

-- Check if ripgrep is already installed
if not is_ripgrep_installed() then
  -- Install ripgrep asynchronously
  install_ripgrep_async()
else
  print("ripgrep is already installed.")
end

