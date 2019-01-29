Town = {}
Town.towns = {}

function Town:Add(img, x, y, param)
	if img == nil then return error("Town:Add() : #1 argument is incorrect, take a valid image !") end
    table.insert(self.towns, {x = x, y = y, img = img, param = param})
end

function Town:Update(dt)
    if #self.towns == 0 then return end
end

function Town:Draw()
    if #self.towns == 0 then return end
    for _, v in pairs(self.towns) do 
        if v.param.map.x == Map.curMapX and v.param.map.y == Map.curMapY then
    		if v.param.faction then
    			local clr = Faction:Get(v.param.faction).color
    			love.graphics.setColor(clr.r, clr.g, clr.b)
    		end
        	Image:DrawOverheadText(v.param.name, v.x, v.y)
        	love.graphics.setColor(1, 1, 1)
            love.graphics.draw(v.img, v.x*tilesetSize, v.y*tilesetSize, 0, tilesetSize/v.img:getWidth(), tilesetSize/v.img:getHeight())
        end
    end
end

-- TOWNS CONSTRUCTIONS
function Town:Load()
	Town:Add(Image["town_castle"], 5, 5, {name = "Cujult Castle", faction = 1, map = {x = 4, y = 1}})
	Town:Add(Image["town_castle"], 18, 12, {name = "Kalt Castle", faction = 2, map = {x = 4, y = 1}})
end