local items = {}

--items.health_potion = {}
--items.health_potion.heal = 20
--items.health_potion.use = function(player)
--	player.health = player.health + items.health_potion.heal
--end

items.create_health_potion = function()
	health_potion = {}
	health_potion.heal = 20
	health_potion.use = function(player)
		if player.health + health_potion.heal > 100 then player.health = 100 return end
		player.health = player.health + health_potion.heal
	end
	
	return health_potion
end

items.mana_potion = {}
items.mana_potion.use = function()
	-- regenerate mana somehow
	return
end

return items