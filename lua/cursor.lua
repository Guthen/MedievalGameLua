Cursor = {}

function Cursor:Load()
	self.x = 0
	self.y = 0
	self.img = Image["cursor"]
end

function Cursor:Update()
	self.x = math.floor(love.mouse.getX()/32)*32
	self.y = math.floor(love.mouse.getY()/32)*32
end

function Cursor:Draw()
	love.graphics.draw(self.img, self.x, self.y, 0, 2, 2)
end