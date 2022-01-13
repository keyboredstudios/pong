import "CoreLibs/graphics"
import "lib"
local gfx <const> = playdate.graphics

local screenWidth = 400 - 10
local screenHeight = 240 - 10

-- local pong = {}
-- pong.posX = 200
-- pong.posY = 200
-- pong.forceDir = 0
-- pong.speed = 2
-- pong.xDir = 1
-- pong.yDir = 1

local pongArr = {}
function addPong()
    local len = #pongArr
    pongArr[len+1] = {}
    pongArr[len+1].posX = math.random(0, screenHeight)
    pongArr[len+1].posY = math.random(0, screenWidth)
    pongArr[len+1].forceDir = 0
    pongArr[len+1].speed = 2
    pongArr[len+1].xDir = 1
    pongArr[len+1].yDir = 1
end

function playdate.update()
    gfx.clear()

    local len = #pongArr
    for i=1, len, 1 do
        calcPhysics(pongArr[i])
    end

    --calcPhysics(pong)
end

function calcPhysics(pongL)
    local force = polarToCart(pongL.speed, pongL.forceDir)
    pongL.posX += force.x
    pongL.posY += force.y

    if pongL.posX >= screenWidth then
        pongL.xDir = -1
    elseif pongL.posX <= 0 then
        pongL.xDir = 1
    end

    if pongL.posY >= screenHeight then
        pongL.yDir = -1
    elseif pongL.posY <= 0 then
        pongL.yDir = 1
    end

    -- 45°
    if pongL.xDir > 0 and pongL.yDir > 0 then
        pongL.forceDir = math.pi / 4
    end

    -- 135°
    if pongL.xDir < 0 and pongL.yDir > 0 then
        pongL.forceDir = 3 * math.pi / 4
    end

    -- 225°
    if pongL.xDir < 0 and pongL.yDir < 0 then
        pongL.forceDir = 5 * math.pi / 4
    end

    -- 315°
    if pongL.xDir > 0 and pongL.yDir < 0 then
        pongL.forceDir = 7 * math.pi / 4
    end

    gfx.fillRect(pongL.posX, pongL.posY, 10, 10)
end

function playdate.AButtonDown()
    addPong()
end