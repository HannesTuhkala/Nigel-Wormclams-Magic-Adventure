collision = {}
collision.map = require "map"
collision.tiles = collision.map.layers[1].data

local width = collision.map.layers[1].width
local height = collision.map.layers[1].height

local walkable = {}
walkable[1] = true

collision.getTileType = function(xTile, yTile)
    idx = ((yTile-1)*width+xTile)
    return collision.tiles[idx]
end

collision.isWalkable = function(tileType)
    return walkable[tileType]
end
