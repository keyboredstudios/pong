import "CoreLibs/graphics"
import "lib"
local gfx <const> = playdate.graphics

local screenWidth = 400 - 10
local screenHeight = 240 - 10

local pong = {}
local player = {}
player.x = 10
player.y = 0
player.speed = 2
player.width = 10
player.height = 30

function playdate.update()
    gfx.clear()

    -- Pong Ball
    calcPhysics()
    gfx.fillRect(pong.x, pong.y, 10, 10)

    -- Player
    if playdate.buttonIsPressed('up') and player.y > 0 then
        player.y -= 1 * player.speed
    end
    if playdate.buttonIsPressed('down') and player.y + player.height < 240 then
        player.y += 1 * player.speed
    end
    gfx.fillRect(player.x, player.y, 10, 30)
end

function calcPhysics()
    local force = polarToCart(pong.speed, pong.forceDir)
    pong.x += force.x
    pong.y += force.y

    local didHit = pong.x >= screenWidth or pong.x <= 0 or pong.y >= screenHeight or pong.y <= 0 or isTouchingPlayer()

    if didHit then
        if pong.x >= screenWidth then
            pong.xDir = -1
        elseif pong.x <= 0 then
            pong.xDir = 1
        end

        if pong.y >= screenHeight then
            pong.yDir = -1
        elseif pong.y <= 0 then
            pong.yDir = 1
        end

        if isTouchingPlayer() then
            pong.xDir *= -1
        end

        -- 45°
        if pong.xDir > 0 and pong.yDir > 0 then
            pong.forceDir = math.pi / 4
        end

        -- 135°
        if pong.xDir < 0 and pong.yDir > 0 then
            pong.forceDir = 3 * math.pi / 4
        end

        -- 225°
        if pong.xDir < 0 and pong.yDir < 0 then
            pong.forceDir = 5 * math.pi / 4
        end

        -- 315°
        if pong.xDir > 0 and pong.yDir < 0 then
            pong.forceDir = 7 * math.pi / 4
        end
    end
end

function isTouchingPlayer()
    return  pong.x >= player.x and pong.x <= player.x + player.width and
            pong.y >= player.y and pong.y <= player.y + player.height
end

function init()
    -- Reset Pong
    pong = {}
    pong.x = screenWidth / 2
    pong.y = screenHeight / 2
    pong.width = 10
    pong.height = 10
    pong.forceDir = 0
    pong.speed = 2
    pong.xDir = 1
    pong.yDir = 1
end
init()
