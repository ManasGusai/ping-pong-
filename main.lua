local gameover = false

local ball = {
    x = 100,
    y = 100,
    radius = 20,
    vx = 400,
    vy = 400,
    dx = 1,
    dy = 1
}

local paddle    = require("paddle")
local button    = require("Button")
local Rectangle = require("Rectangle")

local p1
local p2
local restart = button.new(Rectangle.new(300, 400, 200, 70), "restart")

local function ball_reset()
    ball.x = 400
    ball.y = 300
    ball.dx = math.random(0, 1) * 2 - 1
    ball.dy = math.random(0, 1) * 2 - 1
end

local function ball_bounds_check()
    -- Ball
    if ball.x > 800 - ball.radius or ball.x < 0 + ball.radius then
        ball.dx = -ball.dx
        gameover = true
    elseif ball.y > 600 - ball.radius or ball.y < 0 + ball.radius then
        ball.dy = -ball.dy
    end
end

local function pointRectangleCollision(px, py, rect) 
    return (
        px >= rect.x and 
        px <= rect.x + rect.width and 
        py >= rect.y and 
        py <= rect.y + rect.height
    );
end


local function checkCircleRectCollision(circle, rect) 
    local closestX = math.max(rect.x, math.min(circle.x, rect.x + rect.width))
    local closestY = math.max(rect.y, math.min(circle.y, rect.y + rect.height))

    local distanceX = circle.x - closestX
    local distanceY = circle.y - closestY
    local distanceSquared = (distanceX * distanceX) + (distanceY * distanceY)

  return distanceSquared <= (circle.radius * circle.radius)
end

local function collision_check()
    if checkCircleRectCollision(ball, Rectangle.new(p1.rect.x, p1.rect.y, p1.rect.width, p1.rect.height)) or
     checkCircleRectCollision(ball, Rectangle.new(p2.rect.x, p2.rect.y, p2.rect.width, p2.rect.height)) then
        ball.dx = -ball.dx
    end

end

function love.load()
    -- love.window.setFullscreen(true, "desktop")
    love.window.setMode(800, 600, {resizable = true})
    p1 = paddle.new(Rectangle.new(50, 50, 20, 200))
    p2 =  paddle.new(Rectangle.new(730, 50, 20, 200))
    
end

function love.update(dt)
    local x, y = love.mouse.getPosition() -- get the position of the mouse

    ball_bounds_check()
    collision_check()
    
    if not gameover then
        if love.keyboard.isDown("up") then
            p2.rect.y = p2.rect.y - 300 * dt
        elseif love.keyboard.isDown("down") then
            p2.rect.y = p2.rect.y + 300 * dt
        end

        if love.keyboard.isDown("w") then
            p1.rect.y = p1.rect.y - 300 * dt
        elseif love.keyboard.isDown("s") then
            p1.rect.y = p1.rect.y + 300 * dt
        end

        ball.x = ball.x + ball.vx * ball.dx * dt
        ball.y = ball.y + ball.vy * ball.dy * dt
    elseif gameover and pointRectangleCollision(x, y, restart.rect) and love.mouse.isDown(1) then
        gameover = false
        ball_reset()
    end
end

function love.draw()
    if not gameover then
        love.graphics.clear(0x18/255, 0x18/255, 0x18/255, 1)
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.circle("fill", ball.x, ball.y, ball.radius)
        love.graphics.setColor(0, 0.5, 1, 1)
        p1:draw()
        p2:draw()
    else
        love.graphics.setColor(0.7, 0.5, 1, 1)
        -- love.graphics.print("gameover", love.graphics.getWidth() / 2 - 50, love.graphics.getHeight() / 2 - 50, 0, 4, 4)
        restart:draw()
    end
  
end
