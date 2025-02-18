local vaultCode = math.random(1000, 9999)
local flags = 0

CreateThread(function()
    print("^3[qb-bankrobbery] ^5Access Code: "..vaultCode.."^7")
end)

QBCore.Functions.CreateUseableItem("explosive", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent("explosive:UseExplosive", source)
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SetPowerPlant', function(state)
    Config.Banks['Vault'].powerplantHit = state
    TriggerClientEvent('qb-bankrobbery:client:SetPowerPLant', -1, state)
    if debug then
        print('^3[qb-bankrobbery] ^5Power Station Hit '..tostring(state)..'^7')
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SetLasers', function(state)
    Config.Banks['Vault'].lasersActive = state
    TriggerClientEvent('qb-bankrobbery:client:SetLasers',  -1, state)
    if debug then
        print('^3[qb-bankrobbery] ^5Set Laser: '..tostring(state)..'^7')
    end
end)

RegisterNetEvent('qb-bankrobbery:server:HitByLaser', function()
    Config.Banks['Vault'].lockdown = true
    TriggerClientEvent('qb-bankrobbery:client:VaultLockDown', -1)
end)

RegisterNetEvent('qb-bankrobbery:server:SetGoldHacked', function()
    local src = source
    -- Start Lasers
    if not Config.Banks['Vault'].powerplantHit then
        TriggerEvent('qb-bankrobbery:server:SetLasers', true)
    end
    Config.Banks['Vault'].goldhacked = true
    if Config.DoorLock == 'qb' then
        TriggerEvent('qb-doorlock:server:updateState', Config.Banks['Vault'].laptopDoor, false, false, false, true, false, false, src)
    elseif Config.DoorLock == 'nui' then
        TriggerEvent('qb-doorlock:server:updateState', Config.Banks['Vault'].laptopDoor, false, false, false, true, false, src)
    end
    TriggerClientEvent('qb-bankrobbery:client:SetGoldHacked',  -1)
    if debug then
        print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..' (id: '..src..') Hacked Gold Laptop Vault^7') 
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SetStackTaken', function(index, state)
    Config.Banks['Vault'].stacks[index].taken = state
    TriggerClientEvent('qb-bankrobbery:client:SetStackTaken', -1, index, state)
end)

RegisterNetEvent('qb-bankrobbery:server:StackReward', function(type)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if type == 'money' then
        local info = {worth = 15000} -- money bag worth
        local receiveAmount = math.random(4, 12)
        local receiveAmountcryptopaper = math.random(2, 5)
        Player.Functions.AddItem('markedbills', receiveAmount, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], 'add')
        Player.Functions.AddItem('cryptopaper', receiveAmountcryptopaper, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cryptopaper'], 'add', receiveAmountcryptopaper)
        TriggerClientEvent('QBCore:Notify', src, 'You got ' .. receiveAmount .. ' bags of inked money...')
        TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: Vault', 'black', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..receiveAmount..'x moneybags: $'..(receiveAmount*info.worth)..'**')
        if debug then
            print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..' (citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received: '..receiveAmount..' moneybags :'..(receiveAmount*info.worth)..'^7')
        end
    elseif type == 'gold' then
        local itemAmount = math.random(12, 16)
        Player.Functions.AddItem('goldbar', itemAmount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
        TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: Vault', 'black', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
        if debug then
            print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..' (citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received: '..itemAmount.. 'x goldbar^7') 
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:server:PrintCodes', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    info = {codes = vaultCode}
    Player.Functions.AddItem("lowervaultcodes", 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["lowervaultcodes"], "add")
    TriggerEvent("qb-log:server:CreateLog", "bankrobbery", "Lower Vault Codes", "black", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) printed lower vault code..")
end)

RegisterNetEvent('qb-bankrobbery:server:AttemptCode', function(input)
    local src = source
    if input == vaultCode then
        Config.Banks['Vault'].code = true
        TriggerClientEvent('qb-bankrobbery:client:CorrectCode', -1)
    else
        flags = flags + 1
        if flags >= 3 then -- 3 amount of times you can fail the code
            Config.Banks['Vault'].lockdown = true
            TriggerClientEvent('qb-bankrobbery:client:VaultLockDown', -1)
        end
        TriggerClientEvent('QBCore:Notify', src, "Incorrect! ("..flags.."/3)", "error", 2500)
    end
end)