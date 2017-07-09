local o = WardrobeHelper

---------------------------------------------------------------
--  Methods
---------------------------------------------------------------

local function createMenuItems()
	local ff = WrdHlp_OptionsFrame.blacklist
	ff.menuItems = {}
	for i = 1,#WrdHlpSave.blacklist do
		local n, itemLink = GetItemInfo(WrdHlpSave.blacklist[i])
		table.insert(ff.menuItems, {name = n, id = WrdHlpSave.blacklist[i], link = itemLink})
	end
end

o.GUIblacklistPage = function(N)
  local ff = WrdHlp_OptionsFrame.blacklist
	if ff.menuItems == nil then ff.menuItems = {} end
	ff.N = N
	ff.scrollbar:SetMinMaxValues(1, math.max(#ff.menuItems - ff.numRows + 1, 1))
	local FirstN = ff.N - 1

	for i = 1,ff.numRows do
		local index = i+FirstN
		if ff.menuItems[index] then
			ff.rows[i]:Enable()
			if ff.menuItems[index].name then
			else
				local n, itemLink = GetItemInfo(WrdHlpSave.blacklist[index])
				ff.menuItems[index].name = n
			end
			ff.rows[i].text:SetText(ff.menuItems[index].name or "---")
			ff.rows[i].id = ff.menuItems[index].id
			ff.rows[i].itemLink = ff.menuItems[index].link
			ff.rows[i].index = index
		else
			ff.rows[i].text:SetText("")
			ff.rows[i]:Disable()
		end
	end
end

o.resetSettings = function()
	WrdHlpSave = nil
	o.fixSettings()
	o.GUIfixOptions()
	o.reset()
end

o.GUIfixOptions = function()
	o.GUIshowTabOptions(1)
	WrdHlp_OptionsFrame.hideList:SetChecked(WrdHlpSave.hideList)
	WrdHlp_OptionsFrame.disableProgress:SetChecked(WrdHlpSave.disableProgress)
	WrdHlp_OptionsFrame.hideMinimap:SetChecked(WrdHlpSave.minimap.hide)
	WrdHlp_OptionsFrame.disableConfirmation:SetChecked(WrdHlpSave.disableConfirmation)
	WrdHlp_OptionsFrame.completionistMode:SetChecked(WrdHlpSave.completionistMode)
	WrdHlp_OptionsFrame.hideCompletedInstances:SetChecked(WrdHlpSave.hideCompletedInstances)
	WrdHlp_OptionsFrame.onlyMiniList:SetChecked(WrdHlpSave.onlyMiniList)
	WrdHlp_OptionsFrame.reloadOnStart:SetChecked(WrdHlpSave.reloadOnStart)
	WrdHlp_OptionsFrame.scale:SetText(WrdHlpSave.miniListScale)
	WrdHlp_OptionsFrame.rowCount:SetText(WrdHlpSave.miniListRowCount)
	createMenuItems()
end

o.GUIshowOptions = function()
  WrdHlp_MainFrame:Hide()
  WrdHlp_MainFrame.ItemFrame:Hide()
	o.GUIfixOptions()
	o.GUIblacklistPage(1)
  WrdHlp_OptionsFrame:Show()
end

o.GUIshowTabOptions = function(number)
	WrdHlp_OptionsFrame.tab = number
	for i=1,#WrdHlp_OptionsFrame.tabItems do
		local tab = WrdHlp_OptionsFrame.tabItems[i]
		for j=1,#tab do
			tab[j]:Hide()
		end
	end
	local tab = WrdHlp_OptionsFrame.tabItems[number]
	for i=1,#tab do
		tab[i]:Show()
	end
	for i=1,#WrdHlp_OptionsFrame.tabOptions do
		WrdHlp_OptionsFrame.tabOptions[i].text:SetTextColor(1,1,1,1)
	end
	WrdHlp_OptionsFrame.tabOptions[number].text:SetTextColor(1,0.8,0,1)
end

---------------------------------------------------------------
--  Create UI
---------------------------------------------------------------

local function CreateTableRow(parent, rowHeight, N, text)
	local row = CreateFrame("Button", nil, parent)
	row.id = N
	row:SetHeight(rowHeight)
	row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	row:SetPoint("LEFT")
	row:SetPoint("RIGHT")
	row:SetPoint("TOP", parent, "TOP", 0, -5 - (rowHeight + 2) * (N - 1))
	row:SetScript("OnClick", function()
		o.GUIshowTabOptions(N)
	end)

	local c = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	c:SetHeight(rowHeight)
	c:SetJustifyH("LEFT")
	c:SetPoint("LEFT", row, "LEFT", 7, 0)
	c:SetText(text)
	row.text = c

	return row
end

local fr = CreateFrame("Frame", "WrdHlp_OptionsFrame")
fr.tabItems = {}
fr.tabOptions = {}
fr:Hide()
tinsert(UISpecialFrames, fr:GetName())
fr:SetWidth(500)
fr:SetHeight(400)
fr:SetScale(0.8)
fr:SetPoint("CENTER",UIParent,"CENTER",0,0)
fr:SetFrameStrata("DIALOG")
local h = fr:CreateTexture(nil, "ARTWORK")
h:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
h:SetWidth(500)
h:SetHeight(68)
h:ClearAllPoints()
h:SetPoint("TOP", 0, 15)
fr.HeaderTexture = h
fr.title = fr:CreateFontString(nil, "ARTWORK", "GameFontNormal")
fr.title:SetPoint("TOP", h, "TOP", 0, -15)
fr.title:SetText("Wardrobe Helper (v" .. o.version .. ")")
fr:SetBackdrop(
	{
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = { left=11, right=12, top=12, bottom=11 }
	})
fr:SetScript("OnShow", function()
	PlaySound("igCharacterInfoOpen")
end)
fr:SetScript("OnHide", function()
	PlaySound("igCharacterInfoClose")
end)
fr:SetMovable(true)
fr:EnableMouse(true)
fr:RegisterForDrag("LeftButton")
fr:SetScript("OnDragStart", fr.StartMoving)
fr:SetScript("OnDragStop", fr.StopMovingOrSizing)

local b = CreateFrame("BUTTON", "WrdHlp_OptionsFrame_Close", fr, "UIPanelButtonTemplate")
fr.bClose = b
b:SetText(o.strings["Close"])
b:SetHeight(25)
b:SetWidth(100)
b:SetPoint("BOTTOMRIGHT", fr, "BOTTOMRIGHT", -10, 10)
b:SetScript("OnClick", function()
	fr:Hide()
end)

local b = CreateFrame("BUTTON", "WrdHlp_OptionsFrame_Def", fr, "UIPanelButtonTemplate")
fr.bDef = b
b:SetText(o.strings["Defaults"])
b:SetHeight(25)
b:SetWidth(100)
b:SetPoint("BOTTOMLEFT", fr, "BOTTOMLEFT", 10, 10)
b:SetScript("OnClick", function()
	o.resetSettings()
end)

local panel = CreateFrame("Frame", "WrdHlp_OptionsFrame_Panel", fr)
fr.panel = panel
fr.panel:SetPoint("TOPLEFT", fr, "TOPLEFT", 110, -10)
fr.panel:SetPoint("BOTTOMRIGHT", fr, "BOTTOMRIGHT", -15, 39)

local border = CreateFrame("Frame", nil, panel)
border:SetPoint("TOPLEFT", 1, -27)
border:SetPoint("BOTTOMRIGHT", -1, 3)
border:SetBackdrop({
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 5, bottom = 3 }
})
border:SetBackdropColor(0.1, 0.1, 0.1, 0.5)
border:SetBackdropBorderColor(0.4, 0.4, 0.4)
fr.panel.border = border

local panel = CreateFrame("Frame", "WrdHlp_OptionsFrame_Panel2", fr)
fr.panelSelect = panel
fr.panelSelect:SetPoint("TOPLEFT", fr, "TOPLEFT", 15, -10)
fr.panelSelect:SetPoint("BOTTOMRIGHT", fr.panel, "BOTTOMLEFT", -1, 0)

local border = CreateFrame("Frame", nil, panel)
border:SetPoint("TOPLEFT", 1, -27)
border:SetPoint("BOTTOMRIGHT", -1, 3)
border:SetBackdrop({
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 5, bottom = 3 }
})
border:SetBackdropColor(0.1, 0.1, 0.1, 0.5)
border:SetBackdropBorderColor(0.4, 0.4, 0.4)

