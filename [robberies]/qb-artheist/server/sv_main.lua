local lastrob = 0
local QBCore = exports['qb-core']:GetCoreObject()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

QBCore.Functions.CreateCallback('artheist:server:checkRobTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - lastrob) < Config['ArtHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['ArtHeist']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('QBCore:Notify', src, 'You have to wait before robbing this place.' .. ' ' .. math.floor(seconds / 60) .. ' ' .. "more minutes", "primary")
        cb(false)
    else
        lastrob = os.time()
        cb(true)
    end
end)

RegisterNetEvent('artheist:server:policeAlert')
AddEventHandler('artheist:server:policeAlert', function(coords)
    local players = QBCore.Functions.GetPlayers()
    
    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if player.PlayerData.job.name == 'police' then
            TriggerClientEvent('artheist:client:policeAlert', players[i], coords)
        end
    end
end)

QBCore.Functions.CreateCallback('qb-artheist:server:getCops', function(source, cb)
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
	end
	cb(amount)
end)


RegisterServerEvent('artheist:server:syncHeistStart')
AddEventHandler('artheist:server:syncHeistStart', function()
    TriggerClientEvent('artheist:client:syncHeistStart', -1)
end)



RegisterServerEvent('artheist:server:syncPainting')
AddEventHandler('artheist:server:syncPainting', function(x)
    TriggerClientEvent('artheist:client:syncPainting', -1, x)
end)

RegisterServerEvent('artheist:server:syncAllPainting')
AddEventHandler('artheist:server:syncAllPainting', function()
    TriggerClientEvent('artheist:client:syncAllPainting', -1)
end)


RegisterServerEvent('artheist:server:finishHeist')
AddEventHandler('artheist:server:finishHeist', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        for k, v in pairs(Config['ArtHeist']['painting']) do
            local count = player.Functions.GetItemByName(v['rewardItem'])
            TriggerEvent("qb-log:server:CreateLog", "artheist", "Started art heist ", "white", "**".. GetPlayerName(src) .. "** (citizenid: *"..player.PlayerData.citizenid.."* | id: *"..src.."*)")
            if count ~= nil and count.amount > 0 then
                player.Functions.RemoveItem(v['rewardItem'], 1)
                player.Functions.AddMoney('cash', v['paintingPrice'], 'Art Heist')
            end
        end
    end
end)

RegisterServerEvent('artheist:server:rewardItem')
AddEventHandler('artheist:server:rewardItem', function(scene)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local item = scene['rewardItem']

    if player then
        player.Functions.AddItem(item, 1)
    end
end)


RegisterServerEvent('artheist:dongle')
AddEventHandler('artheist:dongle', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {}
    info.uses = math.random(1,1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_04'], "add", 1) 
    Player.Functions.AddItem('security_card_04', 1, false, info)
    TriggerEvent("qb-log:server:CreateLog", "artheist", "Get SIM ", "white", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*)")
end)

RegisterServerEvent('artheist:RemoveCard', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('security_card_05', 1)
end)
