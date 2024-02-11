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

-- NOTE THESE VALUES ARE ALSO STATICALLY TYPED IN HUD INTEGRATION
-- motorcycle, cycle and boats
exports['bendixboy-hudmanager']:HudComponentVehicleOnly(HUD_NAME, {8, 13, 14})