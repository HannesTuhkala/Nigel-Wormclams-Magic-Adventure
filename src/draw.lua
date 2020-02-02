local draw = {}

local constants = require('constants')

-- Will only be drawn if tab_index is set to 0. Is called by draw.tabs(tab_index).
draw.inventory = function(inventory)
	for i = 0,3,1 do
		for j = 0,2,1 do
			love.graphics.draw(imgs.invslot, constants.inventory.origin_x + (j * constants.inventory.slot_width),
								constants.inventory.origin_y + (i * constants.inventory.slot_height))
		end
	end
	
	--for i = 0,19,1 do
	--	if not inventory[i+1] then
	--		print()
	--	else
	--		local x, y = 800 + (math.floor(i%3) * 80), 335 + (math.floor(i%4) * 80)
	--		love.graphics.draw(inventory[i+1].image, x, y, 0, 0.1, 0.1)
	--	end
	--end
	
	if not inventory[1] then return end
	love.graphics.draw(inventory[1].image, 800, 337)
end

-- Draws a context_menu if a player right-clicks on a slot in the inventory tab.
draw.context_menu = function(inv_selected)
	if inv_selected.clicked then
		local x
		local y = inv_selected.y
		
		if inv_selected.mirror then
			x = inv_selected.x - constants.context_menu.width
		else
			x = inv_selected.x
		end
		
		love.graphics.rectangle("fill", x, y, constants.context_menu.width, constants.context_menu.height)
		
		love.graphics.setColor(constants.context_menu.hover_color)
		if inv_selected.hover[1] then
			love.graphics.rectangle("fill", x, y, constants.context_menu.width, constants.context_menu.sub_height)
		elseif inv_selected.hover[2] then
			love.graphics.rectangle("fill", x, y + constants.context_menu.sub_height, constants.context_menu.width, constants.context_menu.sub_height)
		elseif inv_selected.hover[3] then
			love.graphics.rectangle("fill", x, y + constants.context_menu.sub_height * 2, constants.context_menu.width, constants.context_menu.sub_height)
		end
		love.graphics.setColor(1, 1, 1, 1)
		
		x = x + 5
		love.graphics.print({{0, 0, 0, 255}, "Use"}, x, y + 2, 0, 0.8)
		love.graphics.print({{0, 0, 0, 255}, "Drop"}, x, y + 19, 0, 0.8)
		love.graphics.print({{0, 0, 0, 255}, "Cancel"}, x, y + 36, 0, 0.8)
	end
end

-- Decides whether to draw the skills-tab or the inventory tab based on tab_index.
-- inv_selected is used for draw.context_menu to let it know which option the mouse is on.
draw.tabs = function(tab_index, inv_selected, player_attributes, inventory)
	love.graphics.draw(imgs.inventoryIcon, 785, 280)
	love.graphics.draw(imgs.skillsIcon, 905, 280)
	love.graphics.setColor(constants.tabs.selected_color)
	love.graphics.line(795 + (120 * tab_index), 314, 890 + (120 * tab_index), 314)
	love.graphics.setColor(1, 1, 1, 1)
	
	if tab_index == 0 then
		draw.inventory(inventory)
		draw.context_menu(inv_selected)
	elseif tab_index == 1 then
		draw.skills(player_attributes)
	elseif tab_index == 2 then
		draw.equipment()
	end
end

-- Will only be drawn if tab_index is set to 1. Is called by draw.tabs(tab_index).
draw.skills = function(ply_attr)
    love.graphics.draw(imgs.skillsslot, 785, 320)
	local old_font = love.graphics.getFont()
	love.graphics.setFont(love.graphics.newFont("assets/fonts/Pixel UniCode.ttf", 32))
	love.graphics.setColor(constants.tabs.selected_color)
	love.graphics.print("Strength:", 815, 345)
	love.graphics.print(ply_attr.strength, 940, 345)
	love.graphics.print("Intellect:", 815, 390)
	love.graphics.print(ply_attr.intellect, 940, 390)
	love.graphics.print("Speed:", 815, 435)
	love.graphics.print(ply_attr.speed, 940, 435)
	love.graphics.print("Charisma:", 815, 480)
	love.graphics.print(ply_attr.charisma, 940, 480)
	love.graphics.print("Agility:", 815, 525)
	love.graphics.print(ply_attr.agility, 940, 525)
	love.graphics.print("Spirit:", 815, 570)
	love.graphics.print(ply_attr.spirit, 940, 570)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setFont(old_font)
end

draw.health_bar = function(health)
	love.graphics.rectangle("line", 250, 590, 400, 40)
	local health_length = 398 * (health/100)
	love.graphics.setColor(0, 1, 0, 1)
	love.graphics.rectangle("fill", 251, 591, health_length, 39)
	love.graphics.setColor(1, 1, 1, 1)
end

draw.equipment = function()
	love.graphics.rectangle("fill", 785, 320, 340, 320)
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.rectangle("line", 785+90, 320+10, 60, 60)
	love.graphics.rectangle("line", 785+90, 320+90, 60, 60)
	love.graphics.rectangle("line", 800, 320+130, 60, 60)
	love.graphics.rectangle("line", 950, 320+130, 60, 60)
	love.graphics.rectangle("line", 785+90, 320+170, 60, 60)
	love.graphics.rectangle("line", 785+90, 320+250, 60, 60)
	love.graphics.setColor(1, 1, 1, 1)
end

draw.init_particles = function()
    psystem = love.graphics.newParticleSystem(imgs.fireparticle, 5)
    psystem:setParticleLifetime(1, 2) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(4)
	psystem:setSizeVariation(1)
	psystem:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.
    return psystem
end

return draw
