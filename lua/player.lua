Player = {}

function Player:Load()
    self.x = 0
    self.y = 0
    self.img = love.graphics.newImage("")
end

function Player:Update(dt)

end

function Player:Draw()
    love.graphics.draw(self.img, self.x, self.y)
end