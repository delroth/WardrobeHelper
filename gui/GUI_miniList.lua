local o = mOnWardrobe

---------------------------------------------------------------
--  Create UI
---------------------------------------------------------------

local f = CreateFrame("FRAME", "mOnWD_MiniList", UIParent)
f:SetPoint("CENTER",0,0)
f:SetFrameStrata("high")
f:SetMovable(true)
f:EnableMouse(true)
f:SetClampedToScreen(true)
f:RegisterForDrag("LeftButton")
f:SetScript("OnDragStart", f.StartMoving)
f:SetScript("OnDragStop", f.StopMovingOrSizing)
f:SetWidth(200)
f:SetHeight(250)
f:Hide()

local t = f:CreateTexture(nil, "ARTWORK")
f.bg = t
t:SetColorTexture(0,0,0,0.8)
t:SetAllPoints(f)

local b = CreateFrame("Button", nil, f, "UIPanelCloseButton")
b:SetPoint("TOPRIGHT",f,"TOPRIGHT",8,8)
b:SetScript("OnClick", function()
  f:Hide()
end)

local c = CreateFrame("StatusBar", nil, f)
c:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
c:GetStatusBarTexture():SetHorizTile(false)
c:SetMinMaxValues(0, 100)
c:SetValue(50)
c:SetWidth(f:GetWidth())
c:SetHeight(10 + 4)
c:SetPoint("TOP",f,"TOP", 0, 0)
c:SetStatusBarColor(0,1,0)
f.status = c

local c = f.status:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
c:SetHeight(f.status:GetHeight() - 4)
c:SetWidth(f.status:GetWidth())
c:SetJustifyH("CENTER")
c:SetPoint("TOP", f.status, "TOP", 0, -2)
c:SetText('40 / 100')
local filename, fontHeight, flags = c:GetFont()
c:SetFont(filename, fontHeight, "OUTLINE")
f.status.text = c

local ff = CreateFrame("FRAME", "mOnWD_MiniList_List", f)
ff:SetPoint("TOPLEFT", f.status, "BOTTOMLEFT",0,0)
ff:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT",0,0)
f.list = ff

ff:EnableMouseWheel(true)
ff:SetScript("OnMouseWheel", function(self, delta)
	 if f.N - delta > 0 and f.N - delta < #f.menuItems + 1 then
	 	ff.scrollbar:SetValue(f.N - delta)
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
	 o.GUIopenMiniList(math.floor(value + 0.5))
end)
ff.scrollbar = scrollbar

local fontHeight = select(2, GameFontNormalSmall:GetFont())
local numRows = 16 --math.floor(ff:GetHeight() / rowHeight)
ff.rowHeight = fontHeight + 4
ff.rows = {}

