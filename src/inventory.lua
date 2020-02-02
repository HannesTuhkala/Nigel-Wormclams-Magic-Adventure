local inventory = {}
inventory.inv = {}

inventory.init = function()
	for i=1,20,1 do
		inventory.inv[i] = nil
	end
end

inventory.contains_item = function(item_type)
	for k, v in ipairs(inventory.inv) do
		if v == item_type then
			return k
		end
	end
	
	return -1
end

inventory.add_item = function(item)
	local itemslot = contains_item(item.type)
	
	if itemslot ~= -1 then
		inventory.inv[itemslot].quantity = inventory.inv[itemslot].quantity + 1
	else
		for k, v in ipairs(inventory.inv) do
			if not v then
				inventory.inv[k] = item
				return
			end
		end
	end
end

return inventory