local settingList = {
    {
        UiElement = "minimap", -- Placeholder for the actual Minimap reference
        WowApiName = "MinimapCluster",
        IsEnabled = true,
        ToggleState = true
    },
    {
        UiElement = "micromenu", -- Placeholder for the actual Minimap reference
        WowApiName = "MicroMenu",
        IsEnabled = true,
        ToggleState = true
    },
    {
        UiElement = "bag", -- Placeholder for the actual Minimap reference
        WowApiName = "BagsBar",
        IsEnabled = true,
        ToggleState = true
    },
    {
        UiElement = "questlog", -- Placeholder for the actual Quest Log reference
        WowApiName = "ObjectiveTrackerBlocksFrame",
        IsEnabled = true,
        ToggleState = true 
    }
}

local globalToggle = false

local function IsPlayerInInstance()
    local inInstance, instanceType = IsInInstance()
    return inInstance and (instanceType == "party" or instanceType == "raid")
end

local function CheckInstanceStatus()
    if IsPlayerInInstance() and globalToggle == true then
        for setting = 1, #settingList do
            local IsEnabled = settingList[setting].IsEnabled
            local frame = _G[settingList[setting].WowApiName]

            if frame then
                if IsEnabled then
                    frame:Hide()
                else
                    frame:Show()
                end
            end
        end
    else
        for setting = 1, #settingList do
            local frame = _G[settingList[setting].WowApiName]

            if frame then
                frame:Show()
            end
        end
    end
end

local function ToggleHideMyUi()
    if globalToggle then
        print('Hide My UI Disabled!')
        globalToggle = false
        CheckInstanceStatus()
    else
        print('Hide My Ui Enabled!')
        globalToggle = true
    end
    CheckInstanceStatus()
end

local function SettingListHandler(namedUiElement)

    if namedUiElement == "toggle" then
        ToggleHideMyUi()
        return 
    end
    if namedUiElement == "" then
        print('Setting List')

        for setting = 1, #settingList do
            local uiElement = settingList[setting].UiElement
            local isEnabled = settingList[setting].IsEnabled

            print(uiElement .. ": ", isEnabled)
            endCheckInstanceStatus()
        end
    else
        for setting = 1, #settingList do
            local UiElement = settingList[setting].UiElement
            local IsEnabled = settingList[setting].IsEnabled

            if UiElement == namedUiElement then
                settingList[setting].IsEnabled = not settingList[setting].IsEnabled
                print(namedUiElement .. " has been toggled")
                CheckInstanceStatus()
                return
            end
        end

        print(namedUiElement .. " has not been found!")
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", CheckInstanceStatus)

SLASH_HIDEMYUI1 = "/hidemyui"
SLASH_HIDEMYUI2 = "/hmu"
SlashCmdList["HIDEMYUI"] = SettingListHandler
