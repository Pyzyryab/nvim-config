-- This file contains ASCII generated logos to mainly be used with the `Alpha`
-- plugin at the start up of `Neovim`

local ascii_files_path = '/ascii_art/'

local function read_logo(file_path)
  local file = io.open(file_path, "r")
  if not file then
    return nil
  end

  local logo_content = file:read("*all")
  file:close()

  return logo_content
end

local function get_logos()
  local logos_dir = vim.fn.stdpath("config") .. ascii_files_path 
  local logos = {}

  local files = vim.fn.readdir(logos_dir)
  for _, file in ipairs(files) do
    local file_path = logos_dir .. file
    local logo_content = read_logo(file_path)
    if logo_content then
      table.insert(logos, logo_content)
    end
  end

  return logos
end

local function random_logo()
  local logos = get_logos()
  if #logos == 0 then
    return nil
  end

  -- Use os.time() to seed the random number generator
  math.randomseed(os.time())
  local selected_index = math.random(#logos)
  return logos[selected_index]
end

return random_logo

