draw = {}

draw.inventory = function()
	--love.graphics.rectangle("fill", 785, 280, 240, 40)
	for i = 0,3,1 do
		for j = 0,2,1 do
			love.graphics.draw(imgs.invslot, 785 + (j * 80), 240 + 80 + (i * 80))
		end
	end
	--love.graphics.print("Skills")
end

draw.context_menu = function(inv_selected)
	if inv_selected.clicked then
		local x
		local y = inv_selected.y
		
		if inv_selected.mirror then
			x = inv_selected.x - 60
		else
			x = inv_selected.x
		end
		
		love.graphics.rectangle("fill", x, y, 60, 51)
		
		love.graphics.setColor(0.1529, 0.5098, 0.6470, 1)
		if inv_selected.hover[1] then
			love.graphics.rectangle("fill", x, y, 60, 17)
		elseif inv_selected.hover[2] then
			love.graphics.rectangle("fill", x, y + 17, 60, 17)
		elseif inv_selected.hover[3] then
			love.graphics.rectangle("fill", x, y + 34, 60, 17)
		end
		love.graphics.setColor(255, 255, 255, 255)
		
		x = x + 5
		love.graphics.print({{0, 0, 0, 255}, "Use"}, x, y + 1, 0, 0.5)
		love.graphics.print({{0, 0, 0, 255}, "Drop"}, x, y + 16, 0, 0.5)
		love.graphics.print({{0, 0, 0, 255}, "Cancel"}, x, y + 31, 0, 0.5)
	end
end