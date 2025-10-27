helper = require("helpers")

local Mage = {}
Mage.__index = Mage



function Mage:New(character)

    self = setmetatable({},Mage)
    self.name = "Mage"
    self.baseDamage = 1
    self.baseArmor = 0
    self.speed = 4
    self.character = character
    self.isEnemy = false

    -- ability parameters ----------
    self.abilities = {
        {
            name = "Attack",
            func = self.Attack,
        },
        {
            name = "Fireball",
            func = self.Fireball,
        },
        {
            name = "Heal",
            func = self.Heal,
        },
    }
    return self
end



function Mage:Attack(target)

    local attackDamage = self.baseDamage + self.character.weapon.damage
    local targetArmor = target.job.baseArmor -- + armorrating eventually
    local finalDamage = attackDamage - targetArmor

    target.hp = target.hp - finalDamage

    helper.attackFb(self.character,target,finalDamage)
end



function Mage:Fireball(target)
    local dmg = 0
    if self.character.weapon.name == "Staff" then dmg = 12 else dmg = 3 end
    target.hp = target.hp - dmg
    helper.attackFb(self.character,target,dmg,{spellName = "Fireball"})
end



function Mage:Heal(target)
    local heal = 0
    if self.character.weapon.name == "Staff" then heal = 5 else heal = 2 end
    target.hp = target.hp + heal
    helper.attackFb(self.character,target,dmg,{spellName = "Fireball"})
end



return Mage