require("player")
require("inventory")
require("ghelp")
require("draw")
require("item")

--https://github.com/rxi/tick
--https://github.com/rxi/classic

-- Load some default values for our rectangle.
function love.load()
	tick = require "tick"
	classic = require "classic"
	inventory.init()
    imgs = ghelp.preloadimgs()
    player.sprite = imgs.player
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
	tick.update(dt)
end

-- Draw a coloured rectangle.
function love.draw()
    love.graphics.draw(imgs.map1)
    love.graphics.draw(player.sprite, 0, 0)
	draw.inventory()
end
