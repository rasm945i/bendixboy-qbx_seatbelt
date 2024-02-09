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


function SetSeatbeltIconVisibility(visible)
    if visible then
        exports['bendixboy-hudmanager']:ShowHudItem(HUD_NAME)
    else
        exports['bendixboy-hudmanager']:HideHudItem(HUD_NAME)
    end
end


exports['bendixboy-hudmanager']:RegisterHudItem({
    name = HUD_NAME,
    show = showSeatbeltIcon,
    hide = hideSeatbeltIcon,
    shouldBeDisplayed = false
})