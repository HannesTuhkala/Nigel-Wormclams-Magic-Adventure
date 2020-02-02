local collision = {}
collision.map = require "map"
collision.tiles = collision.map.layers[3].data

local width = collision.map.layers[1].width
local height = collision.map.layers[1].height

local basictilesWalkable = collision.map.tilesets[1].tiles

local walkable = {}
local torches = {}

for i, v in ipairs(basictilesWalkable) do
    if basictilesWalkable[i].type == "walkable" then
        walkable[basictilesWalkable[i].id] = true
    elseif basictilesWalkable[i].type == "torch" then
        torches[basictilesWalkable[i].id+1] = true
    end
end

collision.getTileType = function(xTile, yTile)
    idx = ((yTile-1)*width+xTile)
    return collision.tiles[idx]
end

collision.isWalkable = function(tileType)
    return walkable[tileType]
end

torchesIdx = {}
collision.getAllTorches = function()
    for i, v in ipairs(collision.tiles) do
        if torches[collision.tiles[i]] == true then
            table.insert(torchesIdx, i)
        end
    end
    return torchesIdx
end

return collision
