-- Native fuzzy-finder to turbo-charge the telescope actions
--
return { build ='cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
