

local Character = {}
Character.__index = Character



function Character:New(name,hp)
    local self = setmetatable({},Character)

    self.name = name
    self.hp = hp
    self.job = nil
    self.weapon = nil
    self.armor = {
        head = nil,
        body = nil,
        legs = nil,
        shoes = nil
    }

    return self
end



function Character:Identify()
    local str = string.format("My name is %s, I am a %s and I have %d HP.",self.name,self.job.name,self.hp)
    print(str)
end



function Character:Attack(target)
    self.job:Attack(target)
end


return Character