fr.tabOptions[1] = CreateTableRow(border, 14, 1, o.strings["General"])
fr.tabOptions[2] = CreateTableRow(border, 14, 2, o.strings["MiniList"])
fr.tabOptions[3] = CreateTableRow(border, 14, 3, o.strings["Blacklist"])
fr.tabOptions[4] = CreateTableRow(border, 14, 4, o.strings["Debug"])

for i=1,#fr.tabOptions do
	fr.tabItems[i] = {}
end

local n = CreateFrame("CheckButton", "WrdHlp_OptionsFrame_HideList", fr.panel.border, "ChatConfigCheckButtonTemplate")
fr.hideList = n
table.insert(fr.tabItems[1], n)
n:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -35)
WrdHlp_OptionsFrame_HideListText:SetText(o.strings["Hide List Option"])
n:SetScript("OnClick", function()
		if n:GetChecked() then
			WrdHlpSave.hideList = true
		else
			WrdHlpSave.hideList = false
		end
	end);

local n = CreateFrame("CheckButton", "WrdHlp_OptionsFrame_DisableProgress", fr.panel.border, "ChatConfigCheckButtonTemplate")
fr.disableProgress = n
table.insert(fr.tabItems[1], n)
n:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -60)
WrdHlp_OptionsFrame_DisableProgressText:SetText(o.strings["Disable Progress"])
n:SetScript("OnClick", function()
		if n:GetChecked() then
			WrdHlpSave.disableProgress = true
		else
			WrdHlpSave.disableProgress = false
		end
	end);

