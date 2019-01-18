Player = {}

function Player:Load()
    self.x = 0
    self.y = 0
    self.img = Image["player"]

    self.canMove = true
    self.delayMove = .1
end

function Player:Key(k)
    if not self.canMove then return end
    if k == "z" and self.levels[self.curMap][self.y+1-1] and not BlockMapID[self.levels[self.curMap][self.y+1-1][self.x+1]] then
        self.y = self.y - 1
        self.canMove = false
        Timer:Add(self.delayMove, function() self.canMove = true end)
        Bot:UpdateMove()
    elseif k == "s" and self.levels[self.curMap][self.y+1+1] and not BlockMapID[self.levels[self.curMap][self.y+1+1][self.x+1]] then
        self.y = self.y + 1
        self.canMove = false
        Timer:Add(self.delayMove, function() self.canMove = true end)
        Bot:UpdateMove()
    elseif k == "q" and self.levels[self.curMap][self.y+1] and not BlockMapID[self.levels[self.curMap][self.y+1][self.x+1-1]] then
        self.x = self.x - 1
        self.canMove = false
        Timer:Add(self.delayMove, function() self.canMove = true end)
        Bot:UpdateMove()
    elseif k == "d" and self.levels[self.curMap][self.y+1] and not BlockMapID[self.levels[self.curMap][self.y+1][self.x+1+1]] then
        self.x = self.x + 1
        self.canMove = false
        Timer:Add(self.delayMove, function() self.canMove = true end)
        Bot:UpdateMove()
    end
end

function Player:Update(dt)

end

function Player:Draw()
    love.graphics.draw(self.img, self.x*32, self.y*32, 0, 2, 2)
end