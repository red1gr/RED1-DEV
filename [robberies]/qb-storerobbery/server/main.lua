local QBCore = exports['qb-core']:GetCoreObject()
local SafeCodes = {}
local cashA = 250 				--<<how much minimum you can get from a robbery
local cashB = 450				--<< how much maximum you can get from a robbery

CreateThread(function()
    while true do
        SafeCodes = {
            [1] = math.random(1000, 9999),
            [2] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [3] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [4] = math.random(1000, 9999),
            [5] = math.random(1000, 9999),
            [6] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [7] = math.random(1000, 9999),
            [8] = math.random(1000, 9999),
            [9] = math.random(1000, 9999),
            [10] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [11] = math.random(1000, 9999),
            [12] = math.random(1000, 9999),
            [13] = math.random(1000, 9999),
            [14] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [15] = math.random(1000, 9999),
            [16] = math.random(1000, 9999),
            [17] = math.random(1000, 9999),
            [18] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [19] = math.random(1000, 9999),
        }
        Wait((1000 * 60) * 40)
    end
end)

RegisterNetEvent('qb-storerobbery:server:takeMoney', function(register, isDone)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    -- Add some stuff if you want, this here above the if statement will trigger every 2 seconds of the animation when robbing a cash register.
    if isDone then
        local bags = math.random(1, 3)
        local info = {
            worth = math.random(cashA, cashB)
        }
        Player.Functions.AddItem('markedbills', bags, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")

        if math.random(1, 100) <= 100 then
            local code = SafeCodes[Config.Registers[register].safeKey]
            local info = {}
            if Config.Safes[Config.Registers[register].safeKey].type == "keypad" then
                info = {
                    label = "Safe Code: " .. tostring(code)
                }
            else
                info = {
                    label = "Safe Code: " .. tostring(math.floor((code[1] % 360) / 3.60)) .. "-" .. tostring(math.floor((code[2] % 360) / 3.60)) .. "-" .. tostring(math.floor((code[3] % 360) / 3.60)) .. "-" .. tostring(math.floor((code[4] % 360) / 3.60)) .. "-" .. tostring(math.floor((code[5] % 360) / 3.60))
                }
            end
            Player.Functions.AddItem("stickynote", 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["stickynote"], "add")
        end

    --   if math.random(1, 100) <= 50 then
    --       Player.Functions.AddItem("cryptopaper", 1, false)
    --       TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cryptopaper"], "add")
    --   end
    end
end)

RegisterNetEvent('qb-storerobbery:server:setRegisterStatus', function(register)
    Config.Registers[register].robbed   = true
    Config.Registers[register].time     = Config.resetTime
    TriggerClientEvent('qb-storerobbery:client:setRegisterStatus', -1, register, Config.Registers[register])
end)

RegisterNetEvent('qb-storerobbery:server:setSafeStatus', function(safe)
    TriggerClientEvent('qb-storerobbery:client:setSafeStatus', -1, safe, true)
    Config.Safes[safe].robbed = true

    SetTimeout(math.random(40, 80) * (60 * 1000), function()
        TriggerClientEvent('qb-storerobbery:client:setSafeStatus', -1, safe, false)
        Config.Safes[safe].robbed = false
    end)
end)

RegisterNetEvent('qb-storerobbery:server:SafeReward', function(safe)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local bags = math.random(1,3)
    local securitycard = math.random(1,1)
    -- local cryptopaper = math.random(1,3)
	local info = {
		worth = math.random(cashA, cashB)
	}
	Player.Functions.AddItem('markedbills', bags, false, info)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
    Player.Functions.AddItem('security_card_05', securitycard, false, info)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_05'], "add")
    -- Player.Functions.AddItem('cryptopaper', cryptopaper, false, info)
	-- TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cryptopaper'], "add")
    local luck = math.random(1, 100)
    local odd = math.random(1, 100)
    if luck <= 1 then
        Player.Functions.AddItem("water_bottle", math.random(1, 1))
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[""], "add")
        if luck == odd then
            Wait(500)
            Player.Functions.AddItem("joint", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["joint"], "add")
        end
    end
end)

RegisterServerEvent("yonatan:GiveItem:Store")
AddEventHandler("yonatan:GiveItem:Store", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[''], "add")
end)

RegisterNetEvent('qb-storerobbery:server:callCops', function(type, safe, streetLabel, coords)
    local cameraId = 4
    if type == "safe" then
        cameraId = Config.Safes[safe].camId
    else
        cameraId = Config.Registers[safe].camId
    end
    local alertData = {
        title = "10-33 | Shop Robbery",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = "Someone Is Trying To Rob A Store At "..streetLabel.." (CAMERA ID: "..cameraId..")"
    }
    --exports['qb-dispatch']:StoreRobbery(camId)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', "StoreRobbery", true)
end)

CreateThread(function()
    while true do
        local toSend = {}
        for k, v in ipairs(Config.Registers) do

            if Config.Registers[k].time > 0 and (Config.Registers[k].time - Config.tickInterval) >= 0 then
                Config.Registers[k].time = Config.Registers[k].time - Config.tickInterval
            else
                if Config.Registers[k].robbed then
                    Config.Registers[k].time = 0
                    Config.Registers[k].robbed = false
                    toSend[#toSend+1] = Config.Registers[k]
                end
            end
        end

        if #toSend > 0 then
            --The false on the end of this is redundant
            TriggerClientEvent('qb-storerobbery:client:setRegisterStatus', -1, toSend, false)
        end

        Wait(Config.tickInterval)
    end
end)

QBCore.Functions.CreateCallback('qb-storerobbery:server:isCombinationRight', function(source, cb, safe)
    cb(SafeCodes[safe])
end)

QBCore.Functions.CreateCallback('qb-storerobbery:server:getPadlockCombination', function(source, cb, safe)
    cb(SafeCodes[safe])
end)

QBCore.Functions.CreateCallback('qb-storerobbery:server:getRegisterStatus', function(source, cb)
    cb(Config.Registers)
end)

QBCore.Functions.CreateCallback('qb-storerobbery:server:getSafeStatus', function(source, cb)
    cb(Config.Safes)
end)

RegisterServerEvent('qb-storerobbery:client:robberyCall')
AddEventHandler('qb-storerobbery:server:callCops', function(type, safe, streetLabel, coords)
    local data = {displayCode = '10-90C', description = 'Possible Strore Robbery', isImportant = 0, recipientList = {'police'}, length = '15000', infoM = 'fa-fas fa-dollar-sign-circle', info = 'There are some Goons in the Store with Weapons'}
    local dispatchData = {dispatchData = data, caller = 'Local', coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z,
        }
    }

    local alertData = {
        title = "10-90 | Possible Store Robbery",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = "Suspect acticing suspicious at: "..streetLabel..")"
    }
    TriggerClientEvent("qb-storerobbery:client:robberyCall", -1, type, safe, streetLabel, coords)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
    TriggerEvent('wf-alerts:svNotify', dispatchData)
end)
