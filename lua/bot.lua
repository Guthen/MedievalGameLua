Bot = {}
Bot.bots = {}

function Bot:Add(img, x, y, param)
	table.insert(self.bots, {img = img, x = x, y = y, param = param})
end

function Bot:UpdateMove()
	if #self.bots == 0 then return end
	for k,v in pairs(self.bots) do
		if not v.dest then self:SetDestination(k, love.math.random(-3, 3), love.math.random(-3, 3)) else
			if v.x < v.dest.x then v.x = v.x + 1 
			elseif v.x > v.dest.x then v.x = v.x - 1
			elseif v.y < v.dest.y then v.y = v.y + 1
			elseif v.y > v.dest.y then v.y = v.y - 1
			else v.dest = nil end
		end
	end
end

function Bot:SetDestination(botId, x, y)
	if not botId then return error(2, "Bot:SetDestination() : #1 argument must be number !") end
	if not x or not y then return error(2, "Bot:SetDestination() : #2 or #3 argument must be number !") end
	self.bots[botId].dest = {x = self.bots[botId].x+x, y = self.bots[botId].y+y}
end

function Bot:Draw()
	if #self.bots == 0 then return end
	for k,v in pairs(self.bots) do
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
	Bot:Add(Image["mage_obscur"], 9, 5, {name = "Hujalt", men = 20, faction = 1})
	Bot:Add(Image["mage_blanc"], 15, 19, {name = "Kaft", men = 45, faction = 2})
end