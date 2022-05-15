return function(dir)
    local apps = {}
    local files = love.filesystem.getDirectoryItems(dir)
    for _, file in ipairs(files) do
        local name = file:gsub(".lua","")
        if name ~= file then
            local app = require(dir .. "/" .. name)
            apps[name] = app
        else
            print("Skipping non-lua file: " .. file)
        end
    end
    return apps
end