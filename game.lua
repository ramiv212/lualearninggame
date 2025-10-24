Character = require("characters")
Weapons = require("weapons")
Armor = require("armor")
Encounter = require("encounter")


-- Jobs
Warrior = require("warrior")
Mage = require("mage")


-- Monsters
Monster = require("monsters")



-- init characters
local warriorJohn = Character:New("John",25)
local mageJames = Character:New("James",20)
local playerParty = {warriorJohn,mageJames}


warriorJohn.job = Warrior:New(warriorJohn)
mageJames.job = Mage:New(mageJames)



-- init monsters
local goblin1 = Monster:New("goblin","Goblin 1")
local goblin2 = Monster:New("goblin","Goblin 2")
local wolf1 = Monster:New("wolf","Wolf 1")
local wolf2 = Monster:New("wolf","Wolf 2")

goblin1:Identify()
goblin2:Identify()
wolf1:Identify()
wolf2:Identify()

local enemyParty = {goblin1,goblin2,wolf1,wolf2}


-- give them weapons
warriorJohn.weapon = Weapons.shortSword
mageJames.weapon = Weapons.staff


warriorJohn:Identify()
mageJames:Identify()


-- warriorJohn:Attack(goblin1)
-- mageJames.job:Fireball(wolf1)

-- goblin1:Attack(warriorJohn)
-- wolf1:Attack(mageJames)



Encounter:New(playerParty,enemyParty)
Encounter:Turn()
Encounter:Turn()
Encounter:Turn()
Encounter:Turn()
Encounter:Turn()












