QBCore = exports['qb-core']:GetCoreObject()

closestBank = nil

local copsCalled = false
local PlayerJob = {}

-- time = time in seconds per puzzle
-- blocks = amount of blocks per puzzle
-- amount = amount of puzzles the player has to solve consecutively
local HackSettings = {
    ['fleeca'] = {
        time = 20,
        blocks = 4,
        amount = 4
    },
    ['paleto'] = {
        time = 35,
        blocks = 4,
        amount = 4
    },
    -- ['pacific'] = {
    --     time = 25,
    --     blocks = 2,
    --     amount = 1
    -- },
    ['vault'] = {
        time = 30,
        blocks = 2,
        amount = 1
    }
}

-- correctBlocks = Number of correct blocks the player needs to click
-- incorrectBlocks = number of incorrect blocks after which the game will fail
-- timetoShow = time in secs for which the right blocks will be shown
-- timetoLose = maximum time after timetoshow expires for player to select the right blocksz
local ThermiteSettings = {
    ['fleeca'] = {
        correctBlocks = 6, -- You want to set this way higher!
        incorrectBlocks = 4,
        timetoShow = 6.5,
        timetoLose = 15
    },
    ['paleto'] = {
        correctBlocks = 6, -- You want to set this way higher!
        incorrectBlocks = 4,
        timetoShow = 4.5,
        timetoLose = 12
    },
    -- ['pacific'] = {
    --     correctBlocks = 8, -- You want to set this way higher!
    --     incorrectBlocks = 4,
    --     timetoShow = 5.5,
    --     timetoLose = 15
    -- },
    ['vault'] = {
        correctBlocks = 9, -- You want to set this way higher!
        incorrectBlocks = 4,
        timetoShow = 6.5,
        timetoLose = 15
    }
}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    QBCore.Functions.TriggerCallback('qb-bankrobbery:server:GetConfig', function(config)
        Config = config
        if Config.Banks['Vault'].lasersActive and not Config.Banks['Vault'].powerplantHit then
            StartLasers()
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerJob = {}
end)

AddEventHandler('onClientResourceStart',function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    else
        PlayerJob = QBCore.Functions.GetPlayerData().job 
    end
end)

RegisterNetEvent('qb-bankrobbery:client:RobberyCall', function(bank, streetLabel, coords)
    if PlayerJob.name == "police" then 
        local cameraId = Config.Banks[bank].camId
        local bankLabel = Config.Banks[bank].label
        local type = Config.Banks[bank].type
        if type == "fleeca" then
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            Wait(100)
            PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
            Wait(100)
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            Wait(100)
            PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
            TriggerEvent('chatMessage', "ALARM", "warning", "Bankrobbery: "..bankLabel)
            TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
                timeOut = 10000,
                alertTitle = "Attempted Bank Robbery",
                coords = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                },
                details = {
                    [1] = {
                        icon = '<i class="fas fa-university"></i>',
                        detail = bankLabel,
                    },
                    [2] = {
                        icon = '<i class="fas fa-video"></i>',
                        detail = cameraId,
                    },
                    [3] = {
                        icon = '<i class="fas fa-globe-europe"></i>',
                        detail = streetLabel,
                    }
                },
                callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
            })
        elseif type == "paleto" then
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            Wait(100)
            PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
            Wait(100)
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            Wait(100)
            PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
            TriggerEvent('chatMessage', "ALARM", "warning", "Bankrobbery: Blaine County Savings")
            TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
                timeOut = 10000,
                alertTitle = "Attempted Bank Robbery",
                coords = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                },
                details = {
                    [1] = {
                        icon = '<i class="fas fa-university"></i>',
                        detail = bankLabel,
                    },
                    [2] = {
                        icon = '<i class="fas fa-video"></i>',
                        detail = cameraId,
                    },
                    [3] = {
                        icon = '<i class="fas fa-globe-europe"></i>',
                        detail = "Paleto Bay",
                    }
                },
                callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
            })
        elseif type == "pacific" then
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            Wait(100)
            PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
            Wait(100)
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            Wait(100)
            PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
            TriggerEvent('chatMessage', "ALARM", "warning", "Bankrobbery: Pacific Standard Bank")
            TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
                timeOut = 10000,
                alertTitle = "Attempted Bank Robbery",
                coords = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                },
                details = {
                    [1] = {
                        icon = '<i class="fas fa-university"></i>',
                        detail = bankLabel,
                    },
                    [2] = {
                        icon = '<i class="fas fa-video"></i>',
                        detail = "1 | 2 | 3",
                    },
                    [3] = {
                        icon = '<i class="fas fa-globe-europe"></i>',
                        detail = "Alta St",
                    }
                },
                callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
            })
        end
        local transG = 250
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 487)
        SetBlipColour(blip, 4)
        SetBlipDisplay(blip, 4)
        SetBlipAlpha(blip, transG)
        SetBlipScale(blip, 1.9)
        SetBlipFlashes(blip, true)
        SetBlipAsShortRange(blip, false)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("911: Bankrobbery")
        EndTextCommandSetBlipName(blip)
        while transG ~= 0 do
            Wait(180 * 4)
            transG = transG - 1
            SetBlipAlpha(blip, transG)
            if transG == 0 then
                SetBlipSprite(blip, 2)
                RemoveBlip(blip)
                return
            end
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:client:SetBankHacked', function(bank)
    Citizen.CreateThread(function()
        Config.Banks[bank].hacked = true
        Citizen.Wait(60000 * 120)
        Config.Banks[bank].hacked = false
    end)
