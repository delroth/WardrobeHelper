local o = mOnWardrobe

---------------------------------------------------------------
--  Initialization
---------------------------------------------------------------

o.CURRENT_PAGE = 1

---------------------------------------------------------------
--  Create UI
---------------------------------------------------------------

mOnWD_MainFrame = CreateFrame("FRAME","mOnWD_MainFrame",UIParent,"ButtonFrameTemplate");
mOnWD_MainFrameTitleText:SetText("mOnAr's Wardrobe Helper (v" .. o.version .. ")");
local f = mOnWD_MainFrame;
f:SetHeight(512);
f:SetWidth(384);
f:Hide();
tinsert(UISpecialFrames,"mOnWD_MainFrame");
f:SetFrameStrata("high");
f:SetPoint("CENTER",0,0);
f:SetMovable(true);
f:EnableMouse(true);
f:SetClampedToScreen(true);
f:RegisterForDrag("LeftButton");
f:SetScript("OnDragStart", f.StartMoving)
f:SetScript("OnDragStop", f.StopMovingOrSizing)
SetPortraitToTexture(mOnWD_MainFramePortrait, "Interface\\Icons\\INV_Chest_Cloth_17");

local f=CreateFrame("FRAME",nil,mOnWD_MainFrame);
mOnWD_MainFrame.ListFrame = f;
f:SetHeight(512);
f:SetWidth(384);
f:EnableMouse(false);
f:SetAllPoints(mOnWD_MainFrame);

local b = CreateFrame("BUTTON","mOnWD_MainFrame_bRefresh",f,"UIPanelButtonTemplate")
f.bRefresh = b;
b:SetPoint("TOPRIGHT",-10,-35);
b:SetText(o.strings["Refresh Items"])
b:SetHeight(25);
b:SetWidth(120);
b:SetScript("OnClick", function()
	if mOnWDSave.disableConfirmation then
		if mOnWD_MainFrame.ItemFrame then
			mOnWD_MainFrame.ItemFrame:Hide()
		end
		o.updateMissingVisuals()
	else
		StaticPopup_Show ("MONWD_CONFIRMATION")
	end
	end)

local b = CreateFrame("BUTTON","mOnWD_MainFrame_bCurrentInstance",f,"UIPanelButtonTemplate");
f.bInstance = b;
b:SetPoint("RIGHT", mOnWD_MainFrame_bRefresh, "LEFT", -10, 0);
b:SetText(o.strings["Current Instance"])
b:SetHeight(25);
b:SetWidth(120);
b:SetScript("OnClick", function()
		o.GUIcurrentInstance()
	end)

local ff = CreateFrame("FRAME",nil,f);
ff:Show();
f.RowFrame = ff;
ff:SetPoint("TOPLEFT",8,-94);
ff:SetWidth(367);
ff:SetHeight(390);

local st = ff:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
st:SetHeight(380)
st:SetWidth(300)
st:SetJustifyH("CENTER")
st:SetPoint("TOP", ff, "TOP", 0, -10)
st:SetText(string.format(o.strings["Click Refresh Info"], o.strings["Refresh Items"]))
st:Hide();
local filename, fontHeight, flags = st:GetFont()
st:SetFont(filename, 20, "")
f.info = st

local st = ff:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
st:SetHeight(380)
st:SetWidth(300)
st:SetJustifyH("CENTER")
st:SetPoint("TOP", ff, "TOP", 0, 100)
st:SetText("");
st:Hide();
local filename, fontHeight, flags = st:GetFont()
st:SetFont(filename, 15, "")
f.specialMessage = st;

local t = ff:CreateTexture(nil, "BACKGROUND");
ff.BG = t;
t:SetColorTexture(0,0,0,0.4);
t:SetAllPoints(ff);

local t = f:CreateTexture(nil, "ARTWORK");
f.ColL1 = t;
t:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
t:SetPoint("TOPLEFT",6,-70);
t:SetTexCoord(0,0.078125,0,0.75);
t:SetWidth(5);
t:SetHeight(24);

local t = f:CreateTexture(nil, "ARTWORK");
f.ColM1 = t;
t:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
t:SetPoint("LEFT",f.ColL1,"RIGHT");
t:SetTexCoord(0.078125,0.90625,0,0.75);
t:SetWidth(120);
t:SetHeight(24);

