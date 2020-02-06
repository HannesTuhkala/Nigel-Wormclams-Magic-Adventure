local player = {}

player.width = 30
player.height = 30
player.name = "Nigel Wormclam"
player.health = 50
player.mana = 30

player.equipment = {}
player.equipment.slots = {"head", "chest", "legs", "boots", "l_hand", "r_hand"}
player.equipment.head = nil
player.equipment.chest = nil
player.equipment.legs = nil
player.equipment.boots = nil
player.equipment.r_hand = nil
player.equipment.l_hand = nil

player.attributes = {}
player.attributes.strength = 30
player.attributes.speed = 200
player.attributes.agility = 24
player.attributes.intellect = 14
player.attributes.charisma = 9
player.attributes.spirit = 16

-- Spawn position
player.x = 832
player.y = 1184

function player:equip(item)
    if item.is_wearable then
        self.equipment[item.type] = item
    end
end

return player
