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
		love.graphics.rectangle("fill", inv_selected.x, inv_selected.y, 60, 60)
	end
end