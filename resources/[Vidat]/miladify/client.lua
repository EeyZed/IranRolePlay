local ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('applyskin')
AddEventHandler('applyskin', function(skin)
    Citizen.CreateThread(function()
        local model = GetHashKey(skin)
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2)
    end)
end)

function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dump(v) .. ','
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
 end
RegisterNetEvent('resetchar')
AddEventHandler('resetchar', function()
	Citizen.CreateThread(function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                -- if skin['sex'] == 0 then
                --     -- TriggerEvent('skinchanger:loadDefaultModel', true, cb)
                --    TriggerEvent('skinchanger:change', 'sex',1)
                --    TriggerEvent('skinchanger:change', 'sex',0)
                --   else
                --     -- TriggerEvent('skinchanger:loadDefaultModel', false, cb)
                --     TriggerEvent('skinchanger:change', 'sex',1)
                --     TriggerEvent('skinchanger:change', 'sex',0)
                --   end
            end)
	end)
end)
