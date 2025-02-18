local QBCore = exports['qb-core']:GetCoreObject()
local blackoutActive = false

local function CheckStationHits()
    Wait(6000)
    if Config.PowerStations[1].hit and Config.PowerStations[2].hit and Config.PowerStations[3].hit and Config.PowerStations[4].hit then
        -- east powerplant hit
        -- explosion
        TriggerEvent("qb-powerplant:powerplant:server:east:boom")
        Wait(1000)
        -- blackout
        if not blackoutActive then
            TriggerEvent("qb-weathersync:server:toggleBlackout", true)
        end
        TriggerClientEvent('chatMessage', -1, "[LS Water & Power]", "error", "City wide power outage, we are working on it!")
        TriggerClientEvent("police:client:DisableAllCameras", -1)
        print("^3[qb-powerplant] ^5East Power Plant Hit^7")
        TriggerEvent("qb-log:server:CreateLog", "powerplants", "Blackout", "black", "**East Powerplant Hit**")
        blackoutActive = true
    elseif Config.PowerStations[5].hit and Config.PowerStations[6].hit and Config.PowerStations[7].hit then
        -- city powerplant hit
        -- explosion
        TriggerEvent("qb-powerplant:powerplant:server:city:boom")
        Wait(1000)
        -- blackout
        if not blackoutActive then
            TriggerEvent("qb-weathersync:server:toggleBlackout", true)
        end
        TriggerClientEvent('chatMessage', -1, "[LS Water & Power]", "error", "City wide power outage, we are working on it!")
        TriggerClientEvent("police:client:DisableAllCameras", -1)
        print("^3[qb-powerplant] ^5City Power Plant Hit^7")
        TriggerEvent("qb-log:server:CreateLog", "powerplants", "Blackout", "black", "**City Powerplant Hit**")
        blackoutActive = true
    end
end

QBCore.Functions.CreateUseableItem("thermiteb", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('lighter') then
        TriggerClientEvent("thermite:UseThermite", source)
    else
        TriggerClientEvent('QBCore:Notify', source, "You are missing something to light it with..", "error")
    end
end)

QBCore.Functions.CreateCallback('qb-powerplant:server:GetConfig', function(source, cb)
    cb(Config)
end)

QBCore.Functions.CreateCallback('qb-powerplant:server:getCops', function(source, cb)
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

RegisterServerEvent('qb-powerplant:server:SetStationStatus', function(key, isHit)
    Config.PowerStations[key].hit = isHit
    TriggerEvent("qb-log:server:CreateLog", "powerplants", "Thermite", "red", "Station: "..key.." is hit successfully.")
    print("^3[qb-powerplant] ^5".."Station: "..key.." is hit succesfully^7")
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, key, isHit)
    CheckStationHits()
end)

RegisterServerEvent('qb-powerplant:powerplant:server:city:boom', function()
    TriggerClientEvent('qb-powerplant:powerplant:client:city:boom', -1)
    -- ART GALLERY TRIGGERS
    if Config.Artgallery then
        TriggerClientEvent('qb-artgalleryheist:client:lasers:StopLasers', -1)
        TriggerClientEvent('qb-artgalleryheist:client:lasers:PowerPlantHit', -1)
    end
    -- LOWER VAULT TRIGGERS
    if Config.Bankrobbery then
        TriggerEvent('qb-bankrobbery:server:SetPowerPlant', true)
        TriggerEvent('qb-bankrobbery:server:SetLasers', false)
    end
end)

RegisterServerEvent('qb-powerplant:powerplant:server:east:boom', function()
    TriggerClientEvent('qb-powerplant:powerplant:client:east:boom', -1)
end)

RegisterServerEvent('qb-powerplant:server:ThermitePtfx', function(coords)
    TriggerClientEvent('qb-powerplant:client:ThermitePtfx', -1, coords)
end)

CreateThread(function()
    while true do
        Wait(1000 * 60 * 10)
        if blackoutActive then
            Wait(1000*60*55)
            TriggerEvent("qb-weathersync:server:toggleBlackout", false)
            TriggerClientEvent("police:client:EnableAllCameras", -1)
            TriggerClientEvent("qb-bankrobbery:client:enableAllBankSecurity", -1)
            TriggerClientEvent('chatMessage', -1, "[LS Water & Power]", "normal", "Power in the city is restored!")
            blackoutActive = false
            TriggerEvent("qb-log:server:CreateLog", "powerplants", "Blackout", "black", "**Blackout is over.**")
        end
    end
end)


RegisterServerEvent("blow:test", function()
    Config.PowerStations[5].hit = true
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 5, true)
    Config.PowerStations[6].hit = true
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 6, true)
    Config.PowerStations[7].hit = true
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 7, true)
    CheckStationHits()
end)

QBCore.Commands.Add("powerplant2", "east", {}, false, function(source, args)
    Config.PowerStations[1].hit = true
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 1, true)
    Config.PowerStations[2].hit = true
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 2, true)
    Config.PowerStations[3].hit = true
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 3, true)
    Config.PowerStations[4].hit = true
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 4, true)
    CheckStationHits()
end, "god")