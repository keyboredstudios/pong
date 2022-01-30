import "CoreLibs/graphics"
import "lib"
local gfx <const> = playdate.graphics

playdate.display.setRefreshRate(50)
gfx.setFont(gfx.font.new('/font/font-rains-3x'))

local screenWidth = 400 - 10
local screenHeight = 240 - 10

local pong = {}
local player = {}
local ai = {}

function playdate.update()
    gfx.clear()

    -- Pong Ball
    calcPhysics()
    gfx.fillRect(pong.x, pong.y, pong.width, pong.height)

    -- Player
    player.oldY = player.y
    if playdate.buttonIsPressed('up') and player.y > 0 then
        player.y -= 1 * player.speed
    end
    if playdate.buttonIsPressed('down') and player.y + player.height < 240 then
        player.y += 1 * player.speed
    end
    gfx.fillRect(player.x, player.y, player.width, player.height)

    -- AI
    ai.oldY = ai.y
    ai.y = lerp(ai.y, pong.y, ai.difficulty / pong.speed) -- Divide by the pong's speed so the AI gets worse as the pong speeds up, just like the real player.
    ai.y = math.min(ai.y, 240 - ai.height) -- Clamp the AI's max height to fit the screen size.
    gfx.fillRect(ai.x, ai.y, ai.width, ai.height)

    -- Score
    gfx.drawTextAligned(player.score, 170, 5, kTextAlignment.center)
    gfx.drawTextAligned("|", 200, 5, kTextAlignment.center)
    gfx.drawTextAligned(ai.score, 230, 5, kTextAlignment.center)
end

function calcPhysics()
    local force = polarToCart(pong.speed, pong.forceDir)
    pong.x += force.x
    pong.y += force.y

    local isTouchingPlayer = checkCollision(
        {
            xMin = player.x,
            xMax = player.x + player.width,
            yMin = player.y,
            yMax = player.y + player.height,
        },
        {
            xMin = pong.x,
            xMax = pong.x + pong.width,
            yMin = pong.y,
            yMax = pong.y + pong.height,
        }
    )

    local isTouchingAi = checkCollision(
        {
            xMin = ai.x,
            xMax = ai.x + ai.width,
            yMin = ai.y,
            yMax = ai.y + ai.height,
        },
        {
            xMin = pong.x,
            xMax = pong.x + pong.width,
            yMin = pong.y,
            yMax = pong.y + pong.height,
        }
    )

    local didHit = pong.x >= screenWidth or pong.x <= 0 or pong.y >= screenHeight or pong.y <= 0 or isTouchingPlayer or isTouchingAi

    if didHit then
        -- Each bounce the speed of the ball gets faster.
        pong.speed += 0.15

        if pong.y >= screenHeight then
            pong.yDir = -1
        elseif pong.y <= 0 then
            pong.yDir = 1
        end

        if isTouchingPlayer then
            local hitDir = player.y - player.oldY
            pong.xDir = 1

            if hitDir ~= 0 then
                pong.yDir = sign(hitDir)
            end
        end

        if isTouchingAi then
            local hitDir = ai.y - ai.oldY
            pong.xDir = -1

            if hitDir ~= 0 then
                pong.yDir = sign(hitDir)
            end
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

        -- 0° & 180°
        -- Check to update score if the pong hit a goal.
        if pong.x >= screenWidth then
            player.score += 1
            resetPong()
            pong.forceDir = 0
            pong.xDir = 1
        elseif pong.x <= 0 then
            ai.score += 1
            resetPong()
            pong.forceDir = math.pi
            pong.xDir = -1
        end
    end
end

function resetPong()
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

function init()
    -- Reset Pong
    resetPong()

    -- Reset Player
    player = {}
    player.x = 10
    player.y = 240/2
    player.speed = 5
    player.width = 10
    player.height = 30
    player.score = 0
    player.oldY = 0

    -- Reset AI
    ai = {}
    ai.x = 380
    ai.y = 240/2
    ai.difficulty = 2.0 -- Must be between 0 and pong.speed because ai.difficulty divided by pong.speed must be less than 1.0.
    ai.width = 10
    ai.height = 30
    ai.score = 0
    ai.oldY = 0
end
init()
