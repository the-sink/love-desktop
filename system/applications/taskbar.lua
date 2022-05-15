local application = {}

-- TODO: Ensure taskbar is always on top

application.config = {
    name = "taskbar",
    renderPriority = 10,
    taskbarHeight = 28
}

function application:load(libs)
    for name, lib in pairs(libs) do
        self[name] = lib
    end
end

function application:render()
    local style = self.imgui.GetStyle()
    style.WindowBorderSize = 0

    -- Taskbar window
    local windowPos = self.imgui.ImVec2_Float(0, love.graphics.getHeight())
    local windowSize = self.imgui.ImVec2_Float(love.graphics.getWidth(), application.config.taskbarHeight)
    local flags = self.imgui.love.WindowFlags("NoTitleBar", "NoResize", "NoScrollbar", "NoScrollWithMouse")
    self.imgui.SetNextWindowPos(windowPos, 0, self.imgui.ImVec2_Float(0, 1))
    self.imgui.SetNextWindowSize(windowSize)
    self.imgui.Begin("Taskbar", nil, flags)

    -- Start button
    self.imgui.SetCursorPos(self.imgui.ImVec2_Float(2, 4))
    self.imgui.Button("Start", self.imgui.ImVec2_Float(56, 24))

    -- Clock
    local timeStr = os.date("%I:%M %p", os.time())
    local clockXPos = love.graphics.getWidth() - self.imgui.CalcTextSize(timeStr).x - 14
    self.imgui.SetCursorPos(self.imgui.ImVec2_Float(clockXPos, 9))
    self.imgui.Text(timeStr)


    self.imgui.End()
end

return application