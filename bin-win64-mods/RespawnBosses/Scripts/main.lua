Player = nil
Controller = nil
Prefix = string.format("^%s", "!")
local config = require("./config")

function SplitCommand(Command)
    local Args = {}
    local Index = 0
    for match in Command:gmatch("%S+") do
        Args[Index] = match
        Index = Index + 1
    end
    return Args
end


RegisterHook("/Script/Pal.PalGameStateInGame:BroadcastChatMessage", function(Context, ChatMessage)
    print("Recieved")
    --print(ChatMessage:get():type())
    local Message = ChatMessage:get().Message:ToString()
    if string.match(Message, Prefix) then
        local MessageNoPrefix = string.sub(Message, 2)
        local CommandArgs = SplitCommand(MessageNoPrefix)
        if string.lower(CommandArgs[0]) == config.ChatCommands.resetBossCommand then
            local InstanceManagers = FindAllOf("PalDungeonInstanceModelFixedDungeon")
            if InstanceManagers ~= nil then
                for indx, manager in pairs(InstanceManagers) do
                    if manager:IsA("/Script/Pal.PalDungeonInstanceModelFixedDungeon") then
                        local id = manager.DungeonInstanceId
                        manager.RespawnBossTimeAt.Ticks = 1
                    end
                end 
            end
        end
        if string.lower(CommandArgs[0]) == config.ChatCommands.respawnFieldBossesCommand then
            local spawners = FindAllOf("BP_PalSpawner_Standard_C")

            if spawners ~= nil then
                for _, spawner in pairs(spawners) do
                    if spawner:IsValid() then
                        if spawner.SpawnerType == 2 then
                            spawner:SpawnRequest_ByOutside(true)
                        end
                    end
                end
            end
        end
    end
end)

RegisterKeyBind(config.KeyBinds.resetbosscooldowns, function()
    local InstanceManagers = FindAllOf("PalDungeonInstanceModelFixedDungeon")
    if InstanceManagers ~= nil then
        for indx, manager in pairs(InstanceManagers) do
            if manager:IsA("/Script/Pal.PalDungeonInstanceModelFixedDungeon") then
                local id = manager.DungeonInstanceId
                manager.RespawnBossTimeAt.Ticks = 1
            end
        end
    end
end)

RegisterKeyBind(config.KeyBinds.respawnfieldbosses, function()
    local spawners = FindAllOf("BP_PalSpawner_Standard_C")

    if spawners ~= nil then
        for _, spawner in pairs(spawners) do
            if spawner:IsValid() then
                if spawner.SpawnerType == 2 then
                    spawner:SpawnRequest_ByOutside(true)
                end
            end
        end
    end
end)