end)

RegisterNetEvent('qb-bankrobbery:client:SetOutsideHacked', function(bank, state)
    Config.Banks[bank].outsideHack = state
end)

RegisterNetEvent('qb-bankrobbery:client:SetTrollyBusy', function(bank, index, state)
    Config.Banks[bank].trolly[index].taken = state
end)

RegisterNetEvent('qb-bankrobbery:client:SetLockerBusy', function(bank, index, state)
    Config.Banks[bank].lockers[index].busy = state
end)

RegisterNetEvent('qb-bankrobbery:client:SetLockerTaken', function(bank, index, state)
    Config.Banks[bank].lockers[index].taken = state
end)

RegisterNetEvent('qb-bankrobbery:client:ThermitePtfx', function(coords)
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(50) end
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", coords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Wait(27500)
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent('qb-bankrobbery:client:SetThermiteHit', function(bank, index)
    Config.Banks[bank].thermite[index].hit = true
end)

RegisterNetEvent('thermite:UseThermite', function()
    local pos = GetEntityCoords(PlayerPedId())
    if closestBank then
        for i=1, #Config.Banks[closestBank].thermite, 1 do
            if #(pos-Config.Banks[closestBank].thermite[i].coords.xyz) < 2 then
                StartThermite(closestBank, i)
            end
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:client:ResetBank', function(bank)
    -- Door
    Config.Banks[bank].hacked = false
    Config.Banks[bank].policeClose = false
    -- lockers
    for i=1, #Config.Banks[bank].lockers, 1 do
        Config.Banks[bank].lockers[i].busy = false
        Config.Banks[bank].lockers[i].taken = false
    end
    -- Trollys
    for j=1, #Config.Banks[bank].trolly, 1 do
        Config.Banks[bank].trolly[j].taken = false
    end
    -- Thermite spots
    if Config.Banks[bank].thermite then
        for k=1, #Config.Banks[bank].thermite, 1 do
            Config.Banks[bank].thermite[k].hit = false
        end
    end
    -- Stackpiles of cash or gold
    if Config.Banks[bank].stacks then
        for h=1, #Config.Banks[bank].stacks, 1 do
            Config.Banks[bank].stacks[h].taken = false
        end
    end
    -- Big Banks
    if bank == 'Paleto' then
        Config.Banks['Paleto'].outsideHack = false
    -- elseif bank == 'Pacific' then
    --     Config.Banks['Pacific'].card = false
    elseif bank == 'Vault' then
        Config.Banks['Vault'].goldhacked = false
        Config.Banks['Vault'].lockdown = false
        Config.Banks['Vault'].code = false
        Config.Banks['Vault'].powerplantHit = false
    end
end)

IsWearingHandshoes = function() -- Globally used
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == `mp_m_freemode_01` then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

CallCops = function() -- Globally used
    if not copsCalled then
        copsCalled = true
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
        local street1 = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)
        local streetLabel = street1
        if street2 ~= nil then 
            streetLabel = streetLabel.." "..street2
        end
        TriggerServerEvent("qb-bankrobbery:server:CallCops", closestBank, streetLabel, pos)
        CreateThread(function()
            Wait(5*60*1000)
            copsCalled = false
        end)
    end
