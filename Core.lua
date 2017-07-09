local o = mOnWardrobe

---------------------------------------------------------------
--  Default Settings (mOnWDSave)
---------------------------------------------------------------

o.defaultSettings = {}
o.defaultSettings.hideList = false
o.defaultSettings.disableProgress = false
o.defaultSettings.minimap = {}
o.defaultSettings.disableConfirmation = false
o.defaultSettings.completionistMode = false
o.defaultSettings.hideCompletedInstances = false
o.defaultSettings.onlyMiniList = false
o.defaultSettings.blacklist = {}
o.defaultSettings.reloadOnStart = false
o.defaultSettings.miniListScale = 1
o.defaultSettings.miniListRowCount = 16
o.defaultSettings.favoriteInstances = {}

---------------------------------------------------------------
--  Main Initialization
---------------------------------------------------------------

o.instances = {}
o.version = GetAddOnMetadata("mOnArs_WardrobeHelper", "Version");

local TYPES = {
	'Boss drop', 'Quests', 'Vendor', 'World/Instance Drop', 'Achievements', 'Professions'
}

TYPES[0] = 'Other'

o.TYPES = TYPES
o.SPECIAL = {}

for i = 0,#TYPES do
	o.SPECIAL[TYPES[i]] = true
end

o.menuItems = {}
o.saves = {}
o.loaded = false

o.selection = {}
o.selection.itemList = {}
o.selection.miniList = {}

if o.customCategories == nil then o.customCategories = {} end

o.tiers = {}
for i = 1,#o.EXPS do
	o.tiers[o.EXPS[i]] = {}
	for j = 1,#o.PARTY do
		o.tiers[o.EXPS[i]][o.PARTY[j]] = {}
	end
end

for k, v in pairs(o.categorization) do
	table.insert(o.tiers[o.EXPS[v[1]]][o.PARTY[v[2]]], k)
end

o.tiers['Special'] = {}
o.tiers['Special']['Other'] = o.TYPES
o.tiers['Custom Categories'] = {}

-- Difficulties: LFR, N, H, M, 10, 25, 10HC, 25HC
o.difficulties = {}
o.difficulties["LFR"] = {PLAYER_DIFFICULTY3, "Looking For Raid"}
o.difficulties["N"] = {"Normal", PLAYER_DIFFICULTY1}
o.difficulties["H"] = {PLAYER_DIFFICULTY2}
o.difficulties["M"] = {PLAYER_DIFFICULTY6}
o.difficulties["10"] = {RAID_DIFFICULTY1, RAID_DIFFICULTY_10PLAYER}
o.difficulties["25"] = {RAID_DIFFICULTY2, RAID_DIFFICULTY_25PLAYER}
o.difficulties["10H"] = {RAID_DIFFICULTY3, RAID_DIFFICULTY_10PLAYER_HEROIC}
o.difficulties["25H"] = {RAID_DIFFICULTY4, RAID_DIFFICULTY_25PLAYER_HEROIC}

---------------------------------------------------------------
--  Minimap Button
---------------------------------------------------------------

o.LDB = LibStub("LibDataBroker-1.1"):NewDataObject("Wardrobe Helper", {
	type = "launcher",
	text = "Wardrobe Helper",
	icon = "Interface\\Icons\\INV_Chest_Cloth_17",
	OnClick = function() o.GUIopen() end,
	OnTooltipShow = function(tooltip)
		tooltip:AddLine("Wardrobe Helper")
	end,
})

o.LDBI = LibStub("LibDBIcon-1.0")

---------------------------------------------------------------
--  Debug Methods
---------------------------------------------------------------

o.debug = {}
o.debug.printInstances = function()
	local text = ""
	for k, v in orderedPairs(o.instances) do
		text = text .. "~" .. k
	end
	print(text)
end

---------------------------------------------------------------
--  Methods
---------------------------------------------------------------

o.isCollected = function(sources, itemID)
	for i = 1,#sources do
		if sources[i].isCollected then
			if itemID then
				local i1, i2, b1, i3, b2, itemString, visualString, sourceType = C_TransmogCollection.GetAppearanceSourceInfo(sources[i].sourceID)
				local id = tonumber(string.match(itemString, 'item:([^:]*):'))
				if id == itemID then
					return true
				end
			else
				return true
			end
		end
	end
	return false
