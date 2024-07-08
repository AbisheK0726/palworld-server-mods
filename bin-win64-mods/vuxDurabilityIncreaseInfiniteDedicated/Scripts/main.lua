-- Tested on version 0.1.4.0
local vuxGameVersion = "0.1.4.0"
local vuxModVersion = "Auto Infinite"
local vuxCheckRestart = 0

LoopAsync(10000, function()
    local items = FindAllOf("PalDynamicWeaponItemDataBase")
    if items then
        for _, item in ipairs(items) do
            local name = item.StaticId:ToString()
            if string.find(name, "_NPC") then

            else
                item.Durability = 55555
                item.OldDurability = 55555
                item.MaxDurability = 55555
            end           
        end
    else
        -- print("No tools or weapons found.\n")
    end
    
    local items = FindAllOf("PalDynamicArmorItemDataBase")
    if items then
        for _, item in ipairs(items) do
            local name = item.StaticId:ToString()
            if string.find(name, "Accessory") then

            else
                item.Durability = 55555
                item.OldDurability = 55555
                item.MaxDurability = 55555
            end           
        end
    else
        -- print("No armour found.\n")
    end
end)

RegisterHook("/Script/Engine.PlayerController:ClientRestart", function()
    if vuxCheckRestart ~= 1 then
        print("Durability mod version " .. vuxModVersion .. " loaded for game version " .. vuxGameVersion)
    end
    vuxCheckRestart = 1
end)