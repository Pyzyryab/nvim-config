-- Native fuzzy-finder to turbo-charge the telescope actions
--
local sys = require('the-rustifyer.core.globals').sys

if sys.is_windows then
    return { commit = "2330a7eac13f9147d6fe9ce955cb99b6c1a0face", optional = true }
else
    return { build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
end

return config