local t = f:CreateTexture(nil, "ARTWORK");
f.ColR1 = t;
t:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
t:SetPoint("LEFT",f.ColM1,"RIGHT");
t:SetTexCoord(0.90625,0.96875,0,0.75);
t:SetWidth(4);
t:SetHeight(24);

local fs = f:CreateFontString(nil, "ARTWORK","GameFontNormalSmall");
f.ColT1 = fs;
fs:SetText(o.strings["Progress"]);
fs:SetPoint("LEFT",f.ColL1, 10, 0);

local t = f:CreateTexture(nil, "ARTWORK");
f.ColL2 = t;
t:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
t:SetPoint("Left",f.ColR1,10,0);
t:SetTexCoord(0,0.078125,0,0.75);
t:SetWidth(5);
t:SetHeight(24);

local t = f:CreateTexture(nil, "ARTWORK");
f.ColM2 = t;
t:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
t:SetPoint("LEFT",f.ColL2,"RIGHT");
t:SetTexCoord(0.078125,0.90625,0,0.75);
t:SetWidth(220);
t:SetHeight(24);

local t = f:CreateTexture(nil, "ARTWORK");
f.ColR2 = t;
t:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
t:SetPoint("LEFT",f.ColM2,"RIGHT");
t:SetTexCoord(0.90625,0.96875,0,0.75);
t:SetWidth(4);
t:SetHeight(24);

local fs = f:CreateFontString(nil, "ARTWORK","GameFontNormalSmall")
f.ColT2 = fs
fs:SetText(o.strings["Instance"])
fs:SetPoint("LEFT",f.ColL2, 10, 0)

