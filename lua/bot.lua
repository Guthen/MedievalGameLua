Bot = {}
Bot.bots = {}

function Bot:Add(img, x, y, param)
	table.insert(self.bots, {img = img, x = x, y = y, canMove = true, param = param})
end

function Bot:Go(botId, x, y)
	if not botId then return error(2, "Bot:Go() : #1 argument must be number !") end
	if not x or not y then return error(2, "Bot:Go() : #2 or #3 argument must be number !") end
	local bot = self.bots[botId]

	if bot.x < x and Map:GetCurMap()[bot.y+1+1] and Map:GetCurMap()[bot.y+1+1][bot.x+1+1] then bot.x = bot.x + 1 
	elseif bot.x > x and Map:GetCurMap()[bot.y+1-1] and Map:GetCurMap()[bot.y+1-1][bot.x+1-1] then bot.x = bot.x - 1
	elseif bot.y < y and Map:GetCurMap()[bot.y+1-1] then bot.y = bot.y + 1
	elseif bot.y > y and Map:GetCurMap()[bot.y+1+1] then bot.y = bot.y - 1 end

	if bot.x == x and bot.y == y then return false end

	return true
end

function Bot:UpdateMove()
	if #self.bots == 0 then return end
	for k,v in pairs(self.bots) do
		if not v.dest then self:SetDestination(k, -1, -1) elseif v.canMove and v.dest then
			
			-- DESTINATION ON THE DEST MAP --
			if v.mapDest then
				if not v.param.map.x == v.mapDest.x or not v.param.map.y == v.mapDest.y then
					print("hi")
					if v.dest.map.x < v.param.map.x then
						if not Bot:Go(k, 39, v.y) then
							v.param.map.x = v.param.map.x - 1 v.x = 0 
						end
					elseif v.dest.map.x > v.param.map.x then
						if not Bot:Go(k, 0, v.y) then 
							v.param.map.x = v.param.map.x + 1 v.x = 39 
						end
					elseif v.dest.map.y < v.param.map.y then
						if not Bot:Go(k, v.x, 0) then 
							v.param.map.y = v.param.map.y - 1 v.y = 21 
						end
					elseif v.dest.map.y > v.param.map.y then
						if not Bot:Go(k, v.x, 21) then 
							v.param.map.y = v.param.map.y + 1 v.y = 0 
						end
					end
				else
					v.mapDest = nil
				end
			-- DESTINATION ON THE CUR MAP --
			elseif v.dest then
				if not Bot:Go(k, v.dest.x, v.dest.y) then v.dest = nil end
			end

      	end
	end
end

function Bot:UpdateBattle()
	if #self.bots == 0 then return end
	for k, v in pairs(self.bots) do
	    for bk, bv in pairs(self.bots) do
	    	--print(k, bk)
	        if not bk == k then
	        	print(bv.x, bv.y, v.x, v.y)
		    	if bv.x == v.x and bv.y == v.y then
		    		print(v.param.faction .. " vs. " .. bv.param.faction)
		        	if not Faction:Get(v.param.faction).enemy[bv.param.faction] then return print("Are enemy : ", Faction:Get(v.param.faction).enemy[bv.param.faction]) end
		        	v.canMove = false
		            bv.canMove = false
		            print(v.name .. " is attacking " .. bv.name)
		        end
		    end
	    end
	end
end

function Bot:SetDestination(botId, x, y)
	if not botId then return error(2, "Bot:SetDestination() : #1 argument must be number !") end
	if not x or not y then return error(2, "Bot:SetDestination() : #2 or #3 argument must be number !") end
	local bot = self.bots[botId]
	if x == -1 or y == -1 then
		for _,v in pairs(Town.towns) do
			for ke, _ in pairs(Faction:Get(bot.param.faction).enemy) do
				if ke == v.param.faction then
					x = v.x
					y = v.y
					mapX = v.param.map.x
					mapY = v.param.map.y
					print(bot.param.name.." go to : "..x.."; "..y.." on the Map("..mapX.."; "..mapY..").")
				end
			end
		end
	end
	if x == -1 and y == -1 then x = love.math.random(-3, 3) y = love.math.random(-3, 3) end

	bot.dest = {x = x, y = y}
	self:SetMapDestination(botId, mapX, mapY)
end

function Bot:SetMapDestination(botId, x, y)
	if not botId then return error(2, "Bot:SetMapDestination() : #1 argument must be number !") end
	if not x or not y then return error(2, "Bot:SetMapDestination() : #2 or #3 argument must be number !") end
	if x < 0 or y < 0 then return error(2, "Bot:SetMapDestination() : x and y must be greater than 0 !") end

	local bot = self.bots[botId]	
	if bot.param.mapX == x and bot.param.mapY == y then return end

	bot.mapDest = {x = x, y = y}
end

function Bot:Draw()
	if #self.bots == 0 then return end
	for k,v in pairs(self.bots) do
		if v.param.map.x == Map.curMapX and v.param.map.y == Map.curMapY then
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
end

function Bot:Load()
	Bot:Add(Image["wizard_black"], 11, 8, {name = "Kulfalt", men = 115, faction = 1, map = {x = 3, y = 1}})
	Bot:Add(Image["wizard_black"], 9, 5, {name = "Hujalt", men = 20, faction = 1, map = {x = 4, y = 1}})
	Bot:Add(Image["wizard_white"], 15, 19, {name = "Kaft", men = 45, faction = 2, map = {x = 4, y = 1}})
end
