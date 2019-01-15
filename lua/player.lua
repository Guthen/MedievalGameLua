Player = {}

function Player:Load()
    self.x = 0
    self.y = 0
    self.img = Image["player"]
end

function Player:Key(k)
    if k == "z" then
        self.y = self.y - 1
    elseif k == "s" then
        self.y = self.y + 1
    elseif k == "q" then
        self.x = self.x - 1
    elseif k == "d" then
        self.x = self.x + 1
    end
end

function Player:Update(dt)

end

function Player:Draw()
    love.graphics.draw(self.img, self.x*16, self.y*16)
end