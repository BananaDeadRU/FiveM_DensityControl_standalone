local waitTime = 500
local pvp = true
mult = 1.0

RegisterNetEvent('fufset')
AddEventHandler('fufset', function(nmult)
    mult = nmult
    if nmult == 1.0 then
        waitTime = 500
    else
        waitTime = 1
    end
    print('Set density multiplier: '..mult)
end)

RegisterNetEvent('fufpvp')
AddEventHandler('fufpvp', function(state)
    Citizen.Wait(500)
    pvp = state
    print('Set PvP: '..pvp)
end)

Citizen.CreateThread(function()
    TriggerServerEvent('fufloaded')
    while true do
        Citizen.Wait(waitTime)
        if (waitTime == 1) then
            SetPedDensityMultiplierThisFrame(mult)
            SetVehicleDensityMultiplierThisFrame(mult)
            SetRandomVehicleDensityMultiplierThisFrame(mult)
        end
    end
end)

Citizen.CreateThread(function() --PvP
    while true do
        Citizen.Wait(1)
        if pvp then
            SetCanAttackFriendly(GetPlayerPed(-1), true, false)
            NetworkSetFriendlyFireOption(true)
        else
            SetCanAttackFriendly(GetPlayerPed(-1), false, false)
            NetworkSetFriendlyFireOption(false)
        end
    end
end)
