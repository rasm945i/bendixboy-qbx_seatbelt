local HUD_NAME = 'bendixboy-qbx_seatbelt:seatbelt-icon'

local function showSeatbeltIcon()
    TriggerEvent("bendixboy-speedometer:client:showSeatbeltIcon", true)
end

local function hideSeatbeltIcon()
    -- Apparently, opening the "ESC" menu makes you exit the car, according to Ox-Lib onCache.
    -- If PauseMenu is active when this is called, we ignore it and leave the seatbelt icon as is.
    -- Don't ask why its not required for ShowSeatbeltIcon, I have no clue.
    if IsPauseMenuActive() then return end
    TriggerEvent("bendixboy-speedometer:client:showSeatbeltIcon", false)
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