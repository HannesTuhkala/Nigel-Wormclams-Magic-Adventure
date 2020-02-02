local inventory = {}
inventory.inv = {}

inventory.init = function()
	for i=1,20,1 do
		inventory.inv[i] = nil
	end
end

return inventory