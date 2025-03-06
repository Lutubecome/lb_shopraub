local luck = 0
local function startTimer(time)

    --print("Timer start")
    local timer = 45
    while timer > 0 do
            
        Citizen.Wait(1000)
        timer = timer - 1
        if timer == 0 then
            TriggerServerEvent('lb_robbery:robbedFalse')
            --print("Timer ende")
        end

    end

end

local function startRaub()
    
    TriggerServerEvent('lb_robbery:gotRobbed')

    local playerCoords = GetEntityCoords(PlayerPedId())

    --hier police dispatch mit coords einsetzen

    lib.notify({
        title = 'Raub gestartet',
        type = 'inform'
    })

    if lib.progressCircle({
        duration = 11000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true,
            sprint = true
        },
        anim = {
            dict = 'anim@scripted@heist@ig1_table_grab@gold@male@',
            clip = 'grab'
        },
    }) then 
    
        lib.notify({
            title = 'Raub beendet!',
            type = 'success'
        })

        local blackmoney = math.random(500, 1200)

        --money ausgabe
        TriggerServerEvent('lb_robbery:Reward', blackmoney)

    else 

        lib.notify({
            title = 'Raub abgebrochen!',
            type = 'error'
        })

     end

    startTimer()

end

lib.registerContext({
    id = 'lb_ShopRaubMenu',
    title = 'Laden Raub',
    options = {
      {
        title = 'Ausrauben?',
        icon = 'fas fa-cash-register',
        onSelect = function()

            if luck == 4 then
                if lib.callback.await('lb_robbery:holdWeapon') and lib.callback.await('lb_robbery:robbed') == false then
                    startRaub()
                    luck = 0
                else
                    lib.notify({
                        title = 'Du hast keine Waffe oder ein Laden wurde erst Ausgeraubt!',
                        type = 'inform'
                    })
                end
            end

            
        end,
      },
    }
  })

Citizen.CreateThread(function ()

    exports.ox_target:addModel('prop_till_01', {
        
        label = 'Kasse Ausrauben',
        icon = 'fas fa-cash-register',
        distance = 0.8,
        onSelect = function ()
            lib.showContext('lb_ShopRaubMenu')
            luck = 4
        end

    })
    
end)