local function CreateTableRow(parent, rowHeight, N)
  local row = CreateFrame("Button", nil, parent)
  row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	row.id = N;
  row:SetHeight(rowHeight)
  row:SetPoint("LEFT")
  row:SetPoint("RIGHT", parent, "RIGHT", -16, 0)

  row:SetScript("OnClick", function(self, button)
    local name, itemLink = GetItemInfo(self.id)
    if (itemLink and button == "LeftButton" and IsModifiedClick("CHATLINK")) then
      ChatEdit_InsertLink(itemLink)
      return
    end

    if(itemLink and button == "LeftButton" and IsModifiedClick("DRESSUP") and DressUpFrame) then
      DressUpItemLink(itemLink)
      return
    end

    if(button == "LeftButton" and IsAltKeyDown()) then
      local found = false
      for i = 1,#mOnWDSave.blacklist do
        if mOnWDSave.blacklist[i] == self.id then
          found = true
          break
        end
      end
      if found == false then
        table.insert(mOnWDSave.blacklist, self.id)
      end
      o.refreshInstance(o.selection.miniList.instance)
      o.setDifficulty(o.selection.miniList.difficulty)
      o.GUIopenMiniList(nil, nil, nil, true)
      print(string.format(o.strings["Item added to blacklist"], itemLink .. "|cFFFF7D0A"))
    end
  end)

	row:SetScript("OnEnter", function()
      if(row.id) then
        GameTooltip_SetDefaultAnchor(GameTooltip, row)
  			GameTooltip:ClearLines()
				GameTooltip:SetItemByID(row.id);
  			GameTooltip:ClearAllPoints()
  			GameTooltip:SetPoint("BOTTOMRIGHT", row, "TOPLEFT")
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

  local b = CreateFrame("BUTTON",nil,row,"UIPanelButtonTemplate")
  row.button = b
  b:SetPoint("RIGHT",-5,0)
  b:SetText(">")
  b:SetHeight(25)
  b:SetWidth(25)
  b:SetScript("OnClick", function()
    local tmp = mOnWD_MiniList.D + 1
    if tmp > #mOnWD_MiniList.difficulties then
      tmp = 1
    end
    o.GUIopenMiniList(nil, nil, f.difficulties[tmp], true)
	end)
  b:Hide()

  return row
end

function mOnWD_MiniList:SetRowCount(count)
  local ff = self.list
  ff.numRows = count
  self:SetHeight(ff.numRows * ff.rowHeight + (self:GetHeight() - ff:GetHeight()))
  for i = #ff.rows + 1,ff.numRows do
    local r = CreateTableRow(ff, ff.rowHeight, i)
    if #ff.rows == 0 then
      r:SetPoint("TOP")
    else
      r:SetPoint("TOP", ff.rows[#ff.rows], "BOTTOM")
    end
    table.insert(ff.rows, r)
  end
  for i = 1,ff.numRows do
    ff.rows[i]:Show()
  end
  for i = ff.numRows + 1, #ff.rows do
    ff.rows[i]:Hide()
  end
end

mOnWD_MiniList:SetRowCount(numRows)

---------------------------------------------------------------
--  Methods
---------------------------------------------------------------

o.GUIopenMiniList = function(N, instance, difficulty, dontAffectVisibility)
  local f = mOnWD_MiniList
  local ff = f.list
  local s = o.selection.miniList

  if instance then
    s.instance = instance
  end

  f.difficulties = {}
  for k, v in orderedPairs(o.instances[s.instance]['difficulties']) do
    table.insert(f.difficulties, k)
  end

  if difficulty == '#first' then
    s.difficulty = f.difficulties[1]
    f.D = 1
  elseif difficulty then
    s.difficulty = difficulty
    for i=1,#f.difficulties do
      if s.difficulty == f.difficulties[i] then
        f.D = i
        break
      end
    end
  end

  if N then
    f.N = N
  end

  if o.instances[s.instance] and o.instances[s.instance]['difficulties'][s.difficulty] then
    local data = o.instances[s.instance]['difficulties'][s.difficulty]
    f.menuItems = {}
    table.insert(f.menuItems, {name = s.instance, title = true})
    table.insert(f.menuItems, {name = s.difficulty, title = true, button = #f.difficulties > 1})
    table.insert(f.menuItems, {name = "", hint = true})
    for k, v in orderedPairs(data['bosses']) do
      if #v['items'] > 0 then
        table.insert(f.menuItems, {name = k, category = true})
        for i = 1,#v['items'] do
    			local n, itemLink = GetItemInfo(v['items'][i].id)
          table.insert(f.menuItems, {name = n, id = v['items'][i].id, link = itemLink})
        end
        table.insert(f.menuItems, {name = "", category = true})
      end
    end

    local total = data['total']
    if mOnWDSave.disableProgress then
      f.status.text:SetText(total);
      f.status:SetValue(0)
    else
      local missing = data['collected']
      local percent = math.floor((missing / total * 100) + 0.5)
      if total == 0 or percent > 100 then percent = 100 end
      f.status.text:SetText(missing .. " / " .. total)
      f.status:SetValue(percent)
    end

    local FirstN = f.N - 1
    ff.scrollbar:SetMinMaxValues(1, math.max(#f.menuItems - ff.numRows + 1, 1))

    for i = 1,ff.numRows do
      local index = i+FirstN
      if f.menuItems[index] then
        ff.rows[i].text:SetText(f.menuItems[index].name)
        ff.rows[i].id = nil
        ff.rows[i].itemLink = nil
        ff.rows[i]:Disable()
        if(f.menuItems[index].category) then
					ff.rows[i].text:SetTextColor(1,1,0.6,1)
        elseif(f.menuItems[index].title) then
  					ff.rows[i].text:SetTextColor(1,0.6,1,1)
        elseif(f.menuItems[index].hint) then
  					ff.rows[i].text:SetTextColor(0.6,0.6,0.6,0.8)
        else
					ff.rows[i].text:SetTextColor(1,1,1,1)
          ff.rows[i].id = f.menuItems[index].id
          ff.rows[i].itemLink = f.menuItems[index].link
          ff.rows[i]:Enable()
        end
        if(f.menuItems[index].button) then
          ff.rows[i].button:Show()
        else
          ff.rows[i].button:Hide()
        end
      else
        ff.rows[i].text:SetText("")
      end
    end

    if(dontAffectVisibility) then
    else
      f:Show()
    end
  end
end
