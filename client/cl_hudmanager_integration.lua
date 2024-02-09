local HUD_NAME = 'bendixboy-qbx_seatbelt:seatbelt-icon'

local function showSeatbeltIcon()
    SendNUIMessage({
        hidden = false,
    })
end

local function hideSeatbeltIcon()
    SendNUIMessage({
        hidden = true,
    })
end


function SetSeatbeltIconVisibility(seatbeltOn)
    if seatbeltOn then
        exports['bendixboy-hudmanager']:HideHudItem(HUD_NAME)
    else
        exports['bendixboy-hudmanager']:ShowHudItem(HUD_NAME)
    end
end


exports['bendixboy-hudmanager']:RegisterHudItem({
    name = HUD_NAME,
    show = showSeatbeltIcon,
    hide = hideSeatbeltIcon,
    shouldBeDisplayed = false
})


lib.onCache('vehicle', function(value)
    if not value then
        exports['bendixboy-hudmanager']:HideHudItem(HUD_NAME)
        return
    end

    if IsInvalidVehicle(value) then
        return
    end

    exports['bendixboy-hudmanager']:ShowHudItem(HUD_NAME)

end)

Wait(200)

-- Determine if minimap should be shown when script is loaded
local car = GetVehiclePedIsIn(cache.ped, false)
if car == 0 or IsInvalidVehicle(car) then
    print("HIDE HUD ITEM ON STARTUP")
    exports['bendixboy-hudmanager']:HideHudItem(HUD_NAME)
else
    print("SHOW SEATBELT ON STARTUP")
    exports['bendixboy-hudmanager']:ShowHudItem(HUD_NAME)
end