
function polarToCart(radius, theta)
    rtnCart = {}
    rtnCart.x = radius * math.cos(theta)
    rtnCart.y = radius * math.sin(theta)
    return rtnCart
end

--[[
    coll1, coll2: {
        xMin: number,
        xMax: number,
        yMin: number,
        yMax: number
    }
--]]
function checkCollision(coll1, coll2)
    local xHit = coll2.xMin >= coll1.xMin and coll2.xMin <= coll1.xMax or
                 coll2.xMax >= coll1.xMin and coll2.xMax <= coll1.xMax

    local yHit = coll2.yMin >= coll1.yMin and coll2.yMin <= coll1.yMax or
                 coll2.yMax >= coll1.yMin and coll2.yMax <= coll1.yMax

    return xHit and yHit
end

-- Based on unity's lerp: https://docs.unity3d.com/ScriptReference/Mathf.Lerp.html
function lerp(a, b, t)
    return a - (a - b) * t
end
--[[ Lerp test:
    print(lerp(100, 50, 1)) -- 50
    print(lerp(50, 100, 1)) -- 100
    print(lerp(-100, 100, 0.5)) -- 0
    print(lerp(100, -100, 0.5)) -- 0
    print(lerp(-50, 100, 0.5)) -- 25
    print(lerp(100, -50, 0.5)) -- 25
    print(lerp(0, 100, 0.5)) -- 50
    print(lerp(0, 100, 0.75)) -- 75
    print(lerp(100, 0, 0.75)) -- 25
    print(lerp(-100, -0, 0.75)) -- -25
    print(lerp(0, -100, 0.75)) -- -75
--]]

function sign(numb)
    if numb < 0 then
        return -1
    else
        return 1
    end
end

-- Based on unity's clamp: https://docs.unity3d.com/ScriptReference/Mathf.Clamp.html
function clamp(value, min, max)
    return math.max(math.min(value, max), min)
end
--[[ clamp test:
    print(clamp(3, 5, 10)) -- 5
    print(clamp(12, 5, 10)) -- 10
    print(clamp(7, 5, 10)) -- 7
    print(clamp(-4, -16, -1)) -- -4
    print(clamp(-17, -16, -1)) -- -16
    print(clamp(-0, -16, -1)) -- -1
--]]

function inRange(value, min, max)
    return value >= min and value <= max
end

function flipACoin()
    return sign(math.random(-1, 0)) -- Can be -1 or 0 (So a 50/50 chance).
end
