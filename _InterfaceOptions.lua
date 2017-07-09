local f = CreateFrame("FRAME", "WrdHlp_OptionsFrame_Interface")
f.name = "Wardrobe Helper"

f.TextTitle = f:CreateFontString("WrdHlp_OptionsFrame_TextTitle", "ARTWORK", "GameFontNormalLarge")
f.TextTitle:SetPoint("TOPLEFT", 16, -16)
f.TextTitle:SetJustifyH("LEFT")
f.TextTitle:SetJustifyV("TOP")
f.TextTitle:SetText("Wardrobe Helper")

f.ButtonOptions = CreateFrame("Button", "WrdHlp_OptionsFrame_ButtonOptions", f, "UIPanelButtonTemplate")
f.ButtonOptions:SetText(WardrobeHelper.strings["Open Options"])
f.ButtonOptions:SetWidth(100)
f.ButtonOptions:SetHeight(25)
f.ButtonOptions:SetPoint("TOPLEFT", 16, -43)
f.ButtonOptions:SetScript("OnClick", function()
	WardrobeHelper.GUIshowOptions()
end)

InterfaceOptions_AddCategory(f)
