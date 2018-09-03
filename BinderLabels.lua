--
-- FrameXML/ActionButton.lua : ActionButton_UpdateHotkeys
--

local x, BinderLabels = ...

if not _G["Binder"] then error("Binder is required for BinderLabels!") end

function BinderLabels:GetTextFor(button_action)
    spellType, spellId, _ = GetActionInfo(button_action);
    if ( spellType == "spell" or spellType == "item" ) then
        local spellName, _, _, _, _, _, _ = GetSpellInfo(spellId);
        text = _G["Binder"]:GetKeyForAction(spellName);
        text = string.gsub(text, "ALT", "A");
        text = string.gsub(text, "CTRL", "C");
        text = string.gsub(text, "SHIFT", "S");
        return text;
    end
    return ""
end

function updateButtonTextBliz(btn)
    if btn.Name then
        btn.Name:SetText(BinderLabels:GetTextFor(btn.action))
    end
end

function updateButtonTextLibActionButton(event, btn)
    if btn then
        btn.HotKey:SetText("")
        if btn:HasAction() then
            local _, action = btn:GetAction()
            btn.HotKey:SetText(BinderLabels:GetTextFor(action))
        end
        btn.HotKey:Show()
    end
end

-- Make Blizzard Action Bar Buttons show Binder keys
hooksecurefunc("ActionButton_Update", updateButtonTextBliz)

-- Make LibActionBar-1.0 Action Bar Buttons show Binder keys
local LibStub = _G["LibStub"]
if LibStub and (LibStub.libs["LibActionButton-1.0"] or LibStub.libs["LibActionButton-1.0-ElvUI"]) then
    local LAB = LibStub.libs["LibActionButton-1.0"]
    if not LAB then
        LAB = LibStub.libs["LibActionButton-1.0-ElvUI"]
    end
    LAB:RegisterCallback("OnButtonCreated", updateButtonTextLibActionButton)
    LAB:RegisterCallback("OnButtonUpdate", updateButtonTextLibActionButton)
end
