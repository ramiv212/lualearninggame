helper = require("helpers")

local Warrior = {}
Warrior.__index = Warrior



function Warrior:New(character)

    self = setmetatable({},Warrior)
    self.name = "Warrior"
    self.baseDamage = 8
    self.baseArmor = 2
    self.speed = 10
    self.character = character
    self.isEnemy = false

    
    -- ability parameters --------
    self.abilities = {
        {
            name = "Attack",
            func = self.Attack
        },
        {
            name = "Defend",
            func = self.Defend
        }
    }
    self.turnTimerDiff = 0

    return self
end



function Warrior:Attack(target)

    local attackDamage = self.baseDamage + self.character.weapon.damage
    local targetArmor = target.job.baseArmor -- + armorrating eventually
    local finalDamage = attackDamage - targetArmor

    target.hp = target.hp - finalDamage

    helper.attackFb(self.character,target,finalDamage)
end


function Warrior:Defend(turnNumber)
    if turnNumber == self.turnTimerDiff + 1 then
        self.baseArmor = self.baseArmor + -4
        print(self.character.name .. " has stopped defending!")
    else
        self.turnTimerDiff = turnNumber
        self.baseArmor = self.baseArmor + 4
        print(self.character.name .. " has started defending!")
    end
end


return Warrior