local function CreateTableRow(parent, rowHeight, N)
  local row = CreateFrame("Button", nil, parent)
  row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	row.id = N
  row:SetHeight(rowHeight)
	row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  row:SetPoint("LEFT")
  row:SetPoint("RIGHT", parent, "RIGHT", -16, 0)
	row:SetScript("OnClick", function(self, button)
		-- ** HgD CODE CHANGES START HERE ** --
		if button == "LeftButton" and IsShiftKeyDown() then
			if mOnWDSave.favoriteInstances[row.text2:GetText()] == 1 or mOnWDSave.favoriteInstances[row.text2:GetText()] == true then
				mOnWDSave.favoriteInstances[row.text2:GetText()] = nil
			elseif mOnWDSave.favoriteInstances[row.text2:GetText()] ~= nil then
				mOnWDSave.favoriteInstances[row.text2:GetText()] = mOnWDSave.favoriteInstances[row.text2:GetText()] - 1
			else
				mOnWDSave.favoriteInstances[row.text2:GetText()] = 8
			end
			o.GUIpagingHelper(o.CURRENT_PAGE)
		elseif button == "LeftButton" then
			o.GUIselect(row.text2:GetText())
		end

		if button == "RightButton" and IsShiftKeyDown() then
			if mOnWDSave.favoriteInstances[row.text2:GetText()] == 8 then
				mOnWDSave.favoriteInstances[row.text2:GetText()] = nil
			elseif mOnWDSave.favoriteInstances[row.text2:GetText()] ~= nil then
				if mOnWDSave.favoriteInstances[row.text2:GetText()] == true then mOnWDSave.favoriteInstances[row.text2:GetText()] = 1 end
				mOnWDSave.favoriteInstances[row.text2:GetText()] = mOnWDSave.favoriteInstances[row.text2:GetText()] + 1
			else
				mOnWDSave.favoriteInstances[row.text2:GetText()] = 1
			end
			o.GUIpagingHelper(o.CURRENT_PAGE)
		end
		-- ** HgD CODE CHANGES END HERE ** --
	end)

	row:SetScript("OnEnter", function()
			if o.instances[row.text2:GetText()] then
				local count = 0
			  for k, v in pairs(o.instances[row.text2:GetText()]['difficulties']) do count = count + 1 end
			  if count > 1 then
					GameTooltip_SetDefaultAnchor(GameTooltip, row)
					GameTooltip:ClearLines()
					GameTooltip:ClearAllPoints()
					GameTooltip:SetPoint("BOTTOMLEFT", row, "TOPLEFT")
					GameTooltip:AddLine(o.strings["Progress"]..":", 0.4, 0.4, 1)
					for k, v in orderedPairs(o.instances[row.text2:GetText()]['difficulties']) do
						local total = o.instances[row.text2:GetText()]['difficulties'][k]['total']
						local collected = o.instances[row.text2:GetText()]['difficulties'][k]['collected']
						local percent = math.floor((collected / total * 100) + 0.5)
						if total == 0 or percent > 100 then percent = 100 end
						GameTooltip:AddDoubleLine(k, mOnWDSave.disableProgress and total or (collected .. " / " .. total) .. " (" .. percent .. "%)")
					end
					GameTooltip:Show()
				end
			end
		end)

	row:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)



	local c = CreateFrame("StatusBar", nil, row)
	c:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar", "BACKGROUND")
	c:GetStatusBarTexture():SetHorizTile(false)
	c:SetMinMaxValues(0, 100)
	c:SetValue(100)
	c:SetWidth(100)
	c:SetHeight(10)
	c:SetPoint("LEFT",row,"LEFT", 10, 0)
	c:SetStatusBarColor(0,1,0)
	row.status = c

	local c = c:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	c:SetHeight(rowHeight)
	c:SetWidth(110 - (2 * 10))
	c:SetJustifyH("LEFT")
	c:SetPoint("LEFT", row, "LEFT", 20, 0)
	c:SetText('')
	local filename, fontHeight, flags = c:GetFont()
	c:SetFont(filename, fontHeight, "OUTLINE")
	row.text1 = c

	local c = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	c:SetHeight(rowHeight)
	c:SetWidth(220 - (2 * 10))
	c:SetJustifyH("LEFT")
	c:SetPoint("LEFT", row.text1, "RIGHT", 2 * 10, 0)
	c:SetText('')
	row.text2 = c

	local c = row:CreateTexture(nil, "ARTWORK")
	c:SetTexture("Interface\\FriendsFrame\\StatusIcon-DnD")
	c:SetWidth(16)
	c:SetHeight(16)
	c:SetPoint("RIGHT", row.text2, "LEFT", -2,0)
	c:Hide()
	row.saved = c

	-- ** HgD CODE CHANGES START HERE ** --
	--[[local c = row:CreateTexture(nil, "ARTWORK", nil)
	c:SetTexture("Interface\\Common\\ReputationStar")
	c:SetTexCoord(0, 0.5, 0, 0.5)
	c:SetWidth(16)
	c:SetHeight(16)
	c:SetPoint("RIGHT", row.saved, "LEFT", 2,0)
	c:Hide()
	row.star = c]]--

	local c = row.status:CreateTexture(nil, "OVERLAY")
	c:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_1")
	c:SetWidth(14)
	c:SetHeight(14)
	c:SetPoint("RIGHT", row.saved, "LEFT", 2,0)
	c:Hide()
	row.icon = c
	-- ** HgD CODE CHANGES END HERE ** --

	local c = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	c:SetHeight(rowHeight)
	c:SetWidth(100)
	c:SetJustifyH("RIGHT")
	c:SetPoint("RIGHT", row, "RIGHT", -10, 0)
	c:SetText('')
	row.percent = c

  return row
end

local fontHeight = select(2, GameFontNormalSmall:GetFont())
local rowHeight = fontHeight + 4
local numRows = math.floor(ff:GetHeight() / rowHeight)
ff.rowHeight = rowHeight
ff.numRows = numRows;
ff.rows = {}

