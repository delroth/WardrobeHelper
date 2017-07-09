if mOnAr_OptionsFrameGeneral == nil then
	mOnAr_OptionsFrameGeneral = CreateFrame("FRAME", "mOnAr_OptionsFrameGeneral")
	mOnAr_OptionsFrameGeneral.name = "mOnAr's Addons"
	InterfaceOptions_AddCategory(mOnAr_OptionsFrameGeneral)

	mOnAr_OptionsFrameGeneral.TextTitle = mOnAr_OptionsFrameGeneral:CreateFontString("mOnAr_OptionsFrameGeneral_TextTitle", "ARTWORK", "GameFontNormalLarge")
	mOnAr_OptionsFrameGeneral.TextTitle:SetPoint("TOPLEFT", 16, -16)
	mOnAr_OptionsFrameGeneral.TextTitle:SetJustifyH("LEFT")
	mOnAr_OptionsFrameGeneral.TextTitle:SetJustifyV("TOP")
	mOnAr_OptionsFrameGeneral.TextTitle:SetText("mOnAr's Addons Options")

	mOnAr_OptionsFrameGeneral.TextSub = mOnAr_OptionsFrameGeneral:CreateFontString("mOnAr_OptionsFrameGeneral_TextSub", "ARTWORK", "GameFontHighlightSmall")
	mOnAr_OptionsFrameGeneral.TextSub:SetPoint("TOPLEFT", "mOnAr_OptionsFrameGeneral_TextTitle", "BOTTOMLEFT", 0, -8)
	mOnAr_OptionsFrameGeneral.TextSub:SetPoint("RIGHT", -32, 0)
	mOnAr_OptionsFrameGeneral.TextSub:SetJustifyH("LEFT")
	mOnAr_OptionsFrameGeneral.TextSub:SetJustifyV("TOP")
	mOnAr_OptionsFrameGeneral.TextSub:SetHeight(24)
	mOnAr_OptionsFrameGeneral.TextSub:SetText("This category contains Settings for every addon made by mOnAr (Seamoon)")
end
