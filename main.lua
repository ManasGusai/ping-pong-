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

local paddle = require("paddle")
local button = require("Button")

local p1
local p2
local restart = button.new(300, 400, 200, 70, "restart")

local function ball_bounds_check()
    -- Ball
    if ball.x > 800 - ball.radius or ball.x < 0 + ball.radius then
        ball.dx = -ball.dx
        gameover = true
    elseif ball.y > 600 - ball.radius or ball.y < 0 + ball.radius then
        ball.dy = -ball.dy
    end
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
    if checkCircleRectCollision(ball, p1) or checkCircleRectCollision(ball, p2) then
        ball.dx = -ball.dx
    end

end

function love.load()
    -- love.window.setFullscreen(true, "desktop")
    love.window.setMode(800, 600, {resizable = false})
    p1 = paddle.new(50, 50, 20, 200)
    p2 =  paddle.new(730, 50, 20, 200)
    
end

function love.update(dt)
    local x, y = love.mouse.getPosition() -- get the position of the mouse

    ball_bounds_check()
    collision_check()
    
    if not gameover then
        if love.keyboard.isDown("up") then
            p2.y = p2.y - 300 * dt
        elseif love.keyboard.isDown("down") then
            p2.y = p2.y + 300 * dt
        end

        if love.keyboard.isDown("w") then
            p1.y = p1.y - 300 * dt
        elseif love.keyboard.isDown("s") then
            p1.y = p1.y + 300 * dt
        end

        ball.x = ball.x + ball.vx * ball.dx * dt
        ball.y = ball.y + ball.vy * ball.dy * dt
    
    elseif restart:update(x, y) then
        gameover = false
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
        love.graphics.print("gameover", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
        restart:draw()
    end
  
end
