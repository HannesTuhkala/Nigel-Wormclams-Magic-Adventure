local constants = {}

constants.inventory = {}
constants.inventory.origin_x = 785
constants.inventory.origin_y = 320
constants.inventory.slot_width = 80
constants.inventory.slot_height = 80
constants.inventory.size = 12

constants.context_menu = {}
constants.context_menu.width = 60
constants.context_menu.height = 51
constants.context_menu.sub_height = 17
constants.context_menu.hover_color = {0.1529, 0.5098, 0.6470, 1}

constants.tabs = {}
constants.tabs.selected_color = {0.8039, 0.7608, 0, 1}

constants.fonts = {}
constants.fonts.default = love.graphics.newFont("assets/fonts/Pixel UniCode.ttf", 32)

return constants