overworld = {}
overworld.map = require "maps/overworld"

overworld.width = overworld.map.width
overworld.height = overworld.map.height
overworld.tilewidth = overworld.map.tilewidth
overworld.tileheight = overworld.map.tileheight
overworld.layers = overworld.map.layers

local typedTiles = overworld.map.tilesets[1].tiles
local overworldDetails = overworld.layers[3].data

overworld.draw = function()
    for layerindex, layerdata in ipairs(overworld.layers) do
        for tileindex, tiletype in ipairs(layerdata.data) do
            local tileYIndex = math.ceil(tileindex / overworld.width)
            local tileXIndex = tileindex % overworld.height
            --print(tileXIndex, tileYIndex)
        end
        break
    end
end

return overworld
