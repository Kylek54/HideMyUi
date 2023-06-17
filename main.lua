local settingList = {
    {
        UiElement = "minimap", -- Placeholder for the actual Minimap reference
        IsEnabled = true,
    },
    {
        UiElement = "questlog", -- Placeholder for the actual QuestLog reference
        IsEnabled = true
    }
}

local function SettingListHandler(namedUiElement)

    if namedUiElement == ""  then
        print('Setting List')

        for setting = 1, #settingList do
            local uiElement = settingList[setting].UiElement
            local isEnabled = settingList[setting].IsEnabled

            print(uiElement .. ": ", isEnabled)
        end
    else
        for setting = 1, #settingList do
            local UiElement = settingList[setting].UiElement
            local IsEnabled = settingList[setting].IsEnabled

            if UiElement == namedUiElement then
                settingList[setting].IsEnabled = not settingList[setting].IsEnabled
                print(namedUiElement .. " has been toggled")
                return
            end
        end
        
        print(namedUiElement .. " has not been found!")
    end
end

--

--local INSTANCE = IsInInstance() 
--if INSTANCE == true then
--    MinimapCluster:Hide()
--    Minimap:Hide()
--    QuestLog:Hide()
--elseif INSTANCE == false then
--end

SLASH_HIDEMYUI1 = "/hidemyui"
SLASH_HIDEMYUI2 = "/hmi"
SlashCmdList["HIDEMYUI"] = SettingListHandler