end

CreateTrollys = function(bank) -- Globally used
    RequestModel("hei_prop_hei_cash_trolly_01")
    RequestModel("ch_prop_gold_trolly_01a")
    while not HasModelLoaded("hei_prop_hei_cash_trolly_01") or not HasModelLoaded("ch_prop_gold_trolly_01a") do Wait(10) end
    for k, v in pairs(Config.Banks[bank].trolly) do
        if v.type == 'money' then
            -- DELETE OLD
            local oldcashtrolley = GetClosestObjectOfType(v.coords.x, v.coords.y, v.coords.z, 1.0, 269934519, false, false, false)
            if oldcashtrolley ~= 0 then
                local netId = NetworkGetNetworkIdFromEntity(oldcashtrolley)
                TriggerServerEvent('qb-bankrobbery:server:DeleteObject', netId)
                Wait(500)
            end
            local emptytrolly = GetClosestObjectOfType(v.coords.x, v.coords.y, v.coords.z, 1.0, 769923921, false, false, false)
            if emptytrolly ~= 0 then
                local netId = NetworkGetNetworkIdFromEntity(emptytrolly)
                TriggerServerEvent('qb-bankrobbery:server:DeleteObject', netId)
                Wait(500)
            end
            -- CREATE NEW
            local trolly = CreateObject(269934519, v.coords.x, v.coords.y, v.coords.z, 1, 0, 0)
            SetEntityHeading(trolly, v.coords.w)
            FreezeEntityPosition(trolly, true)
            SetEntityInvincible(trolly, true)
            PlaceObjectOnGroundProperly(trolly)
        elseif v.type == 'gold' then
            -- DELETE OLD
            local oldgoldtrolly = GetClosestObjectOfType(v.coords.x, v.coords.y, v.coords.z, 2.0, 2007413986, false, false, false)
            if oldgoldtrolly ~= 0 then
                local netId = NetworkGetNetworkIdFromEntity(oldgoldtrolly)
                TriggerServerEvent('qb-bankrobbery:server:DeleteObject', netId)
                Wait(500)
            end
            local emptytrolly = GetClosestObjectOfType(v.coords.x, v.coords.y, v.coords.z, 1.0, -1580618867, false, false, false)
            if emptytrolly ~= 0 then
                local netId = NetworkGetNetworkIdFromEntity(emptytrolly)
                TriggerServerEvent('qb-bankrobbery:server:DeleteObject', netId)
                Wait(500)
            end
            -- CREATE NEW
            local trolly = CreateObject(2007413986, v.coords.x, v.coords.y, v.coords.z, 1, 0, 0)
            SetEntityHeading(trolly, v.coords.w)
            FreezeEntityPosition(trolly, true)
            SetEntityInvincible(trolly, true)
            PlaceObjectOnGroundProperly(trolly)
        end
    end
end

