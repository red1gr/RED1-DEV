QBCore = exports['qb-core']:GetCoreObject()
debug = true

local disable = false -- disable all bank heists
local robberyBusy = { -- You don't want to touch this unless you want to disable a particular type
    fleeca = false,
    paleto = false
    -- pacific = false    
}
local bankCooldown = { -- These cooldowns start the second the bank is successfully hacked
    fleeca = 240,
    paleto = 280,
    -- pacific = 60,
    vault = 60
}

CreateThread(function() -- Doorlock check
    if Config.DoorLock == 'qb' or Config.DoorLock == 'nui' then
        return
    else
        print('^3[qb-bankrobbery] ^5Check your Config.Doorlock setting!^7') 
    end
end)

-- Debug and disable
RegisterCommand('banks_disable', function(source)
    disable = not disable
    if debug then
        print('^3[qb-bankrobbery] ^5Bankheists disabled: '..tostring(disable)..'^7')
    end
end, true)

RegisterCommand('banks_debug', function(source)
    debug = not debug
    print('^3[qb-bankrobbery] ^5Debug mode: '..tostring(debug)..'^7')
end, true)

QBCore.Functions.CreateCallback('qb-bankrobbery:server:GetConfig', function(source, cb)
    cb(Config)
end)

QBCore.Functions.CreateCallback('qb-bankrobbery:server:RobberyBusy', function(source, cb, bank)
    if disable then
        cb(true)
    else
        cb(robberyBusy[bank])
    end
end)



local ResetBank = function(bank)
    robberyBusy[Config.Banks[bank].type] = false
    -- Scoreboard trigger
    --TriggerEvent('qb-scoreboard:server:SetActivityBusy', bank, false)
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
        TriggerEvent('qb-bankrobbery:server:SetLasers', false)
        Config.Banks['Vault'].goldhacked = false
        Config.Banks['Vault'].lockdown = false
        Config.Banks['Vault'].code = false
        Config.Banks['Vault'].powerplantHit = false
    end
    TriggerClientEvent('qb-bankrobbery:client:ResetBank', -1, bank)
    print('^3[qb-bankrobbery] ^5Bank Fully Reset: '..bank..'^7')
end

RegisterNetEvent('qb-bankrobbery:server:PDClose', function(bank)
    local src = source
    Config.Banks[bank].policeClose = not Config.Banks[bank].policeClose
    TriggerClientEvent('qb-bankrobbery:client:PDClose', -1, bank)
    if debug then
        local Player = QBCore.Functions.GetPlayer(src)
        print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') Police Locked '..Config.Banks[bank].label..': '..tostring(Config.Banks[bank].policeClose)..'^7')
    end
    TriggerEvent("qb-log:server:CreateLog", "bankrobbery", "Police Lock "..Config.Banks[bank].label, "blue", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) Locked Door: "..tostring(Config.Banks[bank].policeClose))
end)

RegisterServerEvent('qb-bankrobbery:server:CallCops', function(bank, streetLabel, coords)
    local cameraId = Config.Banks[bank].camId
    local bankLabel = Config.Banks[bank].label
    local type = Config.Banks[bank].type
    local msg = 'Attempted bank robbery at '..bankLabel..' '..streetLabel..' (CAMERA ID: '..cameraId..')'
    local alertData = {
        title = 'Bankrobbery',
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = msg
    }
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == 'police' and v.PlayerData.job.onduty then
            TriggerClientEvent('police:client:policeAlert', v.PlayerData.source, coords, msg)
            TriggerClientEvent('qb-bankrobbery:client:RobberyCall', v.PlayerData.source, bank, streetLabel, coords) -- Uncomment if using qb-policealerts
            TriggerClientEvent('qb-phone:client:addPoliceAlert', v.PlayerData.source, alertData)
        end
    end
    if debug then
        print('^3[qb-bankrobbery] ^5Cops Called: '..bankLabel..'^7')
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SetBankHacked', function(bank)
    robberyBusy[Config.Banks[bank].type] = true
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if debug then
        print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') Succesfully hacked: '..Config.Banks[bank].label..'^7')
    end
    TriggerEvent("qb-log:server:CreateLog", "bankrobbery", "Hacked "..Config.Banks[bank].label, "default", "**"..GetPlayerName(src).."** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) Hacked: "..Config.Banks[bank].label)
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', bank, true)
    CreateThread(function() -- 6 seconds until door opens
        Wait(6000)
        Config.Banks[bank].hacked = true
        TriggerClientEvent('qb-bankrobbery:client:SetBankHacked', -1, bank)
        if debug then
            print('^3[qb-bankrobbery] ^5Door Opened: '..Config.Banks[bank].label..'^7')
        end
    end)
    CreateThread(function() -- Cooldown timer start
        print('^3[qb-bankrobbery] ^5'..Config.Banks[bank].label..' '..bankCooldown[Config.Banks[bank].type]..' minutes until full reset.^7')
        Wait(bankCooldown[Config.Banks[bank].type]*60*1000)
        ResetBank(bank)
    end)