end

o.isBlacklisted = function(id)
	for i = 1,#o.blacklist do
		if o.blacklist[i] == id then return true end
	end

	for i = 1,#mOnWDSave.blacklist do
		if mOnWDSave.blacklist[i] == id then return true end
	end

	return false
end

local function getUpdateHelper()
	return coroutine.create(function()
		local newInstances = {}
		local blockSize = 50 -- number of appearances to load at once. higher values may introduce lag
		local counter = 0
		for i = 1,30 do
			local appearances = C_TransmogCollection.GetCategoryAppearances(i)
			if appearances then
				for j = 1,#appearances do
					local sources = C_TransmogCollection.GetAppearanceSources(appearances[j].visualID)
					if sources then
						local collected = (mOnWDSave.completionistMode == false) and (o.isCollected(sources) == true)
						if collected and mOnWDSave.disableProgress then
						else
							for m = 1,#sources do
								local i1, i2, b1, i3, b2, itemString, visualString, sourceType = C_TransmogCollection.GetAppearanceSourceInfo(sources[m].sourceID)
								local itemID = tonumber(string.match(itemString, 'item:([^:]*):'))
								collected = (mOnWDSave.completionistMode == false) and (o.isCollected(sources) == true)
								collected = collected or (mOnWDSave.completionistMode and o.isCollected(sources, itemID))
								if o.isBlacklisted(itemID) == false then
									-- 1 = Boss Raid Drops
									if sourceType == 1 then
										local drops = C_TransmogCollection.GetAppearanceSourceDrops(sources[m].sourceID)
										for k=1,#drops do
											local inst = drops[k]
											if newInstances[inst.instance] == nil then
												newInstances[inst.instance] = {}
												newInstances[inst.instance]['collected'] = 0
												newInstances[inst.instance]['total'] = 0
												newInstances[inst.instance]['difficulties'] = {}
											end
											if #inst.difficulties == 0 then
												inst.difficulties[1] = "Normal"
											end
											for l=1,#inst.difficulties do
												local dif = inst.difficulties[l]
												if newInstances[inst.instance]['difficulties'][dif] == nil then
													newInstances[inst.instance]['difficulties'][dif] = {}
													newInstances[inst.instance]['difficulties'][dif]['collected'] = 0
													newInstances[inst.instance]['difficulties'][dif]['total'] = 0
													newInstances[inst.instance]['difficulties'][dif]['bosses'] = {}
												end
												if newInstances[inst.instance]['difficulties'][dif]['bosses'][inst.encounter] == nil then
													newInstances[inst.instance]['difficulties'][dif]['bosses'][inst.encounter] = {}
													newInstances[inst.instance]['difficulties'][dif]['bosses'][inst.encounter]['items'] = {}
												end
												if collected then
													newInstances[inst.instance]['collected'] = newInstances[inst.instance]['collected'] + 1
													newInstances[inst.instance]['difficulties'][dif]['collected'] = newInstances[inst.instance]['difficulties'][dif]['collected'] + 1
												else
													table.insert(newInstances[inst.instance]['difficulties'][dif]['bosses'][inst.encounter]['items'], {
														link = itemString, id = itemID, visualID = appearances[j].visualID,	sourceID = sources[m].sourceID
													})
												end
												newInstances[inst.instance]['total'] = newInstances[inst.instance]['total'] + 1
												newInstances[inst.instance]['difficulties'][dif]['total'] = newInstances[inst.instance]['difficulties'][dif]['total'] + 1
											end
										end
									else
										local type = TYPES[sourceType]
										if newInstances[type] == nil then
											newInstances[type] = {}
											newInstances[type]['difficulties'] = {}
											newInstances[type]['difficulties']['Normal'] = {}
											newInstances[type]['difficulties']['Normal']['bosses'] = {}
											newInstances[type]['collected'] = 0
											newInstances[type]['total'] = 0
										end
										if newInstances[type]['difficulties']['Normal']['bosses'][i] == nil then
											newInstances[type]['difficulties']['Normal']['bosses'][i] = {}
											newInstances[type]['difficulties']['Normal']['bosses'][i]['items'] = {}
										end
										if collected then
											newInstances[type]['collected'] = newInstances[type]['collected'] + 1
										else
											table.insert(newInstances[type]['difficulties']['Normal']['bosses'][i]['items'], {
												link = itemString, id = itemID, visualID = appearances[j].visualID, sourceID = sources[m].sourceID
											})
										end
										newInstances[type]['total'] = newInstances[type]['total'] + 1
									end
								end
							end
						end
					end
					counter = counter + 1
					if counter % blockSize == 0 then
						o.dotsString = o.dotsString .. "."
						if o.dotsString == "...." then o.dotsString = "" end
						coroutine.yield()
					end
				end
			end
		end

		o.tiers['Custom Categories']['Other'] = {}
		for categoryName, category in pairs(o.customCategories) do
			newInstances[categoryName] = {}
			newInstances[categoryName]['difficulties'] = {}
			newInstances[categoryName]["total"] = 0
			newInstances[categoryName]["collected"] = 0
			table.insert(o.tiers['Custom Categories']['Other'], categoryName)

			for difficultyName, difficulty in pairs(category) do
				if string.sub(difficultyName, 1, 1) ~= '#' then
					newInstances[categoryName]['difficulties'][difficultyName] = {}
					newInstances[categoryName]['difficulties'][difficultyName]["total"] = 0
					newInstances[categoryName]['difficulties'][difficultyName]["collected"] = 0
					newInstances[categoryName]['difficulties'][difficultyName]["bosses"] = {}
					for bossName, boss in pairs(difficulty) do
						newInstances[categoryName]['difficulties'][difficultyName]["bosses"][bossName] = {}
						newInstances[categoryName]['difficulties'][difficultyName]["bosses"][bossName]['items'] = {}
						for i = 1, #boss do
							local item = boss[i]
							local sources = C_TransmogCollection.GetAppearanceSources(item.visualID)
							if sources then
								local collected = o.isCollected(sources) and (mOnWDSave.completionistMode == false)
								collected = collected or (o.isCollected(sources, item.id) and mOnWDSave.completionistMode)
								if collected then
									newInstances[categoryName]["collected"] = newInstances[categoryName]["collected"] + 1
									newInstances[categoryName]['difficulties'][difficultyName]["collected"] = newInstances[categoryName]['difficulties'][difficultyName]["collected"] + 1
								else
									table.insert(newInstances[categoryName]['difficulties'][difficultyName]["bosses"][bossName]['items'], item)
								end

								if category["#allSources"] and (collected == false or mOnWDSave.completionistMode) then
									for j = 1,#sources do
										local i1, i2, b1, i3, b2, itemString, visualString, sourceType = C_TransmogCollection.GetAppearanceSourceInfo(sources[j].sourceID)
										local id = tonumber(string.match(itemString, 'item:([^:]*):'))
										if id ~= item.id and (o.isCollected(sources, id) == false) then
											local otherSources = bossName .. " - " .. o.strings["Other Sources"]
											if newInstances[categoryName]['difficulties'][difficultyName]['bosses'][otherSources] == nil then
												newInstances[categoryName]['difficulties'][difficultyName]['bosses'][otherSources] = {}
												newInstances[categoryName]['difficulties'][difficultyName]['bosses'][otherSources]['items'] = {}
											end
											local newItem = {}
											newItem.id = id
											newItem.visualID = item.visualID
											newItem.sourceData = {}
											if sourceType == 1 then
												local drops = C_TransmogCollection.GetAppearanceSourceDrops(sources[j].sourceID)
												for k=1,#drops do
													table.insert(newItem.sourceData, drops[k].instance)
												end
											else
												newItem.sourceData[1] = o.TYPES[sourceType]
											end
											table.insert(newInstances[categoryName]['difficulties'][difficultyName]['bosses'][otherSources]['items'], newItem)
										end
									end
								end

								newInstances[categoryName]["total"] = newInstances[categoryName]["total"] + 1
								newInstances[categoryName]['difficulties'][difficultyName]["total"] = newInstances[categoryName]['difficulties'][difficultyName]["total"] + 1
							else
								if category['#alwaysShow'] then
									table.insert(newInstances[categoryName]['difficulties'][difficultyName]["bosses"][bossName]['items'], item)
									newInstances[categoryName]["total"] = newInstances[categoryName]["total"] + 1
									newInstances[categoryName]['difficulties'][difficultyName]["total"] = newInstances[categoryName]['difficulties'][difficultyName]["total"] + 1
								end
							end

							counter = counter + 1
							if counter % blockSize == 0 then
								o.dotsString = o.dotsString .. "."
								if o.dotsString == "...." then o.dotsString = "" end
								coroutine.yield()
							end
						end
					end
				end
			end
		end

		o.addAdditionalData(newInstances, true)

		o.instances = newInstances
		o.loaded = true

		o.updateHelper = nil
		o.createMenuItems()
		collectgarbage()
		o.GUImainPage(1)
	end)
