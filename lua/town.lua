Town = {}
Town.towns = {}

function Town:Add(img, x, y, name)
    table.insert(self.towns, {x = x, y = y, img = Image[img], name = name})
end

function Town:Update(dt)
    if #self.towns == 0 then return end
end

function Town:Draw()
    if #self.towns == 0 then return end
    for _, v in pairs(self.towns) do 
        love.graphics.draw(v.img, v.x, v.y)
    end
end