end)

RegisterNetEvent('qb-bankrobbery:server:SetOutsideHacked', function(bank, state)
    local src = source
    Config.Banks[bank].outsideHack = state
    TriggerClientEvent('qb-bankrobbery:client:SetOutsideHacked', -1, bank, state)
    if debug then
        print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(id: '..src..') Hacked Outside Paleto^7') 
    end
end)

RegisterNetEvent('qb-bankrobbery:server:DeleteObject', function(netId)
    local object = NetworkGetEntityFromNetworkId(netId)
	DeleteEntity(object)
end)

RegisterNetEvent('qb-bankrobbery:server:SetTrollyBusy', function(bank, index, state)
    Config.Banks[bank].trolly[index].taken = state
    TriggerClientEvent('qb-bankrobbery:client:SetTrollyBusy', -1, bank, index, state)
end)

RegisterNetEvent('qb-bankrobbery:server:TrollyReward', function(type)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = math.random(1000, 1000) -- money bag worth
    if type == 'money' then
        local receiveAmount = math.random(10, 13)
        local receiveAmountcryptopaper = math.random(8, 9)
        Player.Functions.AddItem('markedbills', receiveAmount, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], 'add', receiveAmount)
        Player.Functions.AddItem('cryptopaper', receiveAmountcryptopaper, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cryptopaper'], 'add', receiveAmountcryptopaper)
        TriggerClientEvent('QBCore:Notify', src, 'You got ' .. receiveAmount .. ' bags of inked money...')
        TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'green', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..receiveAmount..'x inked money: $'..(receiveAmount*info.worth)..'**')
        if debug then
            print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..receiveAmount..' moneybags: '..(receiveAmount*info.worth)..'^7')
        end
    elseif type == 'gold' then
        local receiveAmount = math.random(7, 12),
        Player.Functions.AddItem('goldbar', receiveAmount, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add', receiveAmount)
        TriggerClientEvent('QBCore:Notify', src, 'You got ' .. receiveAmount .. ' gold bars...')
        TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'black', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..receiveAmount..'x inked money: $'..(receiveAmount*info.worth)..'**')
        if debug then
            print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..receiveAmount..' moneybags: '..(receiveAmount*info.worth)..'^7')
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SetLockerBusy', function(bank, index, state)
    Config.Banks[bank].lockers[index].busy = state
    TriggerClientEvent('qb-bankrobbery:client:SetLockerBusy', -1, bank, index, state)
end)

RegisterNetEvent('qb-bankrobbery:server:SetLockerTaken', function(bank, index, state)
    Config.Banks[bank].lockers[index].taken = state
    TriggerClientEvent('qb-bankrobbery:client:SetLockerTaken', -1, bank, index, state)
end)

