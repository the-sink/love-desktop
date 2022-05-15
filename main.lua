local lib_path = love.filesystem.getSaveDirectory() .. "/libraries"
local extension = jit.os == "Windows" and "dll" or jit.os == "Linux" and "so" or jit.os == "OSX" and "dylib"
package.cpath = string.format("%s;%s/?.%s", package.cpath, lib_path, extension)

local imgui = require "cimgui"
local loadApps = require "system/appload"

local loadedApplications = {}

local libs = {imgui = imgui}


love.load = function()
    -- Set window properties
    love.window.setMode(1280, 720)
    love.graphics.setBackgroundColor(0.22, 0.42, 0.62, 1)
    
    -- Load system applications
    for name, app in pairs(loadApps("system/applications")) do
        app:load(libs)
        table.insert(loadedApplications, app)
    end

    -- Load user applications
    for name, app in pairs(loadApps("user/applications")) do
        app:load(libs)
        table.insert(loadedApplications, app)
    end

    -- Assign render priority
    table.sort(loadedApplications, function(a, b)
        return a.config.renderPriority < b.config.renderPriority
    end)


    -- Initialize imgui
    imgui.love.Init()
    imgui.StyleColorsLight()
end

love.draw = function()
    -- Demo window
    imgui.ShowDemoWindow()
    
    -- Render active applications
    for _, app in pairs(loadedApplications) do
        app:render()
    end

    -- Render frame
    imgui.Render()
    imgui.love.RenderDrawLists()
end

-- ImGui event bindings

love.update = function(dt)
    imgui.love.Update(dt)
    imgui.NewFrame()
end

love.mousemoved = function(x, y, ...)
    imgui.love.MouseMoved(x, y)
    imgui.love.GetWantCaptureMouse()
end

love.mousepressed = function(x, y, button, ...)
    imgui.love.MousePressed(button)
    imgui.love.GetWantCaptureMouse()
end

love.mousereleased = function(x, y, button, ...)
    imgui.love.MouseReleased(button)
    imgui.love.GetWantCaptureMouse()
end

love.wheelmoved = function(x, y)
    imgui.love.WheelMoved(x, y)
    imgui.love.GetWantCaptureMouse()
end

love.keypressed = function(key, ...)
    imgui.love.KeyPressed(key)
    imgui.love.GetWantCaptureKeyboard()
end

love.keyreleased = function(key, ...)
    imgui.love.KeyReleased(key)
    imgui.love.GetWantCaptureKeyboard()
end

love.textinput = function(t)
    -- only use imgui.love.TextInput when characters are expected
    if imgui.love.GetWantCaptureKeyboard() then
        imgui.love.TextInput(t)
    end
end

love.quit = function()
    return imgui.love.Shutdown()
end