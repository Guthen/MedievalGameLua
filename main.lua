-- FONCTION POUR IMPORTER LES FICHIERS ".lua" D’UN DOSSIER
function RequireFolder(folder)
    if love.filesystem.getInfo(folder) then
        for _, v in pairs(love.filesystem.getDirectoryItems(folder)) do
            if not string.find(v, ".lua") then return end
            local n = string.gsub(v, ".lua", "")
            require(n)
        end
    end
end

function love.load()
    w, h = 1280, 720
    title = "MedievalGame"

    love.window.setMode(w, h)
    love.window.setTitle(title)
    RequireFolder("lua")
    
    Image:Load()
    Map:Load()
    Player:Load()
end

function love.update(dt)
    Player:Update(dt)
end

function love.keypressed(k)
    Player:Key(k)
end

function love.draw()
    Map:Draw()
    Player:Draw()
end

