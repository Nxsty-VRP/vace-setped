ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterCommand('setped', 'admin', function(source)

	TriggerClientEvent('bc:OpenMenu', source)
end, function(source, _, _)
local _source = source
	TriggerClientEvent('chatMessage', _source, "SYSTEM", {255, 0, 0}, 'Keine Rechte')
end, {help = 'Öffne das SetPed Menü'})