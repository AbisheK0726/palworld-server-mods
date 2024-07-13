-- Author: @wjmme

RegisterKeyBind(Key.F8, {}, function()
    local breed = FindAllOf("PalMapObjectBreedFarmModel")
    if breed then
        for Index, m in pairs(breed) do
          if m:CanProceedBreeding() then
            print(string.format("%s/%s\n", m.BreedProgressTime, m.BreedRequiredRealTime))
            m.BreedProgressTime = m.BreedRequiredRealTime
          end
        end
    end
  end)