end

o.dotsString = ""
o.updateHelper = nil
o.updateMissingVisuals = function()
	if o.updateHelper == nil or coroutine.status(o.updateHelper) == "dead" then
		o.dotsString = ""
		o.updateHelper = getUpdateHelper()
	end
	local ok, msg = coroutine.resume(o.updateHelper)
	if not ok then
		print("Error while refreshing: ", msg)
	end
end

o.refreshInstance = function(instance)
	if o.instances[instance] == nil then
		return
	end
	for difficulty, bosses in pairs(o.instances[instance]['difficulties']) do
		for boss, items in pairs(bosses['bosses']) do
			for i=#items['items'],1,-1 do
				local sources = C_TransmogCollection.GetAppearanceSources(items['items'][i].visualID)
				if o.isBlacklisted(items['items'][i].id) then
					table.remove(items['items'], i)
					o.instances[instance]['total'] = o.instances[instance]['total'] - 1
					o.instances[instance]['difficulties'][difficulty]['total'] = o.instances[instance]['difficulties'][difficulty]['total'] - 1
				elseif o.isCollected(sources, mOnWDSave.completionistMode and items['items'][i].id or nil) then
					table.remove(items['items'], i)
					o.instances[instance]['collected'] = o.instances[instance]['collected'] + 1
					o.instances[instance]['difficulties'][difficulty]['collected'] = o.instances[instance]['difficulties'][difficulty]['collected'] + 1
				end
			end
		end
	end
	o.createMenuItems()
	o.GUImainPage(o.CURRENT_PAGE)
