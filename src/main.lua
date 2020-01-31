require("player")
require("inventory")
require("ghelp")


--https://github.com/rxi/tick


-- Load some default values for our rectangle.
function love.load()
    imgs = preloadimgs()
	tick = require "tick"
	inventory.init()
    x, y, w, h = 20, 20, 60, 20
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
	tick.update(dt)
end

-- Draw a coloured rectangle.
function love.draw()
    love.graphics.draw(imgs.map1)
    love.graphics.setColor(0, 0.4, 0.4)
    love.graphics.rectangle("fill", x, y, w, h)
end
