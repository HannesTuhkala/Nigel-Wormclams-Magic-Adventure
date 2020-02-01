require("player")
require("inventory")
require("ghelp")
require("draw")
require("item")
require("collision")

local talkies = require('talkies')
local dialog = require('dialog')

local questsys = require('questsys')
local sti = require "sti"

local inv_selected = {}
inv_selected.clicked = false
inv_selected.x = 0
inv_selected.y = 0

--https://github.com/rxi/tick
--https://github.com/rxi/classic
--https://github.com/adnzzzzZ/STALKER-X
--https://github.com/Karai17/Simple-Tiled-Implementation

-- Load some default values for our rectangle.
function love.load()
	tick = require "tick"
	classic = require "classic"
    camera = require "camera"

	inventory.init()
    map = sti("map.lua")
    imgs = ghelp.preloadimgs()
    player.sprite = imgs.player
    camera = camera()
    camera:setFollowStyle("TOPDOWN")

	talkies.textSpeed = "medium"
	talkies.padding = 20
	talkies.font = love.graphics.newFont("assets/fonts/Pixel UniCode.ttf", 32)
	talkies.talkSound = love.audio.newSource("assets/sound/sfx/talk.wav", "static")
	talkies.typedNotTalked = false
	talkies.pitchValues = {0.70, 0.72, 0.74, 0.76, 0.78, 0.80}
	love.audio.newSource("assets/sound/record_scratch.mp3", "static")
	talkies.say(dialog[1].title, dialog[1].text, {image = love.graphics.newImage("assets/images/player.png")})
	talkies.say(dialog[2].title, dialog[2].text, {image = love.graphics.newImage("assets/images/player.png")})


end

-- Increase the size of the rectangle every frame.
function love.update(dt)
	tick.update(dt)
    map:update(dt)

    local newX, newY = handleKeyboard(dt)
    local x, y = map:convertPixelToTile(newX, newY)
    local tile = collision.getTileType(math.ceil(x), math.ceil(y))
    local walkable = collision.isWalkable(tile)

    print(x, y, tile, walkable)

    if walkable == true then
        player.x, player.y = newX, newY
    end

    camera:update(dt)
    camera:follow(player.x, player.y)
	talkies.update(dt)
end

-- Draw a coloured rectangle.
function love.draw()
    camera:attach()
    map:draw(camera:toCameraCoords(0, 0))
    --print(player.x, player.y)
    love.graphics.draw(player.sprite, player.x, player.y)
    camera:detach()
	draw.inventory()
	draw.context_menu(inv_selected)
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

function love.mousepressed(x, y, button, istouch, presses)
	if button == 1 then
		inv_selected.clicked = false
	end
	
	if button == 2 then
		if x > 785 and y > 320 then
			local slot_x, slot_y = math.floor((x - 785)/80), math.floor((y - 320)/80)
			print("This was pressed: Row: " .. slot_x .. " Column: " .. slot_y)
			inv_selected.clicked = true
			inv_selected.x = x
			inv_selected.y = y
		else
			inv_selected.clicked = false
		end
	end
	
	print("("..x..", " .. y..")")
end