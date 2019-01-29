Faction = {}
Faction.factions = {}

--[[-------------------------------------------------------------------------
	FACTIONS ADD/GET
---------------------------------------------------------------------------]]

function Faction:Get(facId)
	return Faction.factions[facId]
end

function Faction:Add(facId, param)
	if not type(param) == "table" then return error(2, "Faction:Add() : #2 argument must be table !") end
	Faction.factions[facId] = param
end

--[[-------------------------------------------------------------------------
	FACTIONS RELATIONS
---------------------------------------------------------------------------]]

function Faction:Ally(facId1, facId2)
	Faction.factions[facId1].ally[facId2] = true 
	Faction.factions[facId2].ally[facId1] = true 
end

function Faction:Neutral(facId1, facId2)
	Faction.factions[facId1].enemy[facId2] = false 
	Faction.factions[facId2].enemy[facId1] = false 
	Faction.factions[facId1].ally[facId2] = false 
	Faction.factions[facId2].ally[facId1] = false 
end

function Faction:Enemy(facId1, facId2)
	Faction.factions[facId1].enemy[facId2] = true 
	Faction.factions[facId2].enemy[facId1] = true 
end

--[[-------------------------------------------------------------------------
---------------------------------------------------------------------------]]

function Faction:Load()
	self:Add(0, {name = "Neutral", enemy = {}, ally = {}, color = {r = 1, g = 1, b = 1}})
	self:Add(1, {name = "Ferult Empirult", enemy = {}, ally = {}, color = {r = 1, g = 0, b = 0}})
	self:Add(2, {name = "Gafalt Empiralt", enemy = {}, ally = {}, color = {r = 0, g = 0.98, b = 0.95}})
end
