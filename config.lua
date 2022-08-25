Config = {

    -----------Enøs#0001Enøs#0001Enøs#0001Enøs#0001Enøs#0001


    UseESX = true,
    ESXTrigg = "esx:getSharedObject",

    Informateur = {
        {
            name = "Informateur n°1", 
            coords = vector3(-1313.4912109375,327.04852294922,65.493362426758), 
            heading = 287.22, 
            ped = "a_m_o_tramp_01"
        },
    },

    Information = {
        {
            name = "Information n°1", 
            price = 1000, 
            info = "Mon contact se trouve derrière un Parking près de Murrieta Height."
        },

        {
            name = "Information n°2", 
            price = 2000, 
            info = "Exemple 2"
        },

        {
            name = "Information n°3", 
            price = 4500, 
            info = "Exemple 3"
        },

    },
}

-----------Enøs#0001Enøs#0001Enøs#0001Enøs#0001Enøs#0001


if Config.UseESX == true then 
    if IsDuplicityVersion() then 
        ESX = nil
        TriggerEvent(Config.ESXTrigg, function(obj) ESX = obj end)
    else
        ESX = nil
        Citizen.CreateThread(function()
            while ESX == nil do
                TriggerEvent(Config.ESXTrigg, function(obj) ESX = obj end)
                Citizen.Wait(0)
            end
        end)
    end
end