local fs = fr.panel:CreateFontString("WrdHlp_OptionsFrame_DisableProgress_Info","OVERLAY","GameFontNormalSmall")
fr.disableProgressInfo = fs
fs:SetWidth(350)
fs:SetHeight(0)
fs:SetJustifyH("LEFT")
fs:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 30, -80)
fs:SetText(o.strings["Disable Progress Info"])
table.insert(fr.tabItems[1], fs)

local n = CreateFrame("CheckButton", "WrdHlp_OptionsFrame_DisableMinimapButton", fr.panel.border, "ChatConfigCheckButtonTemplate")
fr.hideMinimap = n
table.insert(fr.tabItems[1], n)
n:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -95)
WrdHlp_OptionsFrame_DisableMinimapButtonText:SetText(o.strings["Hide Minimap"])
n:SetScript("OnClick", function()
		if n:GetChecked() then
			WrdHlpSave.minimap.hide = true
		else
			WrdHlpSave.minimap.hide = false
		end
		if WrdHlpSave.minimap.hide then
			o.LDBI:Hide("Wardrobe Helper")
		else
			o.LDBI:Show("Wardrobe Helper")
		end
	end);

local n = CreateFrame("CheckButton", "WrdHlp_OptionsFrame_DisableConfirmation", fr.panel.border, "ChatConfigCheckButtonTemplate")
fr.disableConfirmation = n
table.insert(fr.tabItems[1], n)
n:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -120)
WrdHlp_OptionsFrame_DisableConfirmationText:SetText(o.strings["Disable Confirmation"])
n:SetScript("OnClick", function()
		if n:GetChecked() then
			WrdHlpSave.disableConfirmation = true
		else
			WrdHlpSave.disableConfirmation = false
		end
	end);

local n = CreateFrame("CheckButton", "WrdHlp_OptionsFrame_CompletionistMode", fr.panel.border, "ChatConfigCheckButtonTemplate")
fr.completionistMode = n
table.insert(fr.tabItems[1], n)
n:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -145)
WrdHlp_OptionsFrame_CompletionistModeText:SetText(o.strings["Completionist Mode"])
n:SetScript("OnClick", function()
		if n:GetChecked() then
			WrdHlpSave.completionistMode = true
		else
			WrdHlpSave.completionistMode = false
		end
	end);

local fs = fr.panel:CreateFontString("WrdHlp_OptionsFrame_CompletionistMode_Info","OVERLAY","GameFontNormalSmall");
fr.disableProgressInfo = fs;
fs:SetWidth(350);
fs:SetHeight(0);
fs:SetJustifyH("LEFT");
fs:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 30, -165)
fs:SetText(o.strings["Completionist Mode Info"])
table.insert(fr.tabItems[1], fs)

local n = CreateFrame("CheckButton", "WrdHlp_OptionsFrame_HideCompletedInstances", fr.panel.border, "ChatConfigCheckButtonTemplate")
fr.hideCompletedInstances = n
table.insert(fr.tabItems[1], n)
n:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -180)
WrdHlp_OptionsFrame_HideCompletedInstancesText:SetText(o.strings["Hide Completed Instances"])
n:SetScript("OnClick", function()
		if n:GetChecked() then
			WrdHlpSave.hideCompletedInstances = true
			o.createMenuItems()
		else
			WrdHlpSave.hideCompletedInstances = false
			o.createMenuItems()
		end
	end);

