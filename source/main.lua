import "CoreLibs/graphics"
local gfx <const> = playdate.graphics

local screenWidth = 400 - 10
local screenHeight = 240 - 10

local posX = 200
local posY = 200

local forceDir = 0
local speed = 2

local xDir = 1
local yDir = 1

function playdate.update()
    gfx.clear()
    
    calcPhysics()

    gfx.fillRect(posX,posY, 10,10)
end

function calcPhysics()
    local force = polarToCart(speed, forceDir)
    posX += force.x
    posY += force.y

    if posX >= screenWidth then
        xDir = -1
    elseif posX <= 0 then
        xDir = 1
    end

    if posY >= screenHeight then
        yDir = -1
    elseif posY <= 0 then
        yDir = 1
    end


    -- 45°
    if xDir > 0 and yDir > 0 then
        forceDir = math.pi / 4
    end

    -- 135°
    if xDir < 0 and yDir > 0 then
        forceDir = 3 * math.pi / 4
    end

    -- 225°
    if xDir < 0 and yDir < 0 then
        forceDir = 5 * math.pi / 4
    end

    -- 315°
    if xDir > 0 and yDir < 0 then
        forceDir = 7 * math.pi / 4
    end

end

function polarToCart(radius, theta)
    rtnCart = {}
    rtnCart.x = radius * math.cos(theta)
    rtnCart.y = radius * math.sin(theta)
    return rtnCart
end