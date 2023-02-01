local mult = 0.0
local pvp = false

function isint(n)
    return n==math.floor(n)
end

RegisterCommand('dens', function(source, args, rawCommand)
    if #args > 0 then
        TriggerEvent('fufchat', args[1])
    end
end)

RegisterCommand('pvp', function(source, args, rawCommand)
    pvp = not pvp
    TriggerClientEvent('fufpvp', -1, pvp)
    TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^1* PvP set to ^7'..tostring(pvp))
end)

RegisterNetEvent('fufchat')
AddEventHandler('fufchat', function(nmult)
    nmult = tonumber(nmult)
    if nmult == nil then
        --print('bitch')
    else
        if (nmult > 0 or nmult == 0) and nmult < 101 then
            mult = nmult/100
            TriggerClientEvent('fufset', -1, mult)
            TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^5* The density mult is set to ^7'..nmult)
        end
    end
end)

RegisterNetEvent('fufloaded')
AddEventHandler('fufloaded', function()
    local source = source
    TriggerClientEvent('fufset', source, mult)
    TriggerEvent('fufpvp', source, pvp)
end)