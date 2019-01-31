Map = {}
Map.levels = {}

--[[-------------------------------------------------------------------------
    MAP FUNCTIONS
---------------------------------------------------------------------------]]

function Map:MapSmooth() 
    if not mapSmooth then return end
    for y, yv in pairs(Map:GetCurMap()) do
        if type(yv) == "table" then
            for x, xv in pairs(yv) do

                -- CLIFF SMOOTH
                if xv == 1 then
                    if Map:GetCurMap()[y][x+1] == 0 and Map:GetCurMap()[y+1][x+1] == 0 then -- si à droite == 0 et en bas à droite == 0
                        self.Map[self.curMapY][self.curMapX][y][x] = 2 -- mettre coin droit
                    end
                    if Map:GetCurMap()[y][x-1] == 0 and Map:GetCurMap()[y+1][x-1] == 0 then -- si à gauche == 0 et en bas à gauche == 0
                        self.Map[self.curMapY][self.curMapX][y][x] = 3 -- mettre coin gauche
                    end
                    if Map:GetCurMap()[y][x+1] == 0 and Map:GetCurMap()[y+1][x+1] == 1 then 
                        self.Map[self.curMapY][self.curMapX][y][x+1] = 5
                    end
                    if Map:GetCurMap()[y][x-1] == 0 and Map:GetCurMap()[y+1][x-1] == 1 then
                        self.Map[self.curMapY][self.curMapX][y][x-1] = 4
                    end

                    if Map:GetCurMap()[y][x+1] == 2 or Map:GetCurMap()[y][x+1] == 3 and Map:GetCurMap()[y][x+2] == 1 then
                        self.Map[self.curMapY][self.curMapX][y][x+1] = 1
                    elseif Map:GetCurMap()[y][x-1] == 2 or Map:GetCurMap()[y][x-1] == 3 and Map:GetCurMap()[y][x-2] == 1 then
                        self.Map[self.curMapY][self.curMapX][y][x-1] = 1
                    end
                end
				
				-- LAVA SMOOTH
				if xv == 23 then
					if Map:GetCurMap()[y] and Map:GetCurMap()[y][x+1] == 20 and 
					   Map:GetCurMap()[y][x-1] == 20 and 
					   Map:GetCurMap()[y-1] and Map:GetCurMap()[y-1][x] == 20 and 
					   Map:GetCurMap()[y+1][x] == 20 then
						self.Map[self.curMapY][self.curMapX][y][x] = 32
					elseif Map:GetCurMap()[y] and (Map:GetCurMap()[y][x+1] == 23 or Map:GetCurMap()[y][x-1] == 22) and
					   (Map:GetCurMap()[y][x-1] == 23 or Map:GetCurMap()[y][x-1] == 22) and
					   Map:GetCurMap()[y-1] and Map:GetCurMap()[y-1][x] == 20 and
					   Map:GetCurMap()[y+1] and Map:GetCurMap()[y+1][x] == 20 then
						self.Map[self.curMapY][self.curMapX][y][x] = 22
					elseif Map:GetCurMap()[y-1] and (Map:GetCurMap()[y-1][x] == 23 or Map:GetCurMap()[y-1][x] == 21) and
					   Map:GetCurMap()[y+1] and (Map:GetCurMap()[y-1][x] == 23 or Map:GetCurMap()[y-1][x] == 21) and
					   Map:GetCurMap()[y][x] and Map:GetCurMap()[y][x-1] == 20 and
					   Map:GetCurMap()[y][x] and Map:GetCurMap()[y][x+1] == 20 then
						self.Map[self.curMapY][self.curMapX][y][x] = 21					
					end
				end

            end
        end
    end
end

function Map:GetCurMap()
    return self.Map[self.curMapY][self.curMapX]
end

function Map:ImportMaps()
	if love.filesystem.getInfo("maps") then
        for _,v in pairs(love.filesystem.getDirectoryItems("maps")) do
            if not string.find(v, ".lua") then return end 
			local n = string.gsub(v, ".lua", "")
            self.levels[n] = require("maps/"..n)
        end
    end
end

