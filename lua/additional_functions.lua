-- METTRE UNE FONCTION ICI SI CETTE FONCTION PEUT-ETRE UTILISABLE DANS TOUS LES FICHIERS

function Toggle(bool)
    if not type(bool) == "boolean" then return error(2, "Toggle() : #1 argument must be boolean !") end
    if bool then bool = false else bool = true end
end