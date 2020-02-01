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

local constants = require('constants')

-- Either 0 or 1 depending if inventory or skill is chosen.
local tab_index = 1

local inv_selected = {}
inv_selected.hover = {}
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

    local newX, newY, dir = move(dt)
    local tileOne, tileTwo

    if dir ~= nil then
        local x, y
        if dir == "up" then
            -- upper left
            x, y = map:convertPixelToTile(newX, newY)
            tileOne = collision.getTileType(math.ceil(x), math.ceil(y))
            -- upper right
            x, y = map:convertPixelToTile(newX+player.width, newY)
            tileTwo = collision.getTileType(math.ceil(x), math.ceil(y))

        elseif dir == "down" then
            -- lower left
            x, y = map:convertPixelToTile(newX, newY+player.height)
            tileOne = collision.getTileType(math.ceil(x), math.ceil(y))
            -- lower right
            x, y = map:convertPixelToTile(newX+player.width, newY+player.height)
            tileTwo = collision.getTileType(math.ceil(x), math.ceil(y))

        elseif dir == "left" then
            -- upper left
            x, y = map:convertPixelToTile(newX, newY)
            tileOne = collision.getTileType(math.ceil(x), math.ceil(y))
            -- lower left
            x, y = map:convertPixelToTile(newX, newY+player.height)
            tileTwo = collision.getTileType(math.ceil(x), math.ceil(y))

        elseif dir == "right" then
            -- upper right
            x, y = map:convertPixelToTile(newX+player.width, newY)
            tileOne = collision.getTileType(math.ceil(x), math.ceil(y))
            -- lower right
            x, y = map:convertPixelToTile(newX+player.width, newY+player.height)
            tileTwo = collision.getTileType(math.ceil(x), math.ceil(y))
        end

        local walkableOne = collision.isWalkable(tileOne)
        local walkableTwo = collision.isWalkable(tileTwo)

        if walkableOne == true and walkableTwo == true then
            player.x, player.y = newX, newY
        end
    end

    camera:update(dt)
    camera:follow(player.x, player.y)
	talkies.update(dt)
end

-- Draw a coloured rectangle.
function love.draw()
    camera:attach()
    map:draw(camera:toCameraCoords(0, 0))
    love.graphics.draw(player.sprite, player.x, player.y)
    camera:detach()
	draw.inventory()
	draw.context_menu(inv_selected)
	draw.tabs(tab_index)
	talkies.draw()
end

function move(dt)
    local dx, dy = 0, 0
    local dir

    if love.keyboard.isDown('w') then
        dy = -1
        dir = "up"
    end
    if love.keyboard.isDown('s') then
        dy = 1
        dir = "down"
    end
    if love.keyboard.isDown('a') then
        dx = -1
        dir = "left"
    end
    if love.keyboard.isDown('d') then
        dx = 1
        dir = "right"
    end

    length = math.sqrt(dx^2 + dy^2)

    if length == 0 then
        return player.x, player.y, dir
    end

    dx, dy = dx/length, dy/length

    local y = player.y + (player.attributes.speed * dt * dy)
    local x = player.x + (player.attributes.speed * dt * dx)

    return x, y, dir
end

function love.keypressed(key)
	if key == "space" then talkies.onAction()
	elseif key == "up" then talkies.prevOption()
	elseif key == "down" then talkies.nextOption()
	end
end

function love.mousemoved(x, y, dx, dy, istouch)
	if inv_selected.clicked then
		if (inv_selected.mirror and x > inv_selected.x - 60 and x < inv_selected.x) or
			(not inv_selected.mirror and x > inv_selected.x and x < inv_selected.x + 60) then
			if y > inv_selected.y and y < inv_selected.y + 51 then
				inv_selected.hover[1] = false
				inv_selected.hover[2] = false
				inv_selected.hover[3] = false
				inv_selected.hover[math.floor((y-inv_selected.y) / 17) + 1] = true
			else
				inv_selected.hover[1] = false
				inv_selected.hover[2] = false
				inv_selected.hover[3] = false
			end
		else
			inv_selected.hover[1] = false
			inv_selected.hover[2] = false
			inv_selected.hover[3] = false
		end
	else
		inv_selected.hover[1] = false
		inv_selected.hover[2] = false
		inv_selected.hover[3] = false
	end
end

function love.mousepressed(x, y, button, istouch, presses)
	if button == 1 then
		if inv_selected.clicked then
			if (inv_selected.mirror and x > inv_selected.x - 60 and x < inv_selected.x) or
				(not inv_selected.mirror and x > inv_selected.x and x < inv_selected.x + 60) then
				if y > inv_selected.y and y < inv_selected.y + 51 then
					option = math.floor((y-inv_selected.y) / 17) + 1
				end
			else
				inv_selected.hover[1] = false
				inv_selected.hover[2] = false
				inv_selected.hover[3] = false
			end
		else
			inv_selected.hover[1] = false
			inv_selected.hover[2] = false
			inv_selected.hover[3] = false
		end
		
		inv_selected.hover[1] = false
		inv_selected.hover[2] = false
		inv_selected.hover[3] = false
		
		inv_selected.clicked = false
		inv_selected.mirror = false
	end
	
	if button == 2 then
		if x > 785 and y > 320 then
			local slot_x, slot_y = math.floor((x - 785)/80), math.floor((y - 320)/80)
			inv_selected.clicked = true
			inv_selected.x = x
			inv_selected.y = y
			
			if x > 1024 - 60 then
				inv_selected.mirror = true
			else
				inv_selected.mirror = false
			end
		else
			inv_selected.clicked = false
			inv_selected.mirror = false
		end
	end
end
