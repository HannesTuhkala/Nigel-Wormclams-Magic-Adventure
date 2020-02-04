require 'util'

local items = {}
items.created = {}

items.new = function(name, image, use)
    if items.created[name] then return table.deep_copy(items.created[name]) end
    
    local item = {}
    item.name = name
    item.image = image
    item.quantity = 1
    item.use = use
    
    items.created[name] = item
    return item
end

items.get = function(name)
    return items.created[name]
end

return items