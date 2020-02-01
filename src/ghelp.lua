ghelp = {}

ghelp.preloadimgs = function()
        local dir = "assets/images/"
        local files = love.filesystem.getDirectoryItems(dir)
        local images = {}
        local k = ""
        for i = 1, #files, 1 do
            k = files[i]
            images[k:gsub("%p%a%a%a", "")] = love.graphics.newImage(dir..files[i])
        end
        return images
    end
