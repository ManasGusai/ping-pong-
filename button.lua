local Button = {}

Button.__index = Button

function Button.new(x, y, width, height, text)
    local self = setmetatable({}, Button)

    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.text = text

    return self
end

function Button:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.printf( self.text, self.x, self.y, self.width, "center", 0, 1, 1, 0, 0, 0, 0 )
end

function Button:update()
    local x, y = love.mouse.getPosition()
    if self:pointRectangleCollision(x, y) and love.mouse.isPressed(1) then
        return true
    end

    return false
end

function Button:pointRectangleCollision(px, py) 
    return (
        px >= self.x and 
        px <= self.x + self.width and 
        py >= self.y and 
        py <= self.y + self.height
    );
end

return Button