ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterCommand('setped', 'admin', function(source)
	TriggerClientEvent('bc:OpenMenu', source)
end, true, {help = "Developer Nxsty#3406"})