Player = {}

function Player:Load()
    self.x = 0
    self.y = 0
    self.img = Image["player"]

    self.BlockMapID = 
    {
        [0] = false,
        [1] = true,
        [2] = true,
        [3] = true,
        [4] = false,
        [5] = false,
        [6] = true,
    }
end

function Player:Key(k)
    if k == "z" and Map[self.y+1-1] and not self.BlockMapID[Map[self.y+1-1][self.x+1]] then
        self.y = self.y - 1
    elseif k == "s" and Map[self.y+1+1] and not self.BlockMapID[Map[self.y+1+1][self.x+1]] then
        self.y = self.y + 1
    elseif k == "q" and Map[self.y+1] and not self.BlockMapID[Map[self.y+1][self.x+1-1]] then
        self.x = self.x - 1
    elseif k == "d" and Map[self.y+1] and not self.BlockMapID[Map[self.y+1][self.x+1+1]] then
        self.x = self.x + 1
    end
end

function Player:Update(dt)

end

function Player:Draw()
    love.graphics.draw(self.img, self.x*16, self.y*16)
end