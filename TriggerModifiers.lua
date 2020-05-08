function TestCityCountModifiers(playerId)
	local player = Players[playerId]

	local cityCount = player:GetCities():GetCount()
	if cityCount > 4 then
		return
	end

	local tech = GameInfo.Technologies['TECH_CITY' .. cityCount]
	player:GetTechs():SetTech(tech.Index, true)
end

function OnCityConquered(newPlayerID, oldPlayerID, newCityID, iCityX, iCityY)
	TestCityCountModifiers(newPlayerID)
end

function OnCityAddedToMap(ownerPlayerID, cityID, cityX, cityY)
	TestCityCountModifiers(ownerPlayerID)
end

Events.LoadScreenClose.Add(function()
	-- 在战争中，攻下一座城市时引发此事件
	--GameEvents.CityConquered.Add(OnCityConquered)

	Events.CityAddedToMap.Add(OnCityAddedToMap)

end)