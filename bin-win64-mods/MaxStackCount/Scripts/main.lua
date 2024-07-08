-- This loads all external properties from the config.lua file and assign them to "palConfig"
local palConfig = require "config"

-- Create updateMaxStackCount() function to be referenced later
local function updateMaxStackCount()
	-- Search inside PalStaticItemDataBase and iterate over all MaxStackCount items that are originaly equal to 9999
	-- Set only those values to the new MaxStackCount modifier for the config.lua file (palConfig.palMaxStackCount)
    local items = FindAllOf("PalStaticItemDataBase")
    if items then
        for _, item in ipairs(items) do
            if item.MaxStackCount == 9999 then
                item.MaxStackCount = palConfig.palMaxStackCount
            end
        end
    end
end

-- Create printMessage(message) function to be referenced later
local function printMessage(message)
    print(palConfig.palRedColorWrapperFront .. message .. palConfig.palRedColorWrapperBack)
end

-- Prints the mod successful loading message in red color 
printMessage(palConfig.palModName .. " version " .. palConfig.palModVersion .. " intended for UE4SS " .. palConfig.palUE4SSVersion .. " loaded for game version " .. palConfig.palGameVersion)

-- To hook a function in ue4ss, we use the RegisterHook function and the following line hooks the Client
RegisterHook("/Script/Engine.PlayerController:ClientRestart", function (Context)
	-- Checks if the following function was already executed once and if so, skips the next step
    if not palConfig.palClientRegisterHook then
        updateMaxStackCount()
		-- Prints the changed modded value in red when a successful NotifyOnNewObject is executed
        printMessage("[" .. palConfig.palModName .. "] set from 9999 to " .. palConfig.palMaxStackCount .. " [palClientRegisterHook]")
		-- This sets a config property to true, allowing the validation check to run only once
        palConfig.palClientRegisterHook = true
    end
end)

-- To hook a function in ue4ss, we use the RegisterHook function and the following line hooks the Server
RegisterHook("/Script/Engine.PlayerController:ServerAcknowledgePossession", function()
	-- Checks if the following function was already executed once and if so, skips the next step
    if not palConfig.palServerRegisterHook then
        updateMaxStackCount()
		-- Prints the changed modded value in red when a successful NotifyOnNewObject is executed
        printMessage("[" .. palConfig.palModName .. "] set from 9999 to " .. palConfig.palMaxStackCount .. " [palServerRegisterHook]")
		-- This sets a config property to true, allowing the validation check to run only once
        palConfig.palServerRegisterHook = true
    end
end)
