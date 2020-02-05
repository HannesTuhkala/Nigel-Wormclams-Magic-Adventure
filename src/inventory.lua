local constants = require('constants')

local inventory = {}
inventory.inv = {}

-- Checks whether the inventory contains that item or not.
function inventory:contains(item_name)
    for k, v in ipairs(self.inv) do
        if v.name == item_name then
            return k
        end
    end
    
    return -1
end

-- Checks whether there is a current item in the inventory already,
-- otherwise it adds it unless the inventory is full (12 slots).
-- Parameter stack is boolean that is used to control whether to stack
-- the current item added or not.
-- If it is full it ends silently (TODO: FIX).
function inventory:add(item, stack)
    stack = stack or stack == nil
    local itemslot = self:contains(item.name)
    
    if itemslot ~= -1 and stack then
        self.inv[itemslot].quantity = self.inv[itemslot].quantity + 1
    else
        for i=1,constants.inventory.size,1 do
            if not self.inv[i] then
                self.inv[i] = item
                return
            end
        end
    end
end

function inventory:get(index)
    return self.inv[index]
end

function inventory:drop(index)
    self.inv[index] = nil
end

function inventory:use(index, player)
    if not self.inv[index] then return end
    
    self.inv[index].use(player)
    self.inv[index].quantity = self.inv[index].quantity - 1
    if self.inv[index].quantity == 0 then self:drop(index) end
end

return inventory