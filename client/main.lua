local config = require 'config.client'
local playerState = LocalPlayer.state
local speedMultiplier = exports["bendixboy-speedometer"]:GetSpeedMultiplier()
local minSpeeds = {
    unbuckled = config.minSpeedUnbuckled / speedMultiplier,
    buckled = config.minSpeedBuckled / speedMultiplier,
    harness = config.harness.minSpeed / speedMultiplier
}

-- Functions
local function isInvalidVehicle(vehicle)
    local class = GetVehicleClass(vehicle)
    return class == 8 or class == 13 or class == 14
end

local function playBuckleSound(seatbelt)
    qbx.loadAudioBank('audiodirectory/seatbelt_sounds')
    qbx.playAudio({
        audioName = seatbelt and 'carbuckle' or 'carunbuckle',
        audioRef = 'seatbelt_soundset',
        source = cache.ped
    })
    ReleaseNamedScriptAudioBank('audiodirectory/seatbelt_sounds')
end

local function toggleSeatbelt()
    local seatbeltOn = not playerState.seatbelt
    playerState.seatbelt = seatbeltOn
    SetFlyThroughWindscreenParams(seatbeltOn and minSpeeds.buckled or minSpeeds.unbuckled, 1.0, 17.0, 10.0)
    playBuckleSound(seatbeltOn)
    SetSeatbeltIconVisibility(seatbeltOn)
end

local function seatbelt()
    while cache.vehicle do
        local sleep = 1000
        if playerState.seatbelt then
            sleep = 0
            DisableControlAction(0, 75, true)
            DisableControlAction(27, 75, true)
        end
        Wait(sleep)
    end
    playerState.seatbelt = false
end

-- Main Thread
CreateThread(function()
    SetFlyThroughWindscreenParams(minSpeeds.unbuckled, 1.0, 17.0, 10.0)
end)

lib.onCache('vehicle', function()
    Wait(500)
    seatbelt()
end)

-- Register Key
lib.addKeybind({
    name = 'toggleseatbelt',
    description = locale('toggleCommand'),
    defaultKey = config.keybind,
    onPressed = function()
        if not cache.vehicle or IsPauseMenuActive() then return end
        if isInvalidVehicle(cache.vehicle) then return end

        toggleSeatbelt()
    end
})