--[[-------------------------------------------------------------------------
---------------------------------------------------------------------------]]

function Map:Load()
	Map:ImportMaps()
    MapImg = 
    {
      -- TERRAIN HUMAIN --
      [0] = Image["terrain_grass"],
      [1] = Image["terrain_cliff"],
      [2] = Image["terrain_cliff_right_end"],
      [3] = Image["terrain_cliff_left_end"],
      [4] = Image["terrain_cliff_right"],
      [5] = Image["terrain_cliff_left"],
      [6] = Image["terrain_water"],
      [7] = Image["terrain_water_bridge_vertical"],
      [8] = Image["terrain_water_bridge_horizontal"],

      -- TERRAIN DEMON --
      [20] = Image["terrain_demon_grass"],
      [21] = Image["terrain_demon_lava_vertical"],
      [22] = Image["terrain_demon_lava_horizontal"],
      [23] = Image["terrain_demon_lava"],
	  [24] = Image["terrain_demon_lava_corner_upL"],
	  [25] = Image["terrain_demon_lava_corner_upR"],
	  [26] = Image["terrain_demon_lava_corner_downL"],
	  [27] = Image["terrain_demon_lava_corner_downR"],
	  [28] = Image["terrain_demon_lava_fill_up"],
	  [29] = Image["terrain_demon_lava_fill_down"],
	  [30] = Image["terrain_demon_lava_fill_right"],
	  [31] = Image["terrain_demon_lava_fill_left"],
	  [32] = Image["terrain_demon_lava_alone"],
    }
    BlockMapID = 
    {
        [0] = false,
        [1] = true,
        [2] = true,
        [3] = true,
        [4] = false,
        [5] = false,
        [6] = true,
        [7] = false,
        [8] = false,
		
		[20] = false,
        [21] = true,
        [22] = true,
        [23] = true,
		[24] = true,
        [25] = true,
        [26] = true,
		[27] = true,
        [28] = true,
        [29] = true,
		[30] = true,
        [31] = true,
        [32] = true,
    }
    self.MapEditImg = 1
    self.MapEdit = false
    self.MapEditIndex = {}
    for k = 1, 40 do
        if MapImg[k] then
          table.insert(self.MapEditIndex, k)
        end
    end

    self.curMapX = 4
    self.curMapY = 1

    self.Map = 
    {
      [1] = {self.levels["map_01"], self.levels["map_02"], self.levels["map_03"], self.levels["map_04"],},
    }

    -- AUTO SMOOTHING
    self:MapSmooth()
end

function Map:Key(k)
    if k == "m" then
        self.MapEdit = Toggle(self.MapEdit)
        if self.MapEdit == false then Map:MapSmooth() PrintTable(Map:GetCurMap()) end
    end
    if self.MapEdit then
        if k == "r" then
            for y,yv in pairs(Map:GetCurMap()) do
                for x,xv in pairs(yv) do
                    if xv ~= 0 then Map:GetCurMap()[y][x] = 0 end
                end
            end
        end
        if k == "right" then
            self.MapEditImg = self.MapEditImg + 1
            if self.MapEditImg > #self.MapEditIndex then self.MapEditImg = 1 end
        elseif k == "left" then
            self.MapEditImg = self.MapEditImg - 1
            if self.MapEditImg < 1 then self.MapEditImg = #self.MapEditIndex end
        end
	  end
end

function Map:Draw()
    for y, yv in pairs(Map:GetCurMap()) do
        if type(yv) == "table" then
           for x, xv in pairs(yv) do
                love.graphics.draw(MapImg[xv], (x-1)*tilesetSize, (y-1)*tilesetSize, 0, tilesetSize/MapImg[xv]:getWidth(), tilesetSize/MapImg[xv]:getHeight())
            end
        end
    end
    if self.MapEdit then
        love.graphics.print("[M] Map Editor : ", 0, 0)
        love.graphics.print("[R] Reset Map : ", 0, 15)
        love.graphics.print("Left Arrow : -1 | Right Arrow : +1", 0, 30)
        love.graphics.print("Current ID : "..self.MapEditIndex[self.MapEditImg], 0, 45)
    end
end

