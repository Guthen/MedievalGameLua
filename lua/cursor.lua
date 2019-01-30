Cursor = {}

function Cursor:Load()
	self.x = 0
	self.y = 0
	self.img = Image["cursor"]
end

function Cursor:Update()
	self.x = math.floor(love.mouse.getX()/tilesetSize)*tilesetSize
	self.y = math.floor(love.mouse.getY()/tilesetSize)*tilesetSize

	if love.mouse.isDown(1) and Map.MapEdit then
        Map:GetCurMap()[self.y/tilesetSize+1][self.x/tilesetSize+1] = Map.MapEditIndex[Map.MapEditImg]
    elseif love.mouse.isDown(2) and Map.MapEdit then
        Map:GetCurMap()[self.y/tilesetSize+1][self.x/tilesetSize+1] = 0
    end
end

function Cursor:LeftClick()
    if not Map.MapEdit then
    	print(self.x/tilesetSize, self.y/tilesetSize)
    end
end

function Cursor:WheelMoved(x, y)
	if Map.MapEdit and x then
		if x > 0 then
			self.MapEditImg = self.MapEditImg + 1
            if self.MapEditImg > #self.MapEditIndex then self.MapEditImg = 1 end
		elseif x < 0 then
            self.MapEditImg = self.MapEditImg - 1
            if self.MapEditImg < 1 then self.MapEditImg = #self.MapEditIndex end		
		end
	end
end

function Cursor:RightClick()

end

function Cursor:Draw()
	love.graphics.draw(self.img, self.x, self.y, 0, tilesetSize/self.img:getWidth(), tilesetSize/self.img:getHeight())
end