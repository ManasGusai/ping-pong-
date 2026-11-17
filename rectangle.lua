local rectangle = {}

function rectangle.new(x, y, width, height)
    local self = setmetatable({}, rectangle)

    self.x = x
    self.y = y
    self.width = width
    self.height = height

    return self
end

return rectangle