-- METTRE UNE FONCTION ICI SI CETTE FONCTION PEUT-ETRE UTILISABLE DANS TOUS LES FICHIERS

function Toggle(bool)
    if not type(bool) == "boolean" then return error(2, "Toggle() : #1 argument must be boolean !") end
    if bool then bool = false else bool = true end
    return bool
end

function PrintTable(table)
	if not type(table) == "table" then return error(2, "PrintTable() : #1 argument must be table !") end
	print("{")
	for _,v in pairs(table) do
		if type(v) == "table" then
			local _t = ""  
			for _, _v in pairs(v) do
				if _t ~= "" then
					_t = _t ..", ".. _v
				else 
					_t = _v
				end
			end
			print("{".._t.."},")
		else
			print("	"..tostring(v))
		end
	end
	print("}")
end