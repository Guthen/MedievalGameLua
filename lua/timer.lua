Timer = {}
Timer.timers = {}

function Timer:Add(s, func)
    if not s or type(s) ~= "number" then return error(2, "Timer:Add() : #1 argument must be a number !") end
    if not func or type(func) ~= "function" then return error(2, "Timer:Add() : #2 argument must be a function !") end
    table.insert(self.timers, {s = s, func = func})
end

function Timer:Update(dt)
    if not dt then return error(2, "Timer:Update() : #1 argument needed, use deltaTime !") end
    if #Timer.timers == 0 then return end
    for k, v in pairs(Timer.timers) do
        if v.s > 0 then s = s - dt else
            v.func()
        end
    end
end