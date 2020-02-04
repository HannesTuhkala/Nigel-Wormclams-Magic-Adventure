local inventory = {}
inventory.inv = {}

-- Checks whether the inventory contains that item or not.
inventory.contains_item = function(item_name)
    for k, v in ipairs(inventory.inv) do
        if v == item_name then
            return k
        end
    end
    
    return -1
end

-- Checks whether there is a current item in the inventory already,
-- otherwise it adds it unless the inventory is full (12 slots).
-- If it is full it ends silently (TODO: FIX).
inventory.add_item = function(item)
    local itemslot = contains_item(item.name)
    
    if itemslot ~= -1 then
        inventory.inv[itemslot].quantity = inventory.inv[itemslot].quantity + 1
    else
        if #inventory.inv < 12 then
            for k, v in ipairs(inventory.inv) do
                if not v then
                    inventory.inv[k] = item
                    return
                end
            end
        end
    end
end

return inventory