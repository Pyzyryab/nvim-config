-- Telescope's native fzf installation via lazy.nvim depending on
-- the underlying OS detected by the lua jit
--
if jit then
    local is_windows = jit.os == "Windows"
    
    if is_windows then
        return { 'nvim-telescope/telescope-fzf-native.nvim', commit = "2330a7eac13f9147d6fe9ce955cb99b6c1a0face", optional = true }
    else
        return { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    end
else
    print('Lua JIT not found. Trying default installation...')
    return { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
end

