local application = {}

-- TODO: Add library for accessing user resources (i.e. images)

application.config = {
    name = "saul",
    renderPriority = 1
}

function application:load(libs)
    for name, lib in pairs(libs) do
        self[name] = lib
    end

    self.image = love.graphics.newImage("saul.png")
    self.imageSize = self.imgui.ImVec2_Float(self.image:getDimensions())
end

function application:render()
    self.imgui.Begin("")
    self.imgui.Image(self.image, self.imageSize)
    self.imgui.End()
end

return application