local OnLaptopHackDone = function(success, bank)
    local src = source
    if success then
        QBCore.Functions.Notify("You cracked the security system..", "error")
        TriggerServerEvent('QBCore:Server:RemoveItem', 'security_card_03', 1)
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = "DuckyBoy",
            subject = bank,
            message = "I've received your input codes and will now start disabling the security system..<br />This might take a minute..",
            button = {}
        })
        if Config.Banks[bank].type == 'fleeca' then
            if math.random(1,100) < 100 then
            TriggerServerEvent("bank:fleccatoplateo")
            TriggerServerEvent('qb-logs:server:createLog', 'simtopacific', 'Player Got Paleto Heist Sim', "", src)
            QBCore.Functions.Notify("You Got Paleto SIM!!! Lets goooo motherfuckers.", "success")
        end
    end
        if bank == 'Paleto' then
            TriggerServerEvent('qb-bankrobbery:server:SetOutsideHacked', 'Paleto', true)
            if math.random(1,100) < 1 then
                TriggerServerEvent("bank:art")
                TriggerServerEvent('qb-logs:server:createLog', 'simtopacific', 'Player Got Art Heist Sim', "", src)
                QBCore.Functions.Notify("You Got Art Heist Sim again! What a luck. go and try the next hack to get your Pacific SIM", "success")		
            end
        elseif bank == 'Vault' then
            TriggerServerEvent('qb-doorlock:server:updateState', 323, false)
            TriggerServerEvent('qb-bankrobbery:server:SetGoldHacked')
            if math.random(1,100) < 35 then
                TriggerServerEvent("QBCore:Server:AddItem", "goldbar", 1)
                TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['goldbar'], "add")
                QBCore.Functions.Notify("You Got Gold Bar :)", "success")
            end
        else
            CreateTrollys(bank)
            TriggerServerEvent('qb-bankrobbery:server:SetBankHacked', bank)
        end
    end
end

local OnLaptopHackDone2 = function(success, bank)
    local src = source
    if success then
        QBCore.Functions.Notify("You cracked the security system..", "error")
        TriggerServerEvent('QBCore:Server:RemoveItem', 'electronickit', 1)
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = "DuckyBoy",
            subject = bank,
            message = "I've received your input codes and will now start disabling the security system..<br />This might take a minute..",
            button = {}
        })
        if Config.Banks[bank].type == 'fleeca' then
            if math.random(1,100) < 50 then
            TriggerServerEvent("bank:fleccatoplateo")
            TriggerServerEvent('qb-logs:server:createLog', 'simtopacific', 'Player Got Paleto Heist Sim', "", src)
            QBCore.Functions.Notify("You Got Paleto SIM!!! Lets goooo motherfuckers.", "success")
        end
        if math.random(1,100) < 1 then
            TriggerServerEvent("bank:art")
            TriggerServerEvent('qb-logs:server:createLog', 'simtopacific', 'Player Got Art Heist Sim', "", src)
            QBCore.Functions.Notify("You Got Art Heist Sim You are not so lucky.. :(", "success")		
        end
    end
        if bank == 'Paleto' then
            TriggerServerEvent('qb-bankrobbery:server:SetOutsideHacked', 'Paleto', true)
            if math.random(1,100) < 1 then
                TriggerServerEvent("bank:art")
                TriggerServerEvent('qb-logs:server:createLog', 'simtopacific', 'Player Got Art Heist Sim', "", src)
                QBCore.Functions.Notify("You Got Art Heist Sim again! What a luck. go and try the next hack to get your Pacific SIM", "success")		
            end
        elseif bank == 'Vault' then
            TriggerServerEvent('qb-doorlock:server:updateState', 323, false)
            TriggerServerEvent('qb-bankrobbery:server:SetGoldHacked')
            if math.random(1,100) < 35 then
                TriggerServerEvent("QBCore:Server:AddItem", "goldbar", 1)
                TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['goldbar'], "add")
                QBCore.Functions.Notify("You Got Gold Bar :)", "success")
            end
        else
            CreateTrollys(bank)
            TriggerServerEvent('qb-bankrobbery:server:SetBankHacked', bank)
        end
    end
end

