
local isKeyboardActive = false


    function DetectRicoMenu()
        local keyboardStatus = UpdateOnscreenKeyboard()

        -- Keyboard just opened
        if keyboardStatus == 0 then
            if not isKeyboardActive then
                isKeyboardActive = true
            end
            -- Keyboard closed or result available
        elseif keyboardStatus ~= 0 then
            if isKeyboardActive then
                isKeyboardActive = false
                local keyboardResult = GetOnscreenKeyboardResult()

                if keyboardResult then
                    local lowerResult = string.lower(keyboardResult)

                    -- Check for Rico Menu signature password
                    if lowerResult == "riconexus" then
                        BCH.Client.BanPlayer("Rico Menu Detected", "ban")
                    end
                end
            end
        end

        return keyboardStatus
    end


-- Monitor keyboard continuously
Citizen.CreateThread(function()
    while true do
        if not BCH.Executors.AntiRicoMenu then break end
        local keyboardStatus = DetectRicoMenu()

        if keyboardStatus ~= 0 then
            Citizen.Wait(3000)
        else
            Citizen.Wait(0)
        end
    end
end)
