local Rectangle = require("Rectangle")

local Button = {}

Button.__index = Button

function Button.new(rect, text)
    local self = setmetatable({}, Button)

    self.rect = Rectangle.new(rect.x, rect.y, rect.width, rect.height)
    self.text = text

    return self
end

function Button:draw()
    local font = love.graphics.getFont()
    local textHeight = font:getHeight()

    love.graphics.rectangle("fill",
        self.rect.x, self.rect.y,
        self.rect.width, self.rect.height
    )

    love.graphics.setColor(1, 0, 0, 1)

    love.graphics.printf(
        self.text,
        self.rect.x,
        self.rect.y + (self.rect.height - textHeight) / 2,
        self.rect.width,
        "center"
    )
end

function Button:getRect()
    return self.rect
end

return Button