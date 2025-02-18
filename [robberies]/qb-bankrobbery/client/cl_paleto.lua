RegisterNetEvent('qb-bankrobbery:client:UseBlueLaptop', function()
    if closestBank == 'Paleto' then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
            if hasItem then
                if not Config.Banks[closestBank].outsideHack then
                    QBCore.Functions.TriggerCallback('qb-bankrobbery:server:RobberyBusy', function(isBusy)
                        if not isBusy then
                            QBCore.Functions.TriggerCallback('qb-powerplant:server:getCops', function(cops)
                                if cops >= Config.MinCops.Paleto then
                                    exports['qb-dispatch']:PaletoBankRobbery(camId)
                                    QBCore.Functions.Progressbar("hack_gate", "Connecting the security guard..", math.random(25000, 25000), false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {
                                        animDict = "anim@gangops@facility@servers@",
                                        anim = "hotwire",
                                        flags = 16,
                                    }, {}, {}, function() -- Done
                                        StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                        TriggerServerEvent('qb-logs:server:createLog', 'simtopacific', 'Player Started Paleto Robbery', "", source)
                                        -- Remove Use
                                        -- TriggerServerEvent('QBCore:Server:RemoveItem', 'electronickit', 1)
                                        exports['qb-dispatch']:PaletoBankRobbery(camId)
                                        LaptopAnimation2('Paleto')
                                    end, function() -- Cancel
                                        StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                        QBCore.Functions.Notify("Canceled..", "error")
                                    end)
                                else
                                    QBCore.Functions.Notify('Not enough cops.. ('..Config.MinCops.Paleto..') required', 'error', 2500)
                                end
                            end)
                        else
                            QBCore.Functions.Notify("The security lock is active, opening the door is currently not possible..", "error", 5500)
                        end
                    end, 'paleto')
                else
                    QBCore.Functions.Notify('Somebody already hacked the security of this bank..', 'normal', 2500)
                end
            else
                QBCore.Functions.Notify('You are missing some item(s)..', 'error', 2500)
            end
        end, 'electronickit')
    end
end)

RegisterNetEvent('qb-bankrobbery:client:UseGreenCard', function()
    if Config.Banks['Paleto'].outsideHack then
        if not Config.Banks['Paleto'].hacked then
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
                if hasItem then
                    exports['ps-ui']:Scrambler(function(success)
                        if success then
                            QBCore.Functions.Progressbar("security_pass", "Swiping security SIM..", math.random(60000, 60000), false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = "anim@gangops@facility@servers@",
                                anim = "hotwire",
                                flags = 16,
                            }, {}, {}, function() -- Done
                                StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                -- Trollys
                                CreateTrollys('Paleto')
                                -- Set Hacked
                                TriggerServerEvent('qb-bankrobbery:server:SetBankHacked', 'Paleto', true)
                                -- Remove Card
                                TriggerServerEvent("QBCore:Server:RemoveItem", "security_card_02", 1)
                                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["security_card_02"], "remove")
                                local chance = math.random(1, 100)
            
                                if chance < 100 then
                                    TriggerServerEvent("bank:paletotopacific")
                                    TriggerServerEvent('qb-logs:server:createLog', 'simtopacific', 'Player Pacific Heist Sim', "", src)
                                    QBCore.Functions.Notify("You Got Pacific SIM!!! Lets goooo motherfuckers.", "success")
                                end
                            end, function() -- Cancel
                                StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                QBCore.Functions.Notify("Canceled..", "error")
                            end)
                        else
                            QBCore.Functions.Notify("fail", "error")
                        end
                    end, "greek", 10, 0)
                else
                    QBCore.Functions.Notify('You are missing some item(s)..', 'error', 2500)
                end
            end, 'security_card_02')
        end
    else
        QBCore.Functions.Notify("Doing this will trigger the lockdown system...", "error", 4500)
        Wait(5000)
        QBCore.Functions.Notify("Maybe you should disable it first?", "error", 4500)
    end
end)