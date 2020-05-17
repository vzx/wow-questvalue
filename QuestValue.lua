-- Copyright © 2020 vzx8. All rights reserved.
-- Licensed under GPLv3 (see license.txt).

local frame = CreateFrame("Frame")
frame:RegisterEvent("QUEST_COMPLETE")
frame:SetScript("OnEvent", function(self, event, ...)
    local num = GetNumQuestChoices()
    if num == nil or num < 2 then
        return
    end

    local maxSellPrice = -1
    local mostExpensiveItemIndex = -1
    local mostExpensiveItemLink = nil
    for x = 1, num do
        local link = GetQuestItemLink("choice", x)
        if link == nil then
            return
        end

        local _, _, _, _, _, _, _, _, _, _, sellPriceInCopper = GetItemInfo(link)
        if sellPriceInCopper ~= nil and sellPriceInCopper > maxSellPrice then
            maxSellPrice = sellPriceInCopper
            mostExpensiveItemIndex = x
            mostExpensiveItemLink = link
        end
    end

    if mostExpensiveItemIndex < 1 then
        return
    end

    local rewardButton = _G["QuestInfoRewardsFrameQuestInfoItem"..mostExpensiveItemIndex]
    if rewardButton == nil or rewardButton.type ~= "choice" then
        return
    end
    
    QuestInfoItemHighlight:SetPoint("TOPLEFT", rewardButton, "TOPLEFT", -8, 7)
    QuestInfoItemHighlight:Show()
    QuestInfoFrame.itemChoice = rewardButton:GetID()
end)
