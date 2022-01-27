
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