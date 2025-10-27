

local function attackFb(character,target,finalDamage,...)

	args = {...}

	-- if args include the attack spell name, replace a weapon name with the attack spell name
	spellName = nil

	for i=1,#args do
		if args[i]['spellName'] then spellName = args[i]['spellName'] end
	end


	local fb = {
        "\n",
        character.name,
        " attacks ",
        target.name,
        " with a ",
        spellName or character.weapon.name,
        " for ",
        finalDamage,
        " points of damage! ",
        target.name,
        " has ",
        target.hp,
        " HP left!"
    }

    print(table.concat(fb))

end



local function healFb(character,target,finalDamage,...)

	args = {...}

	-- if args include the attack spell name, replace a weapon name with the attack spell name
	spellName = nil

	for i=1,#args do
		if args[i]['spellName'] then spellName = args[i]['spellName'] end
	end


	local fb = {
        "\n",
        character.name,
        " attacks ",
        target.name,
        " with a ",
        spellName or character.weapon.name,
        " for ",
        finalDamage,
        " points of damage! ",
        target.name,
        " has ",
        target.hp,
        " HP left!"
    }

    print(table.concat(fb))

end



local function getCharacterIndex(table,character)
    for i, tblCharacter in ipairs(table) do
        if tblCharacter.name == character.name then return i end
    end
end


local function printCharacterNames(table)
    for index, value in ipairs(table) do
        print(index,value.name)
    end
end


local function validatePlayerNumberInput(playerChoiceNumber,choiceTableLength)

    if playerChoiceNumber and
        type(playerChoiceNumber) == "number" and
        playerChoiceNumber <= choiceTableLength then
        return playerChoiceNumber
    else
        return nil
    end
end


return {
	attackFb = attackFb,
	healFb = healFb,
    getCharacterIndex = getCharacterIndex,
    printCharacterNames = printCharacterNames,
    validatePlayerNumberInput = validatePlayerNumberInput,
}


