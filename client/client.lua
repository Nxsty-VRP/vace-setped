ESX 			    			= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShvacerpacaredObjvacerpacect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Peds", "Wähle dein Ped aus")
_menuPool:Add(mainMenu)



function FirstItem(menu)

    local standart = NativeUI.CreateItem("Wechsel zu deinem eigen Char", "")
    local pedone = NativeUI.CreateItem("Ped Werden", "")



    menu:AddItem(standart)
    menu:AddItem(pedone)

    menu.OnItemSelect = function(sender, item, index)
        if item == standart then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                local isMale = skin.sex == 0

                TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                end)

            end)
            _menuPool:CloseAllMenus()
        end
        if item == pedone then
            local pedHash = KeyboardInput("1", "1", "1", 100)

            pedHash = tonumber(pedHash)
     
            if IsModelInCdimage(pedHash) then
                RequestModel(pedHash)
    
                while not HasModelLoaded(pedHash) do
                    Citizen.Wait(5)
                end
    
                SetPlayerModel(PlayerId(), pedHash)
    
                ESX.ShowNotification("~g~Ped gewechselt.")
            else
                ESX.ShowNotification("Dieses Ped exestiert nicht.")
            end 
            _menuPool:CloseAllMenus() 
        end
    end
end

FirstItem(mainMenu)
_menuPool:RefreshIndex()


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        _menuPool:MouseControlsEnabled (false);
        _menuPool:MouseEdgeEnabled (false);
        _menuPool:ControlDisablingEnabled(false);
    end
end)

RegisterNetEvent('bc:OpenMenu')
AddEventHandler('bc:OpenMenu',function()

    mainMenu:Visible(true)
end)


function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		return result
	else
		Citizen.Wait(500)
		return nil
	end
end
