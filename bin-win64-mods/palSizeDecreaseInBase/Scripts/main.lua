local not_hooked = true

RegisterHook("/Script/Engine.PlayerController:ServerAcknowledgePossession", function (Context)
    if not_hooked then
        RegisterHook("/Game/Pal/Blueprint/Controller/AIAction/BaseCamp/SummonPal/BP_AIAction_SummonPal.BP_AIAction_SummonPal_C:OnSummon", function(self)
            local controller = self:get()
            local pal = controller:GetCharacter()
            if pal then
                local pal_params = pal.CharacterParameterComponent
                local current_size = pal_params:GetSize()
                if current_size then
                    pal_params:SetSize(current_size * 0.5)
                end
            end
        end)
        not_hooked = false
    end
end)
