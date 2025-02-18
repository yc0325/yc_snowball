RegisterCommand('snowball', function()
    if IsNextWeatherType('XMAS')  then 
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not IsPlayerFreeAiming(PlayerId()) and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedRunning(PlayerPedId()) and not IsPedSprinting(PlayerPedId()) and GetInteriorFromEntity(PlayerPedId()) == 0 and not IsPedShooting(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInCover(PlayerPedId(), 0) then
            RequestAnimDict('anim@mp_snowball') 
            while not HasAnimDictLoaded('anim@mp_snowball') do
                Wait(0)
            end

            if Config.UseOxlib then 

                if lib.progressBar({
                    duration = 1500,
                    label = "撿雪球...",
                    useWhileDead = false,
                    canCancel = true,
                    disable = {car = true, move = true},
                    anim = {dict = "anim@mp_snowball", clip = "pickup_snowball"},
                }) then -- if completed
                    TriggerServerEvent("yc_snowball:AddItem", "weapon_snowball", 1)
                else -- if canceled
                    TriggerEvent("ox_lib:notify", {type = "error", description = "取消！"})
                end

            else
                TaskPlayAnim(PlayerPedId(), 'anim@mp_snowball', 'pickup_snowball', 8.0, -1, -1, 0, 1, 0, 0, 0) 
                Citizen.Wait(1500) 
                TriggerServerEvent("yc_snowball:AddItem", "weapon_snowball", 1)
            end

        end
    end
end)

RegisterKeyMapping("snowball", "撿雪球", "KEYBOARD", "")