end

o.GUIopen = function()
	o.GUImainPage(o.CURRENT_PAGE)
	mOnWD_MainFrame.hideList:SetChecked(mOnWDSave.hideList)
	mOnWD_MainFrame:Show()
	o.GUIcurrentInstance()
end

o.fixSettings = function()
	if mOnWDSave == nil then mOnWDSave = {} end
	for k, v in pairs(o.defaultSettings) do
		if mOnWDSave[k] == nil then mOnWDSave[k] = v end
	end
end

o.createInstanceNames = function(name)
	local namesToTry = {}
	namesToTry[#namesToTry + 1] = name

	if name == 'The Escape from Durnholde' then
		namesToTry[#namesToTry + 1] = 'Old Hillsbrad Foothills'
	elseif name == 'Old Hillsbrad Foothills' then
		namesToTry[#namesToTry + 1] = 'The Escape from Durnholde'
	elseif name == 'Vorgebirge des Alten Hügellands' then
		namesToTry[#namesToTry + 1] = 'Die Flucht aus Durnholde'
	elseif name == 'Die Flucht aus Durnholde' then
		namesToTry[#namesToTry + 1] = 'Vorgebirge des Alten Hügellands'

	elseif name == 'Opening of the Dark Portal' then
		namesToTry[#namesToTry + 1] = 'The Black Morass'
	elseif name == 'The Black Morass' then
		namesToTry[#namesToTry + 1] = 'Opening of the Dark Portal'
	elseif name == 'Der Schwarze Morast' then
		namesToTry[#namesToTry + 1] = 'Öffnung des Dunklen Portals'
	elseif name == 'Öffnung des Dunklen Portals' then
		namesToTry[#namesToTry + 1] = 'Der Schwarze Morast'

	elseif name == 'Der Geschmolzene Kern' then
		namesToTry[#namesToTry + 1] = 'Geschmolzener Kern'
	elseif name == 'Geschmolzener Kern' then
		namesToTry[#namesToTry + 1] = 'Der Geschmolzene Kern'
	elseif name == 'Eiskronenzitadelle' then
		namesToTry[#namesToTry + 1] = 'Die Eiskronenzitadelle'
	elseif name == 'Die Eiskronenzitadelle' then
		namesToTry[#namesToTry + 1] = 'Eiskronenzitadelle'

	elseif name == "Stormwind Stockade" then
		namesToTry[#namesToTry + 1] = "The Stockade"
	elseif name == "The Stockade" then
		namesToTry[#namesToTry + 1] = "Stormwind Stockade"

	elseif name == 'Tempest Keep' then
		namesToTry[#namesToTry + 1] = 'The Eye'
	elseif name == 'The Eye' then
		namesToTry[#namesToTry + 1] = 'Tempest Keep'
	elseif name == 'Das Auge' then
		namesToTry[#namesToTry + 1] = 'Festung der Stürme'
	elseif name == 'Festung der Stürme' then
		namesToTry[#namesToTry + 1] = 'Das Auge'
	elseif name == 'Око' then
		namesToTry[#namesToTry + 1] = 'Крепость Бурь'
	elseif name == 'Крепость Бурь' then
		namesToTry[#namesToTry + 1] = 'Око'

	elseif name == "Ahn'Qiraj Temple" then
		namesToTry[#namesToTry + 1] = "Temple of Ahn'Qiraj"
	elseif name == "Temple of Ahn'Qiraj" then
		namesToTry[#namesToTry + 1] = "Ahn'Qiraj Temple"

	elseif name == "Sunken Temple" then
		namesToTry[#namesToTry + 1] = "The Temple of Atal'hakkar"
	elseif name == "The Temple of Atal'hakkar" then
		namesToTry[#namesToTry + 1] = "Sunken Temple"

	elseif name == 'The Sunwell' then
		namesToTry[#namesToTry + 1] = 'Sunwell Plateau'
	elseif name == 'Sunwell Plateau' then
		namesToTry[#namesToTry + 1] = 'The Sunwell'
	elseif name == 'Der Sonnenbrunnen' then
		namesToTry[#namesToTry + 1] = 'Sonnenbrunnenplateau'
	elseif name == 'Sonnenbrunnenplateau' then
		namesToTry[#namesToTry + 1] = 'Der Sonnenbrunnen'

	elseif name == 'Die Scharlachroten Hallen' then
		namesToTry[#namesToTry + 1] = 'Scharlachrote Hallen'
	elseif name == 'Scharlachrote Hallen' then
		namesToTry[#namesToTry + 1] = 'Die Scharlachroten Hallen'

	elseif name == 'Scharlachrotes Kloster' then
			namesToTry[#namesToTry + 1] = 'Das Scharlachrote Kloster'
	elseif name == 'Das Scharlachrote Kloster' then
			namesToTry[#namesToTry + 1] = 'Scharlachrotes Kloster'
	end


	local tmp = string.explodePHP(name, ": ")
	if #tmp == 2 then
		namesToTry[#namesToTry + 1] = tmp[2]
		local tmp2 = string.explodePHP(tmp[1], " ")
		for i = 1,#tmp2 do
			namesToTry[#namesToTry + 1] = tmp2[i] .. " " .. tmp[2]
		end
	end

	tmp = string.gsub(name, "'s", "s'")
	namesToTry[#namesToTry + 1] = tmp

	tmp = string.gsub(name, "s'", "'s")
	namesToTry[#namesToTry + 1] = tmp

	tmp = string.gsub(name, "The ", "")
	namesToTry[#namesToTry + 1] = tmp

	tmp = "The " .. name
	namesToTry[#namesToTry + 1] = tmp

	return namesToTry
end

o.updateSavedInstances = function()
	o.saves = {}
	for i = 1,GetNumSavedInstances() do
		local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(i)
		if locked then
			local names = o.createInstanceNames(name)
			for j = 1,#names do
				o.saves[names[j]] = true
			end
		end
	end
end

o.reset = function()
	mOnWD_MiniList:Hide()
	mOnWD_MainFrame:Hide()
	mOnWD_MainFrame.ItemFrame:Hide()
	o.instances = {}
	o.loaded = false
	o.menuItems = {}
	mOnWD_MainFrame.ListFrame.info:SetText(string.format(o.strings["Click Refresh Info"], o.strings["Refresh Items"]))
end

---------------------------------------------------------------
--  Slash Commands
---------------------------------------------------------------

SLASH_MONWARDROBE1 = '/mwd';

local function handler(msg, editbox)
	o.GUIopen()
end

SlashCmdList["MONWARDROBE"] = handler;

---------------------------------------------------------------
--  Events
---------------------------------------------------------------

o.eventFrame = CreateFrame("Frame")
local f = o.eventFrame
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("TRANSMOG_COLLECTION_UPDATED")
f:RegisterEvent("GET_ITEM_INFO_RECEIVED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
local init = true

function f:OnEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23)
	if (event == "ADDON_LOADED") and (arg1 == "mOnArs_WardrobeHelper") then
		o.fixSettings()
		o.LDBI:Register("Wardrobe Helper", o.LDB, mOnWDSave.minimap)
	end

	if (event == "TRANSMOG_COLLECTION_UPDATED") then
		if(o.selection.miniList.instance) then
			o.refreshInstance(o.selection.miniList.instance)
			o.GUIopenMiniList(nil, nil, nil, true)
		end
	end

	if (event == "PLAYER_ENTERING_WORLD") then
		local name, type, difficultyIndex, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, mapID = GetInstanceInfo()
		local namesToTry = o.createInstanceNames(name)

		for i = 1,#namesToTry do
			local name = namesToTry[i]
			if o.instances[name] then
				local diff = '#first'
				if o.instances[name]['difficulties'][difficultyName] then
					diff = difficultyName
				end
				o.GUIopenMiniList(1, name, diff, true)
				return
			end
		end
	end

	if (event == "GET_ITEM_INFO_RECEIVED") then
		if(o.selection.miniList.instance) then
			o.GUIopenMiniList(nil, nil, nil, true)
		end

		if(mOnWD_OptionsFrame) then
			o.GUIblacklistPage(mOnWD_OptionsFrame.blacklist.N)
		end
	end
end

function f:OnUpdate(arg1)
	if WardrobeCollectionFrame then
		if WardrobeCollectionFrame.NavigationFrame then
			if mOnWD_MainFrame_bShow == nil then
				local b = CreateFrame("BUTTON","mOnWD_MainFrame_bShow",WardrobeCollectionFrame.NavigationFrame,"UIPanelButtonTemplate");
				b:SetPoint("BOTTOMLEFT",25,25);
				b:SetText("Wardrobe Helper")
				b:SetHeight(25);
				b:SetWidth(120);
				b:SetScript("OnClick", function()
						o.GUIopen()
					end)
			end
		end
	end


	if o.updateHelper and coroutine.status(o.updateHelper) ~= "dead" then
		mOnWD_MainFrame.ListFrame.info:SetText(o.strings["Refreshing"] .. o.dotsString)
		local ok, msg = coroutine.resume(o.updateHelper)
		if not ok then
			print("Error while refreshing: ", msg)
		end
	end

	if init then
		init = false
		mOnWD_MiniList:SetScale(mOnWDSave.miniListScale)
		mOnWD_MiniList:SetRowCount(mOnWDSave.miniListRowCount)
		if(mOnWDSave.reloadOnStart) then
			o.updateMissingVisuals()
		end
	end
end

f:SetScript("OnUpdate", f.OnUpdate)
f:SetScript("OnEvent", f.OnEvent)
