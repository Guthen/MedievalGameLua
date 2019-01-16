Cursor = {}

function Cursor:Load()
	self.x = 0
	self.y = 0
	self.img = Image["cursor"]
end

function Cursor:Update()
	self.x = math.floor(love.mouse.getX()/tilesetSize)*tilesetSize
	self.y = math.floor(love.mouse.getY()/tilesetSize)*tilesetSize
end

function Cursor:Draw()
	love.graphics.draw(self.img, self.x, self.y, 0, tilesetSize/self.img:getWidth(), tilesetSize/self.img:getHeight())
end