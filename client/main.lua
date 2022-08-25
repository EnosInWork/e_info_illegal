ShowHelpNotification = function(text)
	AddTextEntry("HelpNotification", text)
    DisplayHelpTextThisFrame("HelpNotification", false)
end

coolcoolmec = function(time)
    cooldown = true
    Citizen.SetTimeout(time,function()
        cooldown = false
    end)
end

function openInfo()
    local main = RageUI.CreateMenu('', 'Informateur')
        RageUI.Visible(main, not RageUI.Visible(main))
        while main do
            Citizen.Wait(0)
            RageUI.IsVisible(main, true, true, true, function()  
				for _,v in pairs(Config.Informateur) do
					for _,info in pairs(Config.Information) do
						RageUI.ButtonWithStyle(info.name, nil, { RightLabel = "~r~"..info.price.."$" }, true, function(Hovered, Active, Selected)
							if (Selected) then
								ESX.TriggerServerCallback('eInfo:CheckMoney', function(hasMoney)
									if hasMoney then
										TriggerEvent("chatMessage", "", {255, 0, 0}, "Informateur : ^7"..info.info)
										ESX.ShowNotification("Vous avez payé ~r~"..info.price.."$")
										coolcoolmec(4000) 
									else
										ESX.ShowNotification("Vous n'avez pas assez d'argent")
									end
								end, info.price)
							end
						end)
					end
				end
            end, function()
            end)
            if not RageUI.Visible(main) then
            main = RMenu:DeleteType(main, true)
        end
    end
end

Citizen.CreateThread(function()

	for _,v in pairs(Config.Informateur) do
		local model = GetHashKey(v.ped)
		RequestModel(model)
		while not HasModelLoaded(model) do Wait(1) end
		local ped = CreatePed(5, model, v.coords.x, v.coords.y, v.coords.z-1, v.heading, 0, 0)
		SetEntityInvincible(ped, 1)
		FreezeEntityPosition(ped, 1)
		SetBlockingOfNonTemporaryEvents(ped, 1)
	end

	while true do

		local Waiting = 500

		for k,v in pairs(Config.Informateur) do
			local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.coords, true)
			if dst <= 3.0 then
				Waiting = 1
				ShowHelpNotification("Appuyer sur ~INPUT_CONTEXT~ pour parler au monsieur")
				if IsControlJustPressed(1, 38) then
					openInfo()
				end
			end
		end

		Citizen.Wait(Waiting)

	end
end)