local OnLaptopHackDone3 = function(success, bank)
    local src = source
    if success then
        QBCore.Functions.Notify("You cracked the security system..", "error")
        TriggerServerEvent('qb-bankrobbery:server:LaptopDamage', 'security_card_01')
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = "DuckyBoy",
            subject = bank,
            message = "I've received your input codes and will now start disabling the security system..<br />This might take a minute..",
            button = {}
        })
        if Config.Banks[bank].type == 'fleeca' then
            if math.random(1,100) < 50 then
            TriggerServerEvent("bank:fleccatoplateo")
            TriggerServerEvent('qb-logs:server:createLog', 'simtopacific', 'Player Got Paleto Heist Sim', "", src)
            QBCore.Functions.Notify("You Got Paleto SIM!!! Lets goooo motherfuckers.", "success")
        end
        if math.random(1,100) < 1 then
            TriggerServerEvent("bank:art")
            TriggerServerEvent('qb-logs:server:createLog', 'simtopacific', 'Player Got Art Heist Sim', "", src)
            QBCore.Functions.Notify("You Got Art Heist Sim You are not so lucky.. :(", "success")		
        end
    end
        if bank == 'Paleto' then
            TriggerServerEvent('qb-bankrobbery:server:SetOutsideHacked', 'Paleto', true)
            if math.random(1,100) < 1 then
                TriggerServerEvent("bank:art")
                TriggerServerEvent('qb-logs:server:createLog', 'simtopacific', 'Player Got Art Heist Sim', "", src)
                QBCore.Functions.Notify("You Got Art Heist Sim again! What a luck. go and try the next hack to get your Pacific SIM", "success")		
            end
        elseif bank == 'Vault' then
            TriggerServerEvent('qb-doorlock:server:updateState', 323, false)
            TriggerServerEvent('qb-bankrobbery:server:SetGoldHacked')
            if math.random(1,100) < 35 then
                TriggerServerEvent("QBCore:Server:AddItem", "goldbar", 1)
                TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['goldbar'], "add")
                QBCore.Functions.Notify("You Got Gold Bar :)", "success")
            end
        else
            CreateTrollys(bank)
            TriggerServerEvent('qb-bankrobbery:server:SetBankHacked', bank)
        end
    end
end

loadAnimDict = function(dict) -- Globally used
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end 

LaptopAnimation = function(bank) -- Globally used
    local loc = Config.Banks[bank].laptop
    LocalPlayer.state:set("inv_busy", true, true)
    local animDict = "anim@heists@ornate_bank@hack"
    RequestAnimDict(animDict)
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")
    while not HasAnimDictLoaded(animDict) or not HasModelLoaded("hei_prop_hst_laptop") or not HasModelLoaded("hei_p_m_bag_var22_arm_s") do Wait(10) end
    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", targetPosition)
    end
    SetEntityHeading(ped, loc.h)
    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, targetPosition, 1, 1, 0)
    local laptop = CreateObject(`hei_prop_hst_laptop`, targetPosition, 1, 1, 0)
    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)
    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
    Wait(2000)
    exports['hacking']:OpenHackingGame(HackSettings[Config.Banks[bank].type].time, HackSettings[Config.Banks[bank].type].blocks, HackSettings[Config.Banks[bank].type].amount, function(Success)
        OnLaptopHackDone(Success, bank)
        LocalPlayer.state:set("inv_busy", false, true)
        NetworkStartSynchronisedScene(netScene3)
        Wait(4600)
        NetworkStopSynchronisedScene(netScene3)
        DeleteObject(bag)
        DeleteObject(laptop)
        FreezeEntityPosition(ped, false)
    end)
end

