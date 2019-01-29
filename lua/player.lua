Player = {}

function Player:Load()
    self.x = 0
    self.y = 0
    self.img = Image["player"]

    self.canMove = true
    self.delayMove = .1
end

function Player:Key(k)
    if not self.canMove or Map.MapEdit then return end
    if k == "z" and Map.levels[Map.curMap][self.y+1-1] and not BlockMapID[Map.levels[Map.curMap][self.y+1-1][self.x+1]] then
        self.y = self.y - 1
        self.canMove = false
        Timer:Add(self.delayMove, function() self.canMove = true end)
        Bot:UpdateMove()
        Bot:UpdateBattle()
    elseif k == "s" and Map.levels[Map.curMap][self.y+1+1] and not BlockMapID[Map.levels[Map.curMap][self.y+1+1][self.x+1]] then
        self.y = self.y + 1
        self.canMove = false
        Timer:Add(self.delayMove, function() self.canMove = true end)
        Bot:UpdateMove()
        Bot:UpdateBattle()
    elseif k == "q" and Map.levels[Map.curMap][self.y+1] and Map.levels[Map.curMap][self.y+1][self.x+1-1] and not BlockMapID[Map.levels[Map.curMap][self.y+1][self.x+1-1]] then
        self.x = self.x - 1
        self.canMove = false
        Timer:Add(self.delayMove, function() self.canMove = true end)
        Bot:UpdateMove()
        Bot:UpdateBattle()
    elseif k == "d" and Map.levels[Map.curMap][self.y+1] and Map.levels[Map.curMap][self.y+1][self.x+1+1] and not BlockMapID[Map.levels[Map.curMap][self.y+1][self.x+1+1]] then
        self.x = self.x + 1
        self.canMove = false
        Timer:Add(self.delayMove, function() self.canMove = true end)
        Bot:UpdateMove()
        Bot:UpdateBattle()
    end
end

function Player:Update(dt)

end

function Player:Draw()
    love.graphics.draw(self.img, self.x*32, self.y*32, 0, 2, 2)
end