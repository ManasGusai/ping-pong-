local paddle = {}

paddle.__index = paddle

function paddle.new(rectangle)
    local self = setmetatable({}, paddle)

    self.rect = rectangle

    return self
end

function paddle:draw()
    love.graphics.rectangle("fill", self.rect.x, self.rect.y, self.rect.width, self.rect.height)
end

return paddle