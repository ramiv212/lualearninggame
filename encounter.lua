Helpers = require("helpers")

-- Logic Functions ---------------------------------------------------------------

local function sortEncounterCharactersBySpeed(encounterTable)
    table.sort(encounterTable,function (a, b)
        return a.job.speed > b.job.speed
    end)

    -- for _, character in ipairs(encounterTable) do
    --     print(character.name)
    -- end
end



local function  addPartyCharactersToEncounter(playerParty,enemyParty)
    local encounterCharacterTable = {}
    -- add party characters
    for i, character in ipairs(playerParty) do
        table.insert(encounterCharacterTable,character)
    end

    -- add enemy characters
    for i, character in ipairs(enemyParty) do
        table.insert(encounterCharacterTable,character)
    end

    sortEncounterCharactersBySpeed(encounterCharacterTable)

    return encounterCharacterTable
end



local function getActiveCharactersOpposingParty(activeCharacter,playerParty,enemyParty)
    if activeCharacter.job.isEnemy then return playerParty
    else return enemyParty end
end



local function checkIfCharacterDeath(character,playerParty,enemyParty,encounterTable)
    if character.hp < 1 then
        local deadCharacterIdx = Helpers.getCharacterIndex(encounterTable,character)
        table.remove(encounterTable,deadCharacterIdx)

        if not character.job.isEnemy then
            local deadCharacterIdx = Helpers.getCharacterIndex(playerParty,character)
            table.remove(playerParty,deadCharacterIdx)
        end
        if character.job.isEnemy then
            local deadCharacterIdx = Helpers.getCharacterIndex(enemyParty,character)
            table.remove(enemyParty,deadCharacterIdx)
        end

        print(character.name .. " has been killed!")
    end
end



-- enemy will pick a random character from the playerParty and attack
-- TODO add enemy picking a random ability
local function enemyTurn(actingCharacter,playerParty,enemyParty,encounterTable)
    local opposingParty = getActiveCharactersOpposingParty(actingCharacter,playerParty,enemyParty)

    local actingCharactersTargetIndex = math.random(#opposingParty) -- actingCharacter will pick a random enemy from its opposing party
    local actingCharacterAttackTarget = opposingParty[actingCharactersTargetIndex]
    actingCharacter:Attack(actingCharacterAttackTarget)

    checkIfCharacterDeath(actingCharacterAttackTarget,playerParty,enemyParty,encounterTable)
end



local function playerPicksAbility(actingCharacter)
    print("Which ability will " .. actingCharacter.name .. " use?")

    local counter = 1

    for name, _ in pairs(actingCharacter.job.abilities) do
        print(counter .. ": " .. name)
        counter = counter + 1
    end

    local playerChoice = tonumber(io.read())
    local playerChoice = Helpers.validatePlayerNumberInput(playerChoice,actingCharacter.job.abilities)

    print(playerChoice)

    -- if there is a choice, and that choice is a number, and that choice is not larger than the number of abilities
    if not playerChoice then return playerPicksAbility(actingCharacter)
    
    else return actingCharacter.job.abilities[playerChoice] end

    print("\n")
end



local function playerPicksTarget(activeCharacter,playerParty,enemyParty)
    print("Which character will " .. activeCharacter.name .. " attack?")

    local opposingParty = getActiveCharactersOpposingParty(activeCharacter,playerParty,enemyParty)

    for i,enemy in ipairs(opposingParty) do
        print(i .. ": " .. enemy.name)
    end

    print("Enter the number of the enemy you want to attack: ")
    local playerChoice = tonumber(io.read())
    local playerChoice = Helpers.validatePlayerNumberInput(playerChoice,opposingParty)

    -- if there is a choice, and that choice is a number, and that choice is not larger than the number of enemies
    if not playerChoice then return playerPicksTarget(activeCharacter,opposingParty,enemyParty)
    else return playerChoice end
end



local function playerTurn(actingCharacter,playerParty,enemyParty,encounterTable)
    local opposingParty = getActiveCharactersOpposingParty(actingCharacter,playerParty,enemyParty)

    local playerPickedAbility = playerPicksAbility(actingCharacter)
    local playerTargetIndex = playerPicksTarget(actingCharacter,playerParty,enemyParty)

    local actingCharacterAttackTarget = opposingParty[playerTargetIndex]

    -- use picked ability on picked target
    playerPickedAbility(actingCharacterAttackTarget)

    checkIfCharacterDeath(actingCharacterAttackTarget,playerParty,enemyParty,encounterTable)
end



local function incrementActiveCharacterIndex(encounterTable,activeCharacterIndex)
    if #encounterTable < activeCharacterIndex then return 1
    else return activeCharacterIndex + 1 end
end



-- Encounter Class -----------------------------------------------------------------

local Encounter = {}
Encounter.__index = Encounter

function Encounter:New(playerParty,enemyParty)

    self = setmetatable(self,Encounter)

    self.playerParty = playerParty
    self.enemyParty = enemyParty
    self.encounterTable = addPartyCharactersToEncounter(playerParty,enemyParty)
    self.turnNumber = 1
    self.activeCharacterIndex = 1

end



function Encounter:Turn()
    local actingCharacter = self.encounterTable[self.activeCharacterIndex]

    print("\n" .. actingCharacter.name .. "'s turn!")

    if actingCharacter.job.isEnemy then
        enemyTurn(actingCharacter,self.playerParty,self.enemyParty,self.encounterTable)
    else
        playerTurn(actingCharacter,self.playerParty,self.enemyParty,self.encounterTable)
    end

    Helpers.printCharacterNames(self.encounterTable)

    self.turnNumber = self.turnNumber + 1
    self.activeCharacterIndex = incrementActiveCharacterIndex(self.encounterTable,self.activeCharacterIndex) -- if the last character has taken their turn, loop back to the first character
end



return Encounter