for i=1,numRows do
	local r = CreateTableRow(ff, rowHeight, i)
	if #ff.rows == 0 then
		r:SetPoint("TOP")
	else
		r:SetPoint("TOP", ff.rows[#ff.rows], "BOTTOM")
	end
	table.insert(ff.rows, r)
end

f:EnableMouseWheel(true)
f:SetScript("OnMouseWheel", function(self, delta)
	if o.CURRENT_PAGE - delta > 0 and o.CURRENT_PAGE - delta < #o.menuItems + 1 then
		f.scrollbar:SetValue(o.CURRENT_PAGE - delta)
	end
end)

local scrollbar = CreateFrame("Slider", nil, ff, "UIPanelScrollBarTemplate")
scrollbar:SetPoint("TOPRIGHT", ff, "TOPRIGHT", 0, 10)
scrollbar:SetPoint("BOTTOMRIGHT", ff, "BOTTOMRIGHT", 0, 16)
scrollbar:SetMinMaxValues(1, 1)
scrollbar:SetValueStep(1)
scrollbar.scrollStep = 1
scrollbar:SetWidth(16)
scrollbar:SetScript("OnValueChanged", function(self, value)
	o.GUIpagingHelper(math.floor(value + 0.5))
end)
f.scrollbar = scrollbar

local c = scrollbar:CreateTexture(nil, "BACKGROUND");
c:SetColorTexture(0,0,0,0.8)
c:SetAllPoints(scrollbar);
scrollbar.background = c;

local n = CreateFrame("CheckButton", "mOnWD_hideList", mOnWD_MainFrame, "ChatConfigCheckButtonTemplate")
mOnWD_MainFrame.hideList = n
n:SetPoint("BOTTOMLEFT", mOnWD_MainFrame, 5, 2)
mOnWD_hideListText:SetText(o.strings["Hide List Option"])
n:SetScript("OnClick", function()
		if n:GetChecked() then
			mOnWDSave.hideList = true
		else
			mOnWDSave.hideList = false
		end
	end);

local b = CreateFrame("Button", nil, mOnWD_MainFrame)
mOnWD_MainFrame.tutorial = b
b:SetPoint("BOTTOMRIGHT", mOnWD_MainFrame, 0, -6)
b:SetWidth(40)
b:SetHeight(40)
b:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD")
local t = b:CreateTexture(nil, "BACKGROUND")
t.BG = t
t:SetTexture("Interface\\common\\help-i")
t:SetAllPoints(b)
b:SetScript("OnEnter", function()
	GameTooltip_SetDefaultAnchor(GameTooltip, b)
	GameTooltip:ClearLines()
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("BOTTOMRIGHT", b, "TOPRIGHT")
	GameTooltip:AddLine(o.strings["Help"])
	GameTooltip:AddDoubleLine(o.strings["Left Click"], o.strings["Main LeftClick Help"])
	GameTooltip:AddDoubleLine(o.strings["Shift"] .. " + " .. o.strings["Right Click"], o.strings["Main Shift RightClick Help"])
	GameTooltip:AddDoubleLine(o.strings["Shift"] .. " + " .. o.strings["Left Click"], o.strings["Main Shift LeftClick Help"])
	GameTooltip:Show()
end)
b:SetScript("OnLeave", function()
	GameTooltip:Hide()
end)

local b = CreateFrame("Button", nil, mOnWD_MainFrame)
mOnWD_MainFrame.bOptions = b
b:SetPoint("TOPRIGHT", mOnWD_MainFrame, -30, -2)
b:SetWidth(20)
b:SetHeight(20)
b:SetHighlightTexture("Interface\\Buttons\\UI-OptionsButton", "ADD")
local t = b:CreateTexture(nil, "BACKGROUND")
t.BG = t
t:SetTexture("Interface\\Buttons\\UI-OptionsButton")
t:SetAllPoints(b)
b:SetScript("OnClick", function()
		o.GUIshowOptions()
	end)


StaticPopupDialogs["MONWD_CONFIRMATION"] = {
  text = o.strings["Refresh Confirmation"],
  button1 = o.strings["Yes"],
  button2 = o.strings["No"],
  OnAccept = function()
		if mOnWD_MainFrame.ItemFrame then
			mOnWD_MainFrame.ItemFrame:Hide()
		end
		o.updateMissingVisuals()
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3,
}

---------------------------------------------------------------
--  Methods
---------------------------------------------------------------

local function everythingNeededExists(i)
	return mOnWD_MainFrame and mOnWD_MainFrame.ListFrame and mOnWD_MainFrame.ListFrame.RowFrame and mOnWD_MainFrame.ListFrame.RowFrame.rows and
		mOnWD_MainFrame.ListFrame.RowFrame.rows[i] and mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text1 and mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text2
		and mOnWD_MainFrame.ListFrame.RowFrame.rows[i].saved and mOnWD_MainFrame.ListFrame.RowFrame.rows[i].percent
		and mOnWD_MainFrame.ListFrame.RowFrame.rows[i].status
end

local function getSpecialMessage()
	local weekday, month, day, year = CalendarGetDate()
	if day == 30 and month == 8 and year == 2016 then
		return o.strings["Happy Leveling"]
	elseif day == 29 or day == 15 then
		return o.strings["You're beautiful"]
	elseif weekday == 1 then
		return o.strings["Happy Sunday"]
	end
end

o.GUIpagingHelper = function(N)
	if o.loaded == false then
		mOnWD_MainFrame.ListFrame.info:Show()
		mOnWD_MainFrame.ListFrame.specialMessage:Show()
		mOnWD_MainFrame.ListFrame.specialMessage:SetText(getSpecialMessage())
	else
		mOnWD_MainFrame.ListFrame.info:Hide()
		mOnWD_MainFrame.ListFrame.specialMessage:Hide()
	end

	local numRows = mOnWD_MainFrame.ListFrame.RowFrame.numRows

	o.CURRENT_PAGE = N;

	o.updateSavedInstances()

	if mOnWDSave.disableProgress then
		mOnWD_MainFrame.ListFrame.ColT1:SetText(o.strings["Missing Items"])
	else
		mOnWD_MainFrame.ListFrame.ColT1:SetText(o.strings["Progress"])
	end

	local FirstN = N - 1
	for i=1,numRows do
		if everythingNeededExists(i) then
			local row = mOnWD_MainFrame.ListFrame.RowFrame.rows[i]
			if mOnWDSave.disableProgress then
				row.percent:Hide()
			else
				row.percent:Show()
			end
			local index = i+FirstN
			if o.menuItems[index]~=nil then
				local item = o.menuItems[index]
				if item.category then
					row:Disable()
					row.text1:SetTextColor(1,0.2,0.2,1)
					row.text2:SetTextColor(1,0.2,0.2,1)
					row.percent:SetTextColor(1,0.2,0.2,1)
					row.saved:Hide()
					-- ** HgD CODE CHANGES START HERE ** --
					row.icon:Hide()
					-- ** HgD CODE CHANGES END HERE ** --
					if o.tiers[item.name] then
						local total = 0
						local t = o.tiers[item.name]
						for k,v in pairs(t) do
							for j = 0,#v do
								if o.instances[v[j]] then total = total + o.instances[v[j]]['total'] end
							end
						end
						if mOnWDSave.disableProgress then
							row.text1:SetText(total)
							row.percent:SetText("")
							row.status:Show()
							row.status:SetValue(0)
						else
							local collected = 0
							for k,v in pairs(t) do
								for j = 0,#v do
									if o.instances[v[j]] then collected = collected + o.instances[v[j]]['collected'] end
								end
							end
							local percent = math.floor((collected / total * 100) + 0.5)
							if total == 0 or percent > 100 then percent = 100 end
							row.status:Show()
							row.status:SetValue(percent)
							row.percent:SetText(percent .. "%")
							row.text1:SetText(collected .. " / " .. total)
						end
					else
						row.text1:SetText("")
						row.percent:SetText("")
						row.status:Hide()
					end
				else
					local total = o.instances[item.name]['total']
					row:Enable()
					if mOnWDSave.disableProgress then
						row.text1:SetText(total)
						row.status:SetValue(0)
					else
						local collected = o.instances[item.name]['collected']
						local percent = math.floor((collected / total * 100) + 0.5)
						if total == 0 or percent > 100 then percent = 100 end
						row.text1:SetText(collected .. " / " .. total)
						row.percent:SetText(percent .. "%")
						row.status:SetValue(percent)
					end
					row.status:Show()
					row.text1:SetTextColor(1,1,1,1)
					row.text2:SetTextColor(1,1,1,1)
					row.percent:SetTextColor(1,1,1,1)
					-- ** HgD CODE CHANGES START HERE ** --
					if mOnWDSave.favoriteInstances[item.name] then
						row.icon:Show()
						local icon_no = mOnWDSave.favoriteInstances[item.name];
						if (icon_no == true) then icon_no = 1 end
						row.icon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..icon_no)
					else
						row.icon:Hide()
					end
					if item.type == "Raid" then
						row.text1:SetTextColor(1,1,0.6,1)
						row.text2:SetTextColor(1,1,0.6,1)
						row.percent:SetTextColor(1,1,0.6,1)
					elseif item.type == '#done' then
						row.text1:SetTextColor(1,1,1,0.6)
						row.text2:SetTextColor(1,1,1,0.6)
						row.percent:SetTextColor(1,1,1,0.6)
						row:Enable()
						row.icon:Hide()
					end
					-- ** HgD CODE CHANGES END HERE ** --
				end
				row.text2:SetText(item.name)
				if o.saves[item.name] then
					row.saved:Show()
				else
					row.saved:Hide()
				end
			else
				row.text1:SetText("")
				row.text2:SetText("")
				row.percent:SetText("")
				row:Disable()
				row.saved:Hide()
				-- ** HgD CODE CHANGES START HERE ** --
				row.icon:Hide()
				-- ** HgD CODE CHANGES END HERE ** --
				row.status:Hide()
			end
		end
	end
end

o.GUImainPage = function(N)
	local numRows = mOnWD_MainFrame.ListFrame.RowFrame.numRows
	mOnWD_MainFrame.ListFrame.scrollbar:SetMinMaxValues(1, math.max(#o.menuItems - numRows + 1, 1))
	mOnWD_MainFrame.ListFrame.scrollbar:SetValue(N)
	o.GUIpagingHelper(N)
end

o.GUIselect = function(instance)
	if mOnWDSave.onlyMiniList then
		if mOnWDSave.hideList then
			mOnWD_MainFrame:Hide()
		end
		o.GUIopenMiniList(1, instance, '#first')
	else
		o.GUIshowItems(instance)
	end
end

local function compMenuItemsDefault(a, b)
	if a.index == b.index then
		return cmpAlphabetical(a.name, b.name)
	else
		return a.index < b.index
	end
end

o.createMenuItems = function()
	if o.loaded == false then return end

	o.menuItems = {}

	for i = 1,#o.EXPS do
		table.insert(o.menuItems, {name = o.EXPS[i], category = true, index = i})
		table.insert(o.menuItems, {name = "", category = true, index = i + 0.9})
	end

	table.insert(o.menuItems, {name = "Special", category = true, index = #o.EXPS + 1})
	table.insert(o.menuItems, {name = "", category = true, index = #o.EXPS + 1 + 0.9})

	table.insert(o.menuItems, {name = "Custom Categories", category = true, index = #o.EXPS + 2})
	table.insert(o.menuItems, {name = "", category = true, index = #o.EXPS + 2 + 0.9})

	table.insert(o.menuItems, {name = "Unknown", category = true, index = #o.EXPS + 3})
	table.insert(o.menuItems, {name = "", category = true, index = #o.EXPS + 3 + 0.9})

	for k, v in orderedPairs(o.instances) do
		local tmp = {}
		local type = 1
		tmp.name = k
		if o.categorization[k] then
			tmp.type = o.PARTY[o.categorization[k][2]]
			type = o.categorization[k][2]
			if(v['collected'] >= v['total']) then
				tmp.type = "#done"
				type = 3
			end
			tmp.index = o.categorization[k][1] + (type / 10)
		elseif o.SPECIAL[k] then
			if(v['collected'] >= v['total']) then
				tmp.type = "#done"
				type = 3
			end
			tmp.index = (#o.EXPS + 1) + (type / 10)
		elseif o.customCategories[k] then
			if(v['collected'] >= v['total']) then
				tmp.type = "#done"
				type = 3
			end
			tmp.index = (#o.EXPS + 2) + (type / 10)
		else
			if(v['collected'] >= v['total']) then
				tmp.type = "#done"
				type = 3
			end
			tmp.index = (#o.EXPS + 3) + (type / 10)
		end
		if tmp.type == '#done' and mOnWDSave.hideCompletedInstances then
		else
			table.insert(o.menuItems, tmp)
		end
	end

	table.sort(o.menuItems, compMenuItemsDefault)
end