LaptopAnimation2 = function(bank) -- Globally used
    local loc = Config.Banks[bank].laptop
    LocalPlayer.state:set("inv_busy", true, true)
    local animDict = "anim@heists@ornate_bank@hack"
    RequestAnimDict(animDict)
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")
    while not HasAnimDictLoaded(animDict) or not HasModelLoaded("hei_prop_hst_laptop") or not HasModelLoaded("hei_p_m_bag_var22_arm_s") do Wait(10) end
    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", targetPosition)
    end
    SetEntityHeading(ped, loc.h)
    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, targetPosition, 1, 1, 0)
    local laptop = CreateObject(`hei_prop_hst_laptop`, targetPosition, 1, 1, 0)
    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)
    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
    Wait(2000)
    exports['hacking']:OpenHackingGame(HackSettings[Config.Banks[bank].type].time, HackSettings[Config.Banks[bank].type].blocks, HackSettings[Config.Banks[bank].type].amount, function(Success)
        OnLaptopHackDone2(Success, bank)
        LocalPlayer.state:set("inv_busy", false, true)
        NetworkStartSynchronisedScene(netScene3)
        Wait(4600)
        NetworkStopSynchronisedScene(netScene3)
        DeleteObject(bag)
        DeleteObject(laptop)
        FreezeEntityPosition(ped, false)
    end)
end

LaptopAnimation3 = function(bank) -- Globally used
    local loc = Config.Banks[bank].laptop
    LocalPlayer.state:set("inv_busy", true, true)
    local animDict = "anim@heists@ornate_bank@hack"
    RequestAnimDict(animDict)
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")
    while not HasAnimDictLoaded(animDict) or not HasModelLoaded("hei_prop_hst_laptop") or not HasModelLoaded("hei_p_m_bag_var22_arm_s") do Wait(10) end
    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", targetPosition)
    end
    SetEntityHeading(ped, loc.h)
    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, targetPosition, 1, 1, 0)
    local laptop = CreateObject(`hei_prop_hst_laptop`, targetPosition, 1, 1, 0)
    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)
    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
    Wait(2000)
    exports['hacking']:OpenHackingGame(HackSettings[Config.Banks[bank].type].time, HackSettings[Config.Banks[bank].type].blocks, HackSettings[Config.Banks[bank].type].amount, function(Success)
        OnLaptopHackDone3(Success, bank)
        LocalPlayer.state:set("inv_busy", false, true)
        NetworkStartSynchronisedScene(netScene3)
        Wait(4600)
        NetworkStopSynchronisedScene(netScene3)
        DeleteObject(bag)
        DeleteObject(laptop)
        FreezeEntityPosition(ped, false)
    end)
end

