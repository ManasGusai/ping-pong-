local Rectangle = {}

function Rectangle.new(x, y, width, height)
    local self = setmetatable({}, Rectangle)

    self.x = x
    self.y = y
    self.width = width
    self.height = height

    return self
end

return Rectangle