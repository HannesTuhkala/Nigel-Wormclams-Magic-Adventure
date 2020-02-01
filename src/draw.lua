draw = {}

local constants = require('constants')

draw.inventory = function()
	for i = 0,3,1 do
		for j = 0,2,1 do
			love.graphics.draw(imgs.invslot, constants.inventory.origin_x + (j * constants.inventory.slot_width),
								constants.inventory.origin_y + (i * constants.inventory.slot_height))
		end
	end
end

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
		love.graphics.print({{0, 0, 0, 255}, "Use"}, x, y + 1, 0, 0.5)
		love.graphics.print({{0, 0, 0, 255}, "Drop"}, x, y + 16, 0, 0.5)
		love.graphics.print({{0, 0, 0, 255}, "Cancel"}, x, y + 31, 0, 0.5)
	end
end

draw.tabs = function(tab_index)
	--love.graphics.rectangle("fill", 785, 280, 240, 40)
	love.graphics.draw(imgs.inventoryIcon, 785, 280)
	love.graphics.draw(imgs.skillsIcon, 905, 280)
	love.graphics.setColor(constants.tabs.selected_color)
	love.graphics.line(795 + (120 * tab_index), 314, 890 + (120 * tab_index), 314)
	love.graphics.setColor(1, 1, 1, 1)
end