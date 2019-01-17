Bot = {}
Bot.bots = {}

function Bot:Add(img, x, y, param)
	table.insert(self.bots, {img = img, x = x, y = y, param = param})
end

function Bot:Update(dt)
	if #self.bots == 0 then return end
	for k,v in pairs(self.bots) do

	end
end

function Bot:Draw()
	if #self.bots == 0 then return end
	for k,v in pairs(self.bots) do
		if v.param.name then
			if not v.param.men then Image:DrawOverheadText(v.param.name, v.x, v.y) end
			Image:DrawOverheadText(v.param.name .. " + " .. v.param.men, v.x, v.y)
		end
		love.graphics.draw(v.img, v.x*tilesetSize, v.y*tilesetSize, 0, tilesetSize/v.img:getWidth(), tilesetSize/v.img:getHeight())
	end
end

function Bot:Load()
	Bot:Add(Image["mage_obscur"], 9, 5, {name = "Hujalt", men = 20, faction = 1})
end