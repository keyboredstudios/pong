
function polarToCart(radius, theta)
    rtnCart = {}
    rtnCart.x = radius * math.cos(theta)
    rtnCart.y = radius * math.sin(theta)
    return rtnCart
end