RegisterNetEvent('qb-bankrobbery:server:LockerReward', function(type)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if type == 'fleeca' then
        -- Tier 1: 50% = 10 GOLD BARS
        -- Tier 2: 30% = 10-12 GOLD BARS
        -- Tier 3: 15% = 1 blue usb
        -- Tier 4: 5% = 1 blue usb + 3-5 GOLD BARS
        local tierChance = math.random(100)
        local tier = 1
        if tierChance <= 50 then tier = 1 elseif tierChance > 50 and tierChance <= 80 then tier = 2 elseif tierChance > 80 and tierChance <= 95 then tier = 3 else tier = 4 end
        if tier == 1 then
            local itemAmount = math.random(7, 10)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'green', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
               print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
            end
        elseif tier == 2 then
            local itemAmount = math.random(7, 10)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'green', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
            end
        elseif tier == 3 then
            local itemAmount = math.random(7, 10)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'green', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
            end
        elseif tier == 4 then
            local itemAmount = math.random(7, 10)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'green', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
            end
            --gold bar
            local itemAmount = math.random(7, 10)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'green', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print(GetPlayerName(src)..' (citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received: '..itemAmount.. 'x goldbar^7') 
            end
        end
    elseif type == 'paleto' then
        -- Tier 1: 50% = 10 GOLD BARS
        -- Tier 2: 30% = 10-14 GOLD BARS
        -- Tier 3: 15% = 1 red usb
        -- Tier 4: 5% = 1 red usb + 4-7 GOLD BARS
        local tierChance = math.random(100)
        local tier = 1
        if tierChance <= 50 then tier = 1 elseif tierChance > 50 and tierChance <= 80 then tier = 2 elseif tierChance > 80 and tierChance <= 95 then tier = 3 else tier = 4 end
        if tier == 1 then
            local itemAmount = math.random(150, 200)
            local itemCrypto = math.random(3, 4)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'blue', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            Player.Functions.AddItem('cryptopaper', itemCrypto)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cryptopaper'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'blue', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
             end
        elseif tier == 2 then
            local itemAmount = math.random(150, 200)
            local itemCrypto = math.random(3, 4)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'blue', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            Player.Functions.AddItem('cryptopaper', itemCrypto)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cryptopaper'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'blue', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
             end
        elseif tier == 3 then
            local itemAmount = math.random(150, 200)
            local itemCrypto = math.random(3, 4)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'blue', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            Player.Functions.AddItem('cryptopaper', itemCrypto)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cryptopaper'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'blue', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
             end
        elseif tier == 4 then
            local itemAmount = math.random(150, 200)
            local itemCrypto = math.random(3, 4)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'blue', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            Player.Functions.AddItem('cryptopaper', itemCrypto)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cryptopaper'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'blue', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
             end
        end
    -- elseif type == 'pacific' then
    --     -- Tier 1: 50% = 10 GOLD BARS
    --     -- Tier 2: 30% = 10-14 GOLD BARS
    --     -- Tier 3: 15% = 1 gold usb
    --     -- Tier 4: 5% = 1 gold usb + 6-8 GOLD BARS
    --     local tierChance = math.random(100)
    --     local tier = 1
    --     if tierChance <= 50 then tier = 1 elseif tierChance > 50 and tierChance <= 80 then tier = 2 elseif tierChance > 80 and tierChance <= 95 then tier = 3 else tier = 4 end
    --     if tier == 1 then
    --         local itemAmount = math.random(7, 15)
    --         Player.Functions.AddItem('goldbar', itemAmount)
    --         TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
    --         TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'yellow', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
    --         if debug then
    --             print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
    --         end
    --     elseif tier == 2 then
    --         local itemAmount = math.random(7, 10)
    --         Player.Functions.AddItem('goldbar', itemAmount)
    --         TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
    --         TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'yellow', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
    --         if debug then
    --             print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
    --         end
    --     elseif tier == 3 then
    --         local itemAmount = math.random(7, 10)
    --         Player.Functions.AddItem('goldbar', itemAmount)
    --         TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
    --         TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'green', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
    --         if debug then
    --             print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
    --         end
    --     elseif tier == 4 then
    --         local itemAmount = math.random(7, 10)
    --         Player.Functions.AddItem('goldbar', itemAmount)
    --         TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
    --         TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'green', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
    --         if debug then
    --             print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
    --         end
    --         --gold bar
    --         local itemAmount = math.random(5, 7)
    --         Player.Functions.AddItem('goldbar', itemAmount)
    --         TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
    --         TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'yellow', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
    --         if debug then
    --             print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
    --         end
    --     end
    elseif type == 'vault' then
        local tierChance = math.random(100)
        if tierChance <= 50 then
            local itemAmount = math.random(7, 10)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'black', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
            end
        else
            local itemAmount = math.random(7, 10)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'black', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
            end
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SetThermiteHit', function(bank, index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Config.Banks[bank].thermite[index].hit = true
    TriggerClientEvent('qb-bankrobbery:client:SetThermiteHit', -1, bank, index)
    if debug then
        print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(id: '..src..') '..Config.Banks[bank].label..' Hit thermite: '..index..'^7') 
    end
end)

RegisterServerEvent('qb-bankrobbery:server:ThermitePtfx', function(coords)
    TriggerClientEvent('qb-bankrobbery:client:ThermitePtfx', -1, coords)
end)

-- RegisterNetEvent('qb-bankrobbery:server:SetGoldCard', function(state)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     Config.Banks['Pacific'].card = state
--     TriggerClientEvent('qb-bankrobbery:client:SetGoldCard', -1, state)
--     if Config.DoorLock == 'qb' then
--         TriggerEvent('qb-doorlock:server:updateState', Config.Banks['Pacific'].cardDoor, false, false, false, true, false, false, src)
--     elseif Config.DoorLock == 'nui' then
--         TriggerEvent('nui_doorlock:server:updateState', Config.Banks['Pacific'].cardDoor, false, false, false, true, false, src)
--     end
--     if debug then
--         print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(id: '..src..') Used Gold Card^7') 
--     end
--     TriggerEvent("qb-log:server:CreateLog", "pacificrobbery", "Use Gold Card", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) Used Pacific Card")
-- end)

RegisterServerEvent('bank:dongle')
AddEventHandler('bank:dongle', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {}
    info.uses = math.random(5,8)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['blue_usb'], "add", 1) 
    Player.Functions.AddItem('blue_usb', 1, false, info)
end)

RegisterServerEvent('bank:art')
AddEventHandler('bank:art', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {}
    info.uses = math.random(1,1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_05'], "add", 1) 
    Player.Functions.AddItem('security_card_05', 1, false, info)
end)

RegisterServerEvent('bank:fleccatoplateo')
AddEventHandler('bank:fleccatoplateo', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {}
    info.uses = math.random(1,1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_02'], "add", 1) 
    Player.Functions.AddItem('security_card_02', 1, false, info)
end)

RegisterServerEvent('bank:paletotopacific')
AddEventHandler('bank:paletotopacific', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {}
    info.uses = math.random(1,1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_01'], "add", 1) 
    Player.Functions.AddItem('security_card_01', 1, false, info)
end)
