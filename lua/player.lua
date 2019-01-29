Player = {}

function Player:Load()
    self.x = 0
    self.y = 0
    self.img = Image["player"]

    self.name = "Kylus"
    self.faction = 0

    self.canMove = true
    self.delayMove = .1
end

function Player:Key(k)
    if not self.canMove or Map.MapEdit then return end
    if k == "z" then
        if Map:GetCurMap()[self.y+1-1] and not BlockMapID[Map:GetCurMap()[self.y+1-1][self.x+1]] then
            self.y = self.y - 1
            self.canMove = false
            Timer:Add(self.delayMove, function() self.canMove = true end)
            Bot:UpdateMove()
            Bot:UpdateBattle()
        elseif Map:GetCurMap()[self.y+1-1] and not Map:GetCurMap()[self.y+1-1][self.x+1] and Map.Map[Map.curMapY-1][Map.curMapX] then
            Map.curMapX = Map.curMapY - 1
            self.y = 21
        end
    elseif k == "s" then
        if Map:GetCurMap()[self.y+1+1] and not BlockMapID[Map:GetCurMap()[self.y+1+1][self.x+1]] then
            self.y = self.y + 1
            self.canMove = false
            Timer:Add(self.delayMove, function() self.canMove = true end)
            Bot:UpdateMove()
            Bot:UpdateBattle()
        elseif Map:GetCurMap()[self.y+1+1] and not Map:GetCurMap()[self.y+1+1][self.x+1] and Map.Map[Map.curMapY+1][Map.curMapX] then
            Map.curMapX = Map.curMapY + 1
            self.y = 0
        end
    elseif k == "q" then
        if Map:GetCurMap()[self.y+1] and Map:GetCurMap()[self.y+1][self.x+1-1] and not BlockMapID[Map:GetCurMap()[self.y+1][self.x+1-1]] then
            self.x = self.x - 1
            self.canMove = false
            Timer:Add(self.delayMove, function() self.canMove = true end)
            Bot:UpdateMove()
            Bot:UpdateBattle()
        elseif Map:GetCurMap()[self.y+1] and not Map:GetCurMap()[self.y+1][self.x+1-1] and Map.Map[Map.curMapY][Map.curMapX-1] then
            Map.curMapX = Map.curMapX - 1
            self.x = 39
        end
    elseif k == "d" then
        if Map:GetCurMap()[self.y+1] and Map:GetCurMap()[self.y+1][self.x+1+1] and not BlockMapID[Map:GetCurMap()[self.y+1][self.x+1+1]] then
            self.x = self.x + 1
            self.canMove = false
            Timer:Add(self.delayMove, function() self.canMove = true end)
            Bot:UpdateMove()
            Bot:UpdateBattle()
        elseif Map:GetCurMap()[self.y+1] and not Map:GetCurMap()[self.y+1][self.x+1+1] and Map.Map[Map.curMapY][Map.curMapX+1] then
            Map.curMapX = Map.curMapX + 1
            self.x = 0
        end
    end
end

function Player:Update(dt)

end

function Player:Draw()
    love.graphics.draw(self.img, self.x*32, self.y*32, 0, 2, 2)

    local clr = Faction:Get(self.faction).color
    love.graphics.setColor(clr.r, clr.g, clr.b)
        Image:DrawOverheadText(self.name, self.x, self.y)
    love.graphics.setColor(1, 1, 1)
end