ESX = exports['es_extended']:getSharedObject()

isInside = false

Citizen.CreateThread(function()

    local wasInside = false

    while true do
        Wait(1200)
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)
        local dist = #(vector3(playerCoords.x, playerCoords.y, playerCoords.z) - vector3(Config.ZonaChill.x, Config.ZonaChill.y, Config.ZonaChill.z))

        if dist <= 50.0 then
            isInside = true
            if not wasInside then
                ESX.ShowNotification('Estás dentro de la zona Chill')
                wasInside = true 
                print(isInside)
            end
        else
            isInside = false
            if wasInside then
                ESX.ShowNotification('Estás fuera de la zona Chill')
            end
            wasInside = false
            print(isInside)
        end
    end

end)

RegisterCommand('barrio',function()
    if isInside then 
        local playerData = ESX.GetPlayerData()
        local playerJob = playerData.job
        
        if playerJob and Config.Trabajos[playerJob.name] then
          local location = Config.Trabajos[playerJob.name]
          ESX.ShowNotification('Te has teletransportado a tu barrio')
          StartPlayerTeleport(PlayerId(), location.x, location.y, location.z, 0.0, false, true, true)
        end
    else
        ESX.ShowNotification('No puedes hacer esto fuera de zona Chill')
    end
end)