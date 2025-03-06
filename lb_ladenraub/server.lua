local robbed = false

RegisterNetEvent('lb_robbery:Reward',function (amount)
    
    exports.ox_inventory:AddItem(source, 'black_money', amount)
    
end)

RegisterNetEvent('lb_robbery:gotRobbed',function ()
    
    robbed = true
    
end)

RegisterNetEvent('lb_robbery:robbedFalse',function ()
    
    robbed = false
    
end)

lib.callback.register('lb_robbery:holdWeapon', function()
    
    if exports.ox_inventory:GetCurrentWeapon(source) == nul then
    
        return false

    else
        return true

    end


end)

lib.callback.register('lb_robbery:robbed', function()

    if robbed == false then
        return false
    else
        return true
    end

end)

lib.addCommand('resetKassen', {restricted = 'group.admin'}, function ()

    robbed = false
    
end)