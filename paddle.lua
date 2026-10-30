local Paddle = {}

Paddle.__index = Paddle

function Paddle.new(x, y, width, height)
    local self = setmetatable({}, Paddle)

    self.x = x
    self.y = y
    self.width = width
    self.height = height

    return self
end

function Paddle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Paddle