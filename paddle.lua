local Paddle = {}

Paddle.__index = Paddle

function Paddle.new(rectangle)
    local self = setmetatable({}, Paddle)

    self.rect = rectangle

    return self
end

function Paddle:draw()
    love.graphics.rectangle("fill", self.rect.x, self.rect.y, self.rect.width, self.rect.height)
end

return Paddle