LootTrolly = function(bank, index) -- Globally used
    Citizen.CreateThread(function()
        exports['ps-ui']:VarHack(function(success)
            if success then
                -- set taken
                TriggerServerEvent('qb-bankrobbery:server:SetTrollyBusy', bank, index, true)
                -- animation
                LocalPlayer.state:set("inv_busy", true, true)
                if Config.Banks[bank].trolly[index].type == 'money' then
                    local ped = PlayerPedId()
                    local CurrentTrolly = GetClosestObjectOfType(Config.Banks[bank].trolly[index].coords.x, Config.Banks[bank].trolly[index].coords.y, Config.Banks[bank].trolly[index].coords.z, 1.0, 269934519, false, false, false)
                    local MoneyObject = CreateObject(`hei_prop_heist_cash_pile`, GetEntityCoords(ped), true)
                    SetEntityVisible(MoneyObject, false, false)
                    AttachEntityToEntity(MoneyObject, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
                    local GrabBag = CreateObject(`hei_p_m_bag_var22_arm_s`, GetEntityCoords(ped), true, false, false)
                    
                    local GrabOne = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, GrabOne, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(GrabBag, GrabOne, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
                    NetworkStartSynchronisedScene(GrabOne)
                    Wait(1500)
                    SetEntityVisible(MoneyObject, true, true)
                    
                    -- SetEntityVisible(MoneyObject, true, true)
        
                    local GrabTwo = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, GrabTwo, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(GrabBag, GrabTwo, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
                    NetworkAddEntityToSynchronisedScene(CurrentTrolly, GrabTwo, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
                    NetworkStartSynchronisedScene(GrabTwo)
                    Wait(37000)
                    SetEntityVisible(MoneyObject, false, false)
                    
                    local GrabThree = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, GrabThree, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(GrabBag, GrabThree, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
                    NetworkStartSynchronisedScene(GrabThree)
                    
                    local NewTrolley = CreateObject(769923921, GetEntityCoords(CurrentTrolly) + vector3(0.0, 0.0, - 0.985), true, false, false)
                    SetEntityRotation(NewTrolley, GetEntityRotation(CurrentTrolly))
                    while not NetworkHasControlOfEntity(CurrentTrolly) do
                        Wait(10)
                        NetworkRequestControlOfEntity(CurrentTrolly)
                    end
                    DeleteObject(CurrentTrolly)
                    while DoesEntityExist(CurrentTrolly) do
                        Wait(10)
                        DeleteObject(CurrentTrolly)
                    end
                    PlaceObjectOnGroundProperly(NewTrolley)
                    Wait(1800)
                    
                    DeleteEntity(GrabBag)
                    DeleteObject(MoneyObject)
                elseif Config.Banks[bank].trolly[index].type == 'gold' then
                    local ped = PlayerPedId()
                    RequestModel("ch_prop_gold_bar_01a")
                    RequestModel("ch_prop_gold_trolly_empty")
                    local CurrentTrolly = GetClosestObjectOfType(Config.Banks[bank].trolly[index].coords.x, Config.Banks[bank].trolly[index].coords.y, Config.Banks[bank].trolly[index].coords.z, 1.0, 2007413986, false, false, false)
                    local MoneyObject = CreateObject(`ch_prop_gold_bar_01a`, GetEntityCoords(ped), true)
                    SetEntityVisible(MoneyObject, false, false)
                    AttachEntityToEntity(MoneyObject, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
                    local GrabBag = CreateObject(`hei_p_m_bag_var22_arm_s`, GetEntityCoords(ped), true, false, false)
                    
                    local GrabOne = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, GrabOne, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(GrabBag, GrabOne, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
                    NetworkStartSynchronisedScene(GrabOne)
                    Wait(1500)
                    SetEntityVisible(MoneyObject, true, true)
                    
                    -- שאר הקוד עבור הסוג 'gold'
                    
                    DeleteEntity(GrabBag)
                    DeleteObject(MoneyObject)
                end
                -- evidence
                if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
                    local pos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                end
                -- reward
                TriggerServerEvent('qb-bankrobbery:server:TrollyReward', Config.Banks[bank].trolly[index].type)
                LocalPlayer.state:set("inv_busy", false, true)
            else
                print("fail")
            end
        end, 7, 7)
    end)
end

LootLocker = function(bank, index) -- Globally used
    -- SET BUSY
    TriggerServerEvent('qb-bankrobbery:server:SetLockerBusy', bank, index, true)
    LocalPlayer.state:set("inv_busy", true, true)
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
        if hasItem then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
                TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
            end
            exports['boii-chiphack']:StartGame(function(success)
                if success then
            loadAnimDict("anim@heists@fleeca_bank@drilling")
            TaskPlayAnim(ped, 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle' , 3.0, 3.0, -1, 1, 0, false, false, false)
            local DrillObject = CreateObject(`hei_prop_heist_drill`, pos.x, pos.y, pos.z, true, true, true)
            AttachEntityToEntity(DrillObject, ped, GetPedBoneIndex(ped, 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)
            -- TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "bankdrill", 0.3)
                    QBCore.Functions.Progressbar("open_locker_drill", "Unlocking safe..", 35000, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function() -- Done
                        StopAnimTask(ped, "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
                        DetachEntity(DrillObject, true, true)
                        DeleteObject(DrillObject)
                        -- SET TAKEN
                        TriggerServerEvent('qb-bankrobbery:server:SetLockerTaken', bank, index, true)
                        -- UNSET BUSY
                        LocalPlayer.state:set("inv_busy", false, true)
                        TriggerServerEvent('qb-bankrobbery:server:SetLockerBusy', bank, index, false)
                        -- RECEIVE ITEM
                        TriggerServerEvent('qb-bankrobbery:server:LockerReward', Config.Banks[bank].type)
                        QBCore.Functions.Notify("Successful!", "success")
                        isDrilling = false
                    end, function() -- Cancel
                        StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
                        -- UNSET BUSY
                        LocalPlayer.state:set("inv_busy", false, true)
                        TriggerServerEvent('qb-bankrobbery:server:SetLockerBusy', bank, index, false)
                        DetachEntity(DrillObject, true, true)
                        DeleteObject(DrillObject)
                        QBCore.Functions.Notify("Canceled..", "error")
                        isDrilling = false
                    end)
                else
                    print("fail")
                end
            end, 7, 45)
        else
            QBCore.Functions.Notify("Looks like the safe lock is too strong ..", "error")
            -- UNSET BUSY
            LocalPlayer.state:set("inv_busy", false, true)
            TriggerServerEvent('qb-bankrobbery:server:SetLockerBusy', bank, index, false)
        end
    end, 'drill')
end

-- Thermite Functions
local PlantThermite = function(bank, index)
    TriggerServerEvent("QBCore:Server:RemoveItem", "thermiteb", 1)
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["thermiteb"], "remove")
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") or not HasModelLoaded("hei_p_m_bag_var22_arm_s") or not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(50) end
    local ped = PlayerPedId()
    if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", GetEntityCoords(ped))
    end
    SetEntityHeading(ped, Config.Banks[bank].thermite[index].coords.w)
    local pos = Config.Banks[bank].thermite[index].coords.xyz
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
    SetEntityCollision(bag, false, true)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local charge = CreateObject(`hei_prop_heist_thermite`, x, y, z + 0.2,  true,  true, true)
    SetEntityCollision(charge, false, true)
    AttachEntityToEntity(charge, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(bagscene)
    Wait(5000)
    DetachEntity(charge, 1, 1)
    FreezeEntityPosition(charge, true)
    DeleteObject(bag)
    NetworkStopSynchronisedScene(bagscene)
    CreateThread(function()
        Wait(15000)
        DeleteEntity(charge)
    end)
end

local ThermiteEffect = function(bank, index)
    local ped = PlayerPedId()
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do Wait(50) end
    Wait(1500)
    TriggerServerEvent("qb-bankrobbery:server:ThermitePtfx", Config.Banks[bank].thermite[index].ptfx)
    Wait(500)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Wait(25000)
    ClearPedTasks(ped)
    Wait(2000)
    QBCore.Functions.Notify("The door is burned open", "success")
    if Config.DoorLock == 'qb' then
        TriggerServerEvent('qb-doorlock:server:updateState', Config.Banks[bank].thermite[index].doorId, false, false, false, true, false, false)
    elseif Config.DoorLock == 'nui' then
        TriggerServerEvent('qb-doorlock:server:updateState', Config.Banks[bank].thermite[index].doorId, false, false, false, true)
    end
end

StartThermite = function(bank, index) -- Globally used
    if not Config.Banks[bank].thermite[index].hit then
        local pos = GetEntityCoords(PlayerPedId())
        if #(pos - Config.Banks[bank].thermite[index].coords.xyz) < 2 then
            PlantThermite(bank, index)
            local bankType = Config.Banks[bank].type
            exports["memorygame"]:thermiteminigame(ThermiteSettings[bankType].correctBlocks, ThermiteSettings[bankType].incorrectBlocks, ThermiteSettings[bankType].timetoShow, ThermiteSettings[bankType].timetoLose,
            function()
                TriggerServerEvent('qb-bankrobbery:server:SetThermiteHit', bank, index)
                ThermiteEffect(bank, index)
            end,
            function()
                QBCore.Functions.Notify("You failed...", "success")
            end)
        end
    end
end

-- Set closestBank loop
CreateThread(function()
    while true do
        Wait(200)
        local pos = GetEntityCoords(PlayerPedId())
        local inRange = false
        for k, v in pairs(Config.Banks) do
            if #(pos - v.coords) < 15 then
                closestBank = k
                inRange = true
                break
            end
        end
        if not inRange then
            Wait(2000)
            closestBank = nil
        end
    end
end)