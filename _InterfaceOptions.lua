if mOnAr_OptionsFrameGeneral then
	local f = CreateFrame("FRAME", "mOnWD_OptionsFrame_Interface")
	f.name = "Wardrobe Helper"
	f.parent = "mOnAr's Addons"

	f.TextTitle = f:CreateFontString("mOnWD_OptionsFrame_TextTitle", "ARTWORK", "GameFontNormalLarge")
	f.TextTitle:SetPoint("TOPLEFT", 16, -16)
	f.TextTitle:SetJustifyH("LEFT")
	f.TextTitle:SetJustifyV("TOP")
	f.TextTitle:SetText("mOnAr's Wardrobe Helper")

	f.ButtonOptions = CreateFrame("Button", "mOnWD_OptionsFrame_ButtonOptions", f, "UIPanelButtonTemplate")
	f.ButtonOptions:SetText(mOnWardrobe.strings["Open Options"])
	f.ButtonOptions:SetWidth(100)
	f.ButtonOptions:SetHeight(25)
	f.ButtonOptions:SetPoint("TOPLEFT", 16, -43)
	f.ButtonOptions:SetScript("OnClick", function()
		mOnWardrobe.GUIshowOptions()
	end)

	InterfaceOptions_AddCategory(f)
end
