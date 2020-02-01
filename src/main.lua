require("player")
require("inventory")
require("ghelp")
require("draw")
require("item")

local talkies = require('talkies')
local text = {"Nigel Wormclam", "This is me. Nigel Wormclam. You might be wondering how I ended up here. To cut a long story short, I am the saviour of the world " ..
								" and I have to save the world before the unthinkable thing happens."}
local dialog = {"Nigel Wormclam", "Yes. You guessed it. There will be no more Trocadero in the world."}

--https://github.com/rxi/tick
--https://github.com/rxi/classic
--https://github.com/adnzzzzZ/STALKER-X

-- Load some default values for our rectangle.
function love.load()
	tick = require "tick"
	classic = require "classic"
    Camera = require "camera"

	inventory.init()
    imgs = ghelp.preloadimgs()
    player.sprite = imgs.player
    camera = Camera()
    camera:setFollowStyle("TOPDOWN")

	talkies.textSpeed = "medium"
	talkies.padding = 20
	talkies.font = love.graphics.newFont("assets/fonts/Pixel UniCode.ttf", 32)
	talkies.say(text[1], text[2], {talkSound = love.audio.newSource("assets/sound/record_scratch.mp3", "static"),
									image = love.graphics.newImage("assets/images/player.png")})
	talkies.say(dialog[1], dialog[2], {image = love.graphics.newImage("assets/images/player.png")})
end

-- Increase the size of the rectangle every frame.
function love.update(dt)	
	tick.update(dt)
    player.x, player.y = handleKeyboard(dt)
    --local x, y = handleKeyboard(dt)
	--if checkCollisions(x, y) then
	--	player.x, player.y = x, y
	--end
    camera:update(dt)
    camera:follow(player.x, player.y)
	talkies.update(dt)
end

-- Draw a coloured rectangle.
function love.draw()
    camera:attach()
    love.graphics.draw(imgs.map1)
    love.graphics.draw(player.sprite, player.x, player.y)
	draw.inventory()
    camera:detach()
	talkies.draw()
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

function love.keypressed(key)
	if key == "space" then talkies.onAction()
	elseif key == "up" then talkies.prevOption()
	elseif key == "down" then talkies.nextOption()
	end
end

function checkCollisions(x, y)
	return x > 0 and x + player.width < 1024 and y > 0 and y + player.height < 640
end
