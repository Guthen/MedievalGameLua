Town = {}
Town.towns = {}

function Town:Add(img, x, y, name)
	if img == nil then return error("Town:Add() : #1 argument is incorrect, take a valid image !") end
    table.insert(self.towns, {x = x, y = y, img = img, name = name})
end

function Town:Update(dt)
    if #self.towns == 0 then return end
end

function Town:Draw()
    if #self.towns == 0 then return end
    for _, v in pairs(self.towns) do 
    	Image:DrawOverheadText(v.name, v.x, v.y)
        love.graphics.draw(v.img, v.x*tilesetSize, v.y*tilesetSize, 0, tilesetSize/v.img:getWidth(), tilesetSize/v.img:getHeight())
    end
end

-- TOWNS CONSTRUCTIONS
function Town:Load()
	Town:Add(Image["slime_red"], 5, 5, "Janvier")
end