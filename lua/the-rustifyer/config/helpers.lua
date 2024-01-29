-- Convenient prodecures
--
-- Initially set to true for relative line numbers
local isRelativeNumbers = true

-- Function to toggle between relative and absolute line numbers
function ToggleLineNumbers()
    if isRelativeNumbers then
        vim.cmd('set number relativenumber!')
    else
        vim.cmd('set number norelativenumber')
    end
    isRelativeNumbers = not isRelativeNumbers
end

