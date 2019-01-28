Bot = {}
Bot.bots = {}

function Bot:Add(img, x, y, param)
	table.insert(self.bots, {img = img, x = x, y = y, param = param})
end

function Bot:UpdateMove()
	if #self.bots == 0 then return end
	for k,v in pairs(self.bots) do
		if not v.dest then self:SetDestination(k, 0, 0) else
			if v.x < v.dest.x and Map.levels[Map.curMap][v.y+1+1] and Map.levels[Map.curMap][v.y+1+1][v.x+1+1] then v.x = v.x + 1 
			elseif v.x > v.dest.x and Map.levels[Map.curMap][v.y+1-1] and Map.levels[Map.curMap][v.y+1-1][v.x+1-1] then v.x = v.x - 1
			elseif v.y < v.dest.y and Map.levels[Map.curMap][v.y+1-1] then v.y = v.y - 1
			elseif v.y > v.dest.y and Map.levels[Map.curMap][v.y+1+1] then v.y = v.y + 1
			else v.dest = nil end
		end
	end
end

function Bot:SetDestination(botId, x, y)
	if not botId then return error(2, "Bot:SetDestination() : #1 argument must be number !") end
	if not x or not y then return error(2, "Bot:SetDestination() : #2 or #3 argument must be number !") end
	local bot = self.bots[botId]
	if x == 0 or y == 0 then
		for _,v in pairs(Town.towns) do
			for ke, _ in pairs(Faction:Get(bot.param.faction).enemy) do
				if ke == v.param.faction then
					x = v.x
					y = v.y
					print("Hey, "..x, y)
				end
			end
		end
	end
	if x == 0 and y == 0 then x = love.math.random(-3, 3) y = love.math.random(-3, 3) end
	bot.dest = {x = self.bots[botId].x+x, y = self.bots[botId].y+y}
end

function Bot:Draw()
	if #self.bots == 0 then return end
	for k,v in pairs(self.bots) do
		if v.param.map ~= Map.curMap then return end
		if v.param.faction then
			local clr = Faction:Get(v.param.faction).color
			love.graphics.setColor(clr.r, clr.g, clr.b)
		end
		if v.param.name then
			if not v.param.men then Image:DrawOverheadText(v.param.name, v.x, v.y) end
			Image:DrawOverheadText(v.param.name .. " + " .. v.param.men, v.x, v.y)
		end
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(v.img, v.x*tilesetSize, v.y*tilesetSize, 0, tilesetSize/v.img:getWidth(), tilesetSize/v.img:getHeight())
	end
end

function Bot:Load()
	Bot:Add(Image["mage_obscur"], 9, 5, {name = "Hujalt", men = 20, faction = 1, map = 0})
	Bot:Add(Image["mage_blanc"], 15, 19, {name = "Kaft", men = 45, faction = 2, map = 0})
end