local n = CreateFrame("CheckButton", "WrdHlp_OptionsFrame_ReloadOnStart", fr.panel.border, "ChatConfigCheckButtonTemplate")
fr.reloadOnStart = n
table.insert(fr.tabItems[1], n)
n:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -205)
WrdHlp_OptionsFrame_ReloadOnStartText:SetText(o.strings["Reload on Start"])
n:SetScript("OnClick", function()
		if n:GetChecked() then
			WrdHlpSave.reloadOnStart = true
		else
			WrdHlpSave.reloadOnStart = false
		end
	end)

local n = CreateFrame("CheckButton", "WrdHlp_OptionsFrame_OnlyMiniList", fr.panel.border, "ChatConfigCheckButtonTemplate")
fr.onlyMiniList = n
table.insert(fr.tabItems[2], n)
n:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -35)
WrdHlp_OptionsFrame_OnlyMiniListText:SetText(o.strings["Only Minilist"])
n:SetScript("OnClick", function()
		if n:GetChecked() then
			WrdHlpSave.onlyMiniList = true
		else
			WrdHlpSave.onlyMiniList = false
		end
	end)

local fs = fr.panel:CreateFontString("WrdHlp_OptionsFrame_Scale_Info","OVERLAY","GameFontNormalSmall")
fs:SetWidth(300)
fs:SetHeight(0)
fs:SetJustifyH("LEFT")
fs:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -70)
fs:SetText(o.strings["Scale"] .. " (" .. o.strings["Press Enter to Save"] .. "):")
table.insert(fr.tabItems[2], fs)

local b = CreateFrame("EditBox", "WrdHlp_OptionsFrame_Scale", fr.panel.border, "InputBoxTemplate")
table.insert(fr.tabItems[2], b)
fr.scale = b
b:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 20, -80)
b:SetHeight(25)
b:SetWidth(120)
b:SetTextInsets(0,0,3,3)
b:SetMaxLetters(256)
b:SetAutoFocus(false)
b:SetScript("OnEnterPressed", function(self)
	local val = tonumber(self:GetText())
	if val ~= nil then
		if val <= 0 then
			val = 0.1
		end
		if val > 5 then
			val = 5
		end
		WrdHlpSave.miniListScale = val
		WrdHlp_MiniList:SetScale(val)
	end
	b:SetText(WrdHlpSave.miniListScale)
	b:ClearFocus()
end)
b:SetScript("OnEscapePressed", function()
	b:SetText(WrdHlpSave.miniListScale)
	b:ClearFocus()
end)

local fs = fr.panel:CreateFontString("WrdHlp_OptionsFrame_RowCount_Info","OVERLAY","GameFontNormalSmall")
fs:SetWidth(300)
fs:SetHeight(0)
fs:SetJustifyH("LEFT")
fs:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -120)
fs:SetText(o.strings["Row count"] .. " (" .. o.strings["Press Enter to Save"] .. "):")
table.insert(fr.tabItems[2], fs)

local b = CreateFrame("EditBox", "WrdHlp_OptionsFrame_RowCount", fr.panel.border, "InputBoxTemplate")
table.insert(fr.tabItems[2], b)
fr.rowCount = b
b:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 20, -130)
b:SetHeight(25)
b:SetWidth(120)
b:SetTextInsets(0,0,3,3)
b:SetMaxLetters(256)
b:SetAutoFocus(false)
b:SetScript("OnEnterPressed", function(self)
	local val = tonumber(self:GetText())
	if val ~= nil then
		if val <= 1 then
			val = 1
		end
		if val > 100 then
			val = 100
		end
		val = math.floor(val)
		WrdHlpSave.miniListRowCount = val
		WrdHlp_MiniList:SetRowCount(val)
		o.GUIopenMiniList(nil, nil, nil, true)
	end
	b:SetText(WrdHlpSave.miniListRowCount)
	b:ClearFocus()
end)
b:SetScript("OnEscapePressed", function()
	b:SetText(WrdHlpSave.miniListRowCount)
	b:ClearFocus()
end)

local fs = fr.panel:CreateFontString("WrdHlp_OptionsFrame_Debug_Info","OVERLAY","GameFontNormalSmall")
fs:SetWidth(300)
fs:SetHeight(0)
fs:SetJustifyH("LEFT")
fs:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -35)
fs:SetText(o.strings["Debug Info"])
table.insert(fr.tabItems[4], fs)

local fs = fr.panel:CreateFontString("WrdHlp_OptionsFrame_Blacklist_Info","OVERLAY","GameFontNormalSmall")
fs:SetWidth(300)
fs:SetHeight(0)
fs:SetJustifyH("LEFT")
fs:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -35)
fs:SetText(o.strings["Blacklist Info"])
table.insert(fr.tabItems[3], fs)

local function CreateTableRow(parent, rowHeight, N)
  local row = CreateFrame("Button", nil, parent)
	row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	row.id = N
  row:SetHeight(rowHeight)
  row:SetPoint("LEFT")
  row:SetPoint("RIGHT", parent, "RIGHT", -16, 0)

	row:SetScript("OnEnter", function()
      if(row.id) then
        GameTooltip_SetDefaultAnchor(GameTooltip, row)
  			GameTooltip:ClearLines()
				GameTooltip:SetItemByID(row.id)
  			GameTooltip:ClearAllPoints()
  			GameTooltip:SetPoint("BOTTOMLEFT", row, "TOPLEFT")
  			GameTooltip:Show();
      end
		end)

	row:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)

	local c = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  c:SetHeight(rowHeight)
  c:SetWidth(row:GetWidth() - 2 * 5)
  c:SetJustifyH("LEFT")
  c:SetPoint("LEFT", row, "LEFT", 5, 0)
	c:SetText('test')
	local filename, fontHeight, flags = c:GetFont()
	c:SetFont(filename, fontHeight, "OUTLINE")
	row.text = c

	row:SetScript("OnClick", function()
			for i=#WrdHlpSave.blacklist,1,-1 do
				if(WrdHlpSave.blacklist[i] == row.id) then
					table.remove(WrdHlpSave.blacklist, i)
				end
			end
      print(string.format(o.strings["Item removed from blacklist"], row.itemLink .. "|cFFFF7D0A"))
			row:Disable()
			row.text:SetText("")
			row.id = nil
			row.itemLink = nil
			o.reset()
			createMenuItems()
			o.GUIblacklistPage(ff.N)
		end)

  return row
end

local ff = CreateFrame("FRAME", "WrdHlp_Options_BlackListList", fr.panel)
table.insert(fr.tabItems[3], ff)
ff:SetPoint("TOPLEFT", WrdHlp_OptionsFrame_Blacklist_Info, "BOTTOMLEFT",0,-10)
ff:SetPoint("BOTTOMRIGHT", fr.panel, "BOTTOMRIGHT",-10,35)
fr.blacklist = ff

local t = ff:CreateTexture(nil, "ARTWORK")
ff.bg = t
t:SetColorTexture(0,0,0,0.8)
t:SetAllPoints(ff)

ff:EnableMouseWheel(true)
ff:SetScript("OnMouseWheel", function(self, delta)
	  if ff.N - delta > 0 and ff.N - delta < #ff.menuItems + 1 then
	  	ff.scrollbar:SetValue(ff.N - delta)
	  end
end)

local scrollbar = CreateFrame("Slider", nil, ff, "UIPanelScrollBarTemplate")
scrollbar:SetPoint("TOPRIGHT", ff, "TOPRIGHT", 0, -18)
scrollbar:SetPoint("BOTTOMRIGHT", ff, "BOTTOMRIGHT", 0, 16)
scrollbar:SetMinMaxValues(1, 1)
scrollbar:SetValueStep(1)
scrollbar.scrollStep = 1
scrollbar:SetWidth(16)
scrollbar:SetScript("OnValueChanged", function(self, value)
	o.GUIblacklistPage(math.floor(value + 0.5))
end)
ff.scrollbar = scrollbar

local fontHeight = select(2, GameFontNormalSmall:GetFont())
local rowHeight = fontHeight + 4
local numRows = math.floor(ff:GetHeight() / rowHeight)
ff.rowHeight = rowHeight
ff.numRows = numRows
ff.rows = {}
ff.N = 1

for i=1,numRows do
	local r = CreateTableRow(ff, rowHeight, i)
	if #ff.rows == 0 then
		r:SetPoint("TOP")
	else
		r:SetPoint("TOP", ff.rows[#ff.rows], "BOTTOM")
	end
	table.insert(ff.rows, r)
end
