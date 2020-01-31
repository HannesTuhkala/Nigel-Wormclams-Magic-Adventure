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
    local x, y = handleKeyboard(dt)
	if checkCollisions(x, y) then
		player.x, player.y = x, y
	end
end

-- Draw a coloured rectangle.
function love.draw()
    love.graphics.draw(imgs.map1)
    love.graphics.draw(player.sprite, player.x, player.y)
	draw.inventory()
end

function handleKeyboard(dt)
    local dx, dy = 0, 0

    if love.keyboard.isDown('w') then
        dy = -1
    end
    if love.keyboard.isDown('s') then
        dy = 1
    end
    if love.keyboard.isDown('a') then
        dx = -1
    end
    if love.keyboard.isDown('d') then
        dx = 1
    end

    length = math.sqrt(dx^2 + dy^2)

    if length == 0 then
        return player.x, player.y
    end

    dx, dy = dx/length, dy/length

    local y = player.y + (player.attributes.speed * dt * dy)
    local x = player.x + (player.attributes.speed * dt * dx)

    return x, y
end

function checkCollisions(x, y)
	return x > 0 and x + player.width < 1024 and y > 0 and y + player.height < 640
end