helper = require("helpers")


local goblin = {
	name = "Goblin",
	hp = 15,
	baseDamage = 6,
	baseArmor = 2,
	speed = 6,
	weaponName = "Club",
	isEnemy = true,
}

local wolf = {
	name = "Wolf",
	hp = 10,
	baseDamage = 8,
	baseArmor = 0,
	speed = 13,
	weaponName = "Claw",
	isEnemy = true,
}



-- MONSTER CLASS

local Monster = {}
Monster.__index = Monster



function Monster:New(monsterJob,monsterName)


	local monsterList = {
		goblin = goblin,
		wolf = wolf,
	}


    self = setmetatable({},Monster)
    self.name = monsterName
    self.hp = monsterList[monsterJob]['hp']
    self.job = monsterList[monsterJob]
    self.weapon = {
    	name = monsterList[monsterJob]['weaponName']
    }

    return self
end



function Monster:Identify()
	print(string.format('A wild %s appeared! It has %d HP, does %d damage and has %d armor',self.name,self.hp,self.job.baseDamage,self.job.baseArmor))
end



function Monster:Attack(target)

    local attackDamage = self.job.baseDamage
    local targetArmor = target.job.baseArmor -- + armorrating eventually
    local finalDamage = attackDamage - targetArmor

    target.hp = target.hp - finalDamage

    helper.attackFb(self,target,finalDamage)
end



return Monster

