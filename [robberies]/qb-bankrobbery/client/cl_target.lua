CreateThread(function()
    -- Bank panels fleeca
    exports['qb-target']:AddBoxZone("BankPanelPinkCage", vector3(311.6, -284.60, 53.78), 0.2, 0.46, {
        name = "BankPanelPinkCage",
        heading = 249,
        debugPoly = false,
        minZ = 54.02,
        maxZ = 54.76
        }, {
        options = { 
            {
                type = "client",
                event = "qb-bankrobbery:client:UseGreenLaptop",
                icon = 'fas fa-user-secret',
                label = 'Hack Security - [1x - Flecca SIM]',
                canInteract = function()
                    if Config.Banks['PinkCage'].hacked then return false end
                    return true
                end,
            },
            {
                action = function()
                    TriggerServerEvent('qb-bankrobbery:server:PDClose', 'PinkCage')
                end,
                icon = 'fas fa-door-closed',
                label = 'Close Door',
                canInteract = function()
                    if not Config.Banks['PinkCage'].hacked then return false end
                    return true
                end,
                job = 'police'
            }
        },
        distance = 1.5,
    })
    exports['qb-target']:AddBoxZone("BankPanelLegion", vector3(147.19, -1046.2, 28.91), 0.2, 0.44, {
        name = "BankPanelLegion",
        heading = 249,
        debugPoly = false,
        minZ = 29.26,
        maxZ = 29.96
        }, {
        options = { 
            {
                type = "client",
                event = "qb-bankrobbery:client:UseGreenLaptop",
                icon = 'fas fa-user-secret',
                label = 'Hack Security - [1x - Flecca SIM]',
                canInteract = function()
                    if Config.Banks['Legion'].hacked then return false end
                    return true
                end,
            },
            {
                action = function()
                    TriggerServerEvent('qb-bankrobbery:server:PDClose', 'Legion')
                end,
                icon = 'fas fa-door-closed',
                label = 'Close Door',
                canInteract = function()
                    if not Config.Banks['Legion'].hacked then return false end
                    return true
                end,
                job = 'police'
            }
        },
        distance = 1.5,
    })
    exports['qb-target']:AddBoxZone("BankPanelHawick", vector3(-353.47, -55.48, 48.71), 0.2, 0.46, {
        name = "BankPanelHawick",
        heading = 249,
        debugPoly = false,
        minZ = 48.92,
        maxZ = 49.56
        }, {
        options = { 
            {
                type = "client",
                event = "qb-bankrobbery:client:UseGreenLaptop",
                icon = 'fas fa-user-secret',
                label = 'Hack Security - [1x - Flecca SIM]',
                canInteract = function()
                    if Config.Banks['Hawick'].hacked then return false end
                    return true
                end,
            },
            {
                action = function()
                    TriggerServerEvent('qb-bankrobbery:server:PDClose', 'Hawick')
                end,
                icon = 'fas fa-door-closed',
                label = 'Close Door',
                canInteract = function()
                    if not Config.Banks['Hawick'].hacked then return false end
                    return true
                end,
                job = 'police'
            }
        },
        distance = 1.5,
    })
    exports['qb-target']:AddBoxZone("BankPanelDelPerro", vector3(-1210.38, -336.40, 37.68), 0.24, 0.46, {
        name = "BankPanelDelPerro",
        heading = 297,
        debugPoly = false,
        minZ = 37.67,
        maxZ = 38.33
        }, {
        options = { 
            {
                type = "client",
                event = "qb-bankrobbery:client:UseGreenLaptop",
                icon = 'fas fa-user-secret',
                label = 'Hack Security - [1x - Flecca SIM]',
                canInteract = function()
                    if Config.Banks['DelPerro'].hacked then return false end
                    return true
                end,
            },
            {
                action = function()
                    TriggerServerEvent('qb-bankrobbery:server:PDClose', 'DelPerro')
                end,
                icon = 'fas fa-door-closed',
                label = 'Close Door',
                canInteract = function()
                    if not Config.Banks['DelPerro'].hacked then return false end
                    return true
                end,
                job = 'police'
            }
        },
        distance = 1.5,
    })
    exports['qb-target']:AddBoxZone("BankPanelGreatOcean", vector3(-2956.48, 482.1, 15.65), 0.24, 0.46, {
        name = "BankPanelGreatOcean",
        heading = 358,
        debugPoly = false,
        minZ = 15.50,
        maxZ = 16.20
        }, {
        options = { 
            {
                type = "client",
                event = "qb-bankrobbery:client:UseGreenLaptop",
                icon = 'fas fa-user-secret',
                label = 'Hack Security - [1x - Flecca SIM]',
                canInteract = function()
                    if Config.Banks['GreatOcean'].hacked then return false end
                    return true
                end,
            },
            {
                action = function()
                    TriggerServerEvent('qb-bankrobbery:server:PDClose', 'GreatOcean')
                end,
                icon = 'fas fa-door-closed',
                label = 'Close Door',
                canInteract = function()
                    if not Config.Banks['GreatOcean'].hacked then return false end
                    return true
                end,
                job = 'police'
            }
        },
        distance = 1.5,
    })
    exports['qb-target']:AddBoxZone("BankPanelSandy", vector3(1175.66, 2712.90, 37.99), 0.24, 0.46, {
        name = "BankPanelSandy",
        heading = 89,
        debugPoly = false,
        minZ = 38.00,
        maxZ = 38.60
        }, {
        options = { 
            {
                type = "client",
                event = "qb-bankrobbery:client:UseGreenLaptop",
                icon = 'fas fa-user-secret',
                label = 'Hack Security - [1x - Flecca SIM]',
                canInteract = function()
                    if Config.Banks['Sandy'].hacked then return false end
                    return true
                end,
            },
            {
                action = function()
                    TriggerServerEvent('qb-bankrobbery:server:PDClose', 'Sandy')
                end,
                icon = 'fas fa-door-closed',
                label = 'Close Door',
                canInteract = function()
                    if not Config.Banks['Sandy'].hacked then return false end
                    return true
                end,
                job = 'police'
            }
        },
        distance = 1.5,
    })
    -- Maze Bank
    exports['qb-target']:AddBoxZone("BankPanelMaze", vector3(-1303.85, -815.63, 17.15), 0.24, 0.46, {
        name = "BankPanelMaze",
        heading = 308.00,
        debugPoly = false,
        minZ = 17.35,
        maxZ = 18.05
        }, {
        options = { 
            {
                type = "client",
                event = "qb-bankrobbery:client:UseGreenLaptop",
                icon = 'fas fa-user-secret',
                label = 'Hack Security - [1x - Flecca SIM]',
                canInteract = function()
                    if Config.Banks['Maze'].hacked then return false end
                    return true
                end,
            },
            {
                action = function()
                    TriggerServerEvent('qb-bankrobbery:server:PDClose', 'Maze')
                end,
                icon = 'fas fa-door-closed',
                label = 'Close Door',
                canInteract = function()
                    if not Config.Banks['Maze'].hacked then return false end
                    return true
                end,
                job = 'police'
            }
        },
        distance = 1.5,
    })
    -- Paleto
    exports['qb-target']:AddBoxZone("BankPanelPaleto", vector3(-109.39, 6483.2, 31.48), 0.24, 0.46, {
        name = "BankPanelPaleto",
        heading = 226,
        debugPoly = false,
        minZ = 31.20,
        maxZ = 32.20
        }, {
        options = { 
            {
                type = "client",
                event = "qb-bankrobbery:client:UseBlueLaptop",
                icon = 'fas fa-user-secret',
                label = 'Hack Security [1x - Electronickit]',
                canInteract = function()
                    if Config.Banks['Paleto'].outsideHack then return false end
                    return true
                end,
            }
        },
        distance = 1.5,
    })
    exports['qb-target']:AddBoxZone("PaletoCard", vector3(-105.8362, 6472.1029, 31.626703), 0.3, 0.4, {
        name = "PaletoCard",
        heading = 73,
        debugPoly = false,
        minZ = 31.79,
        maxZ = 32.19
        }, {
        options = { 
            {
                type = "client",
                event = "qb-bankrobbery:client:UseGreenCard",
                icon = 'fas fa-user-secret',
                label = 'Open Bank Door',
                canInteract = function()
                    if Config.Banks['Paleto'].hacked then return false end
                    return true
                end,
            },
            {
                action = function()
                    TriggerServerEvent('qb-bankrobbery:server:PDClose', 'Paleto')
                end,
                icon = 'fas fa-door-closed',
                label = 'Close Door',
                canInteract = function()
                    if not Config.Banks['Paleto'].hacked then return false end
                    return true
                end,
                job = 'police'
            }
        },
        distance = 1.5,
    })
    -- Pacific
    -- exports['qb-target']:AddBoxZone("BankPanelPacific", vector3(252.88, 228.55, 101.68), 0.3, 0.4, {
    --     name = "BankPanelPacific",
    --     heading = 68.00,
    --     debugPoly = false,
    --     minZ = 101.79,
    --     maxZ = 102.39
    --     }, {
    --     options = { 
    --         {
    --             type = "client",
    --             event = "qb-bankrobbery:client:UseRedLaptop",
    --             icon = 'fas fa-user-secret',
    --             label = 'Hack Security',
    --             canInteract = function()
    --                 if Config.Banks['Pacific'].hacked or not Config.Banks['Pacific'].card then return false end
    --                 return true
    --             end,
    --         },
    --         {
    --             action = function()
    --                 TriggerServerEvent('qb-bankrobbery:server:PDClose', 'Pacific')
    --             end,
    --             icon = 'fas fa-door-closed',
    --             label = 'Close Door',
    --             canInteract = function()
    --                 if not Config.Banks['Pacific'].hacked then return false end
    --                 return true
    --             end,
    --             job = 'police'
    --         }
    --     },
    --     distance = 1.5,
    -- })
    -- exports['qb-target']:AddBoxZone("PacificCard", vector3(262.31, 223.01, 106.28), 0.2, 0.4, {
    --     name = "PacificCard",
    --     heading = 250,
    --     debugPoly = false,
    --     minZ = 106.29,
    --     maxZ = 106.99
    --     }, {
    --     options = { 
    --         {
    --             type = "client",
    --             event = "qb-bankrobbery:client:UseGoldCard",
    --             icon = 'fas fa-user-secret',
    --             label = 'Open Security Door',
    --             canInteract = function()
    --                 if Config.Banks['Pacific'].card then return false end
    --                 return true
    --             end,
    --         }
    --     },
    --     distance = 1.5,
    -- })
    -- Vault
    -- exports['qb-target']:AddBoxZone("VaultGoldLaptop", vector3(257.60, 228.20, 101.68), 0.2, 0.25, {
    --     name = "VaultGoldLaptop",
    --     heading = 340.00,
    --     debugPoly = false,
    --     minZ = 102.05,
    --     maxZ = 102.25
    --     }, {
    --     options = { 
    --         {
    --             type = "client",
    --             event = "qb-bankrobbery:client:UseGoldLaptop",
    --             icon = 'fas fa-user-secret',
    --             label = 'Hack Security',
    --             canInteract = function()
    --                 if Config.Banks['Vault'].goldhacked then return false end
    --                 return true
    --             end,
    --         }
    --     },
    --     distance = 1.5,
    -- })
    exports['qb-target']:AddBoxZone("VaultGreyUsb", vector3(252.14, 235.93, 102.49), 0.3, 0.6, {
        name = "VaultGreyUsb",
        heading = 253.00,
        debugPoly = false,
        minZ = 101.40,
        maxZ = 101.60
        }, {
        options = { 
            {
                type = "client",
                event = "qb-bankrobbery:client:UseGreyUsb",
                icon = 'fas fa-user-secret',
                label = 'Print Access Code',
                canInteract = function()
                    if Config.Banks['Vault'].hacked or not Config.Banks['Vault'].goldhacked  then return false end
                    return true
                end,
            },
            {
                action = function()
                    TriggerServerEvent('qb-bankrobbery:server:PDClose', 'Vault')
                end,
                icon = 'fas fa-door-closed',
                label = 'Close Door',
                canInteract = function()
                    if not Config.Banks['Vault'].hacked then return false end
                    return true
                end,
                job = 'police'
            }
        },
        distance = 1.5,
    })
    exports['qb-target']:AddBoxZone("VaultEnterCode", vector3(261.61, 258.43, 101.69), 0.3, 0.3, {
        name = "VaultEnterCode",
        heading = 340.00,
        debugPoly = false,
        minZ = 102.00,
        maxZ = 102.25
        }, {
        options = { 
            {
                type = "client",
                event = "qb-bankrobbery:client:EnterVaultCode",
                icon = 'fas fa-hand-holding',
                label = 'Enter Code',
                canInteract = function()
                    if not Config.Banks['Vault'].goldhacked then return false end
                    return true
                end,
            }
        },
        distance = 1.5,
    })

    -- Lockers
    for k, v in pairs(Config.Banks) do
        for i=1, #v.lockers do
            exports['qb-target']:AddBoxZone("Locker"..k..i, v.lockers[i].coords.xyz, 0.5, 2.0, {
                name = "Locker"..k..i,
                heading = v.lockers[i].coords.w,
                debugPoly = false,
                minZ = Config.Banks[k].lockers[i].coords.z-1.2,
                maxZ = Config.Banks[k].lockers[i].coords.z+1.0
                }, {
                options = { 
                    {
                        action = function()
                            LootLocker(k, i)
                        end,
                        icon = 'fas fa-hand-holding',
                        label = 'Open Locker - [1x - Drill]',
                        canInteract = function()
                            if not Config.Banks[k].hacked or Config.Banks[k].lockers[i].taken or Config.Banks[k].lockers[i].busy then
                                return false
                            end
                            return true
                        end,
                    }
                },
                distance = 1.5,
            })
        end
    end
    -- Trollys
    for k, v in pairs(Config.Banks) do
        for i=1, #v.trolly do
            exports['qb-target']:AddBoxZone("Trolly"..k..i, v.trolly[i].coords.xyz, 0.5, 1.0, {
                name = "Trolly"..k..i,
                heading = v.trolly[i].coords.w,
                debugPoly = false,
                minZ = Config.Banks[k].trolly[i].coords.z-1.2,
                maxZ = Config.Banks[k].trolly[i].coords.z+0.2
                }, {
                options = { 
                    {
                        action = function()
                            LootTrolly(k, i)
                        end,
                        icon = 'fas fa-hand-holding',
                        label = 'Grab '..Config.Banks[k].trolly[i].type,
                        canInteract = function()
                            if not Config.Banks[k].hacked or Config.Banks[k].trolly[i].taken then
                                return false
                            end
                            return true
                        end,
                    }
                },
                distance = 1.5,
            })
        end
    end
    -- Stacks
    for k, v in pairs(Config.Banks['Vault'].stacks) do
        exports['qb-target']:AddBoxZone("VaultStack"..k, v.coords.xyz, 0.5, 0.7, {
            name = "VaultStack"..k,
            heading = v.coords.w,
            debugPoly = false,
            minZ = 101.550,
            maxZ = 101.850
            }, {
            options = { 
                {
                    action = function()
                        LootStack(k)
                    end,
                    icon = 'fas fa-hand-holding',
                    label = 'Grab!',
                    canInteract = function()
                        if not Config.Banks['Vault'].hacked or Config.Banks['Vault'].stacks[k].taken then return false end
                        return true
                    end,
                }
            },
            distance = 1.5,
        })
    end
end)