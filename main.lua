io.stdout:setvbuf("no")

-- FONCTION POUR IMPORTER LES FICHIERS ".lua" D’UN DOSSIER
function RequireFolder(folder)
    if love.filesystem.getInfo(folder) then
        for _, v in pairs(love.filesystem.getDirectoryItems(folder)) do
            if not string.find(v, ".lua") then return end
            local n = string.gsub(v, ".lua", "")
            require(folder.."/"..n)
        end
    end
end

-- FONCTIONS PRINCIPALES LOVE

function love.load()
    w, h = 1280, 720
    title = "MedievalGame"
    mapSmooth = true
    tilesetSize = 32

    love.window.setMode(w, h)
    love.window.setTitle(title)
    love.graphics.setDefaultFilter("nearest")

    RequireFolder("lua")
    
    Image:Load()
    Map:Load()
    Town:Load()
    
    Player:Load()
    Cursor:Load()
end

function love.update(dt)
    Timer:Update(dt)
    Player:Update(dt)
    Cursor:Update()
    Town:Update()
end

function love.keypressed(k)
    Player:Key(k)
end

function love.draw()
    Map:Draw()
    Town:Draw()
    Player:Draw()
    Cursor:Draw()
end

