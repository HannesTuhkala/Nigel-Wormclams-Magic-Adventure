require("player")
require("ghelp")

-- Load some default values for our rectangle.
function love.load()
    imgs = ghelp.preloadimgs()
    player.sprite = imgs.player
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
end

-- Draw a coloured rectangle.
function love.draw()
    love.graphics.draw(imgs.map1)
    love.graphics.draw(player.sprite, 0, 0)
end
