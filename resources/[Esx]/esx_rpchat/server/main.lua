ESX = nil 
Citizen.CreateThread(function()    
   while ESX == nil do              TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)        
   Citizen.Wait(0)    
end     
end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end

	AddEventHandler('chatMessage', function(source, name, message)
		if string.sub(message, 1, string.len("/")) ~= "/" then
			local name = getIdentity(source)
		TriggerClientEvent("sendProximityMessage", -1, source, name.firstname, message)
		end
		CancelEvent()
	end)
	TriggerEvent('es:addCommand', 'ooc', function(source, args, user)
		local name =  GetPlayerName(source)
			TriggerClientEvent("sendProximityMessageMe", -1, source, "OOC | " .. name, table.concat(args, " "))
	end)

	TriggerEvent('es:addCommand', 'b', function(source, args, user)
		local name =  GetPlayerName(source)
		TriggerClientEvent("sendProximityMessageMe", -1, source, "OOC | " .. name, table.concat(args, " "))
	end)

	TriggerEvent('es:addCommand', 'aooc', function(source, args, user)	
		local src = source
		local xPlayer = ESX.GetPlayerFromId(src)
		print('This is group' .. xPlayer.getGroup())
		if xPlayer.getGroup() == "superadmin" or "admin" then
			TriggerClientEvent("sendProximityMessageMe", -1, source, "^1^*Admin ^0| ^2" .. name, table.concat(args, " "))
		else
			ESX.ShowNotfication("~r~~h~Shoma Admin nistid!")
		end
	end)

	TriggerEvent('es:addCommand', 's', function(source, args, user)
		local name = getIdentity(source)
		if args[1] then
		TriggerClientEvent("sendProximityMessageShout", -1, source, name.firstname .. " Faryad Mizanad", table.concat(args, " "))
		end
	end)

	-- TriggerEvent('es:addCommand', 'mp', function(source, args, user)
	-- 	xPlayer = ESX.GetPlayerFromId(source)
	-- 	if xPlayer.job.name == 'police' then
	-- 		TriggerClientEvent("sendProximityMessageMP", -1, source, "Bolandgo Police", table.concat(args, " "))
	-- 	end
	-- end)

	RegisterServerEvent('mpCommand')
	AddEventHandler('mpCommand', function(message)
		xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.job.name == 'police' then
			TriggerClientEvent("sendProximityMessageMP", -1, source, "Bolandgo Police", message)
		end
	end)

	RegisterServerEvent('proxevent')
	AddEventHandler('proxevent', function(message)
		local name =  GetPlayerName(source)
		TriggerClientEvent("sendProximityMessageProxevent", -1, source, "[Event]", name..' '..message)
	end)

	TriggerEvent('es:addCommand', 'do', function(source, args, user)
		local name = getIdentity(source)
		TriggerClientEvent("sendProximityMessageDo", -1, source, name.firstname, table.concat(args, " "))
	end)

	TriggerEvent('es:addCommand', 'tabligh', function(source, args, user)
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.job.name == "journaliste" then
			TriggerClientEvent("pNotify:SendNotification", source, {text = "Tabligh ferestade shod", type = "success", timeout = 3000, layout = "bottomCenter"})
			local name = getIdentity(source)
			TriggerClientEvent('chatMessage', -1, "[Tablighat] @" .. name.firstname ..'_'.. name.lastname .. "", {30, 144, 255}, table.concat(args, " "))
		else
			TriggerClientEvent("pNotify:SendNotification", source, {text = "Shoma Khabar negar nistid", type = "error", timeout = 3000, layout = "bottomCenter"})
		end
	end, {help = 'ye tablighat befres'})

	-- TriggerEvent('es:addCommand', 'b', function(source, args, user)
	-- 	-- local name = getIdentity(source)
	-- 	TriggerClientEvent('chatMessage', -1, "OOC | " .. GetPlayerName(source) .. ": ", {200, 200, 200}, table.concat(args, " "))
	-- end, {help = 'Out Of Character message'})

	-- TriggerEvent('es:addCommand', 'ooc', function(source, args, user)
	-- 	-- local name = getIdentity(source)
	-- 	TriggerClientEvent('chatMessage', -1, "OOC | " .. GetPlayerName(source) .. ": ", {200, 200, 200}, table.concat(args, " "))
	-- end, {help = 'Out Of Character message'})

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
