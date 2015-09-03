--
-- FrameXML/ActionButton.lua : ActionButton_UpdateHotkeys
--

local x, BinderLabels = ...

if not _G["Binder"] then error("Binder is required for BinderLabels!") end

function BinderLabels:GetTextFor(button_action)
    spellType, spellId, _ = GetActionInfo(button_action);
    if ( spellType == "spell" ) then
        local spellName, _, _, _, _, _, _ = GetSpellInfo(spellId);
        text = _G["Binder"]:GetKeyForAction(spellName);
        text = string.gsub(text, "CTRL", "C");
        text = string.gsub(text, "SHIFT", "S");
        return text;
    end
    return ""
end

hooksecurefunc("ActionButton_Update", function(btn)
    actionName = _G[btn:GetName().."Name"]
    if actionName then
        actionName:SetText ( BinderLabels:GetTextFor(btn.action) )
    end
end)
