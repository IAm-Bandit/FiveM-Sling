local duffle = true 
local slungWeaponEntity = nil
local slungWeaponModel = nil
local lastToggleTime = 0
local toggleCooldown = 500
local recentlyUnslinged = false

sling = false

function getWeaponModelName(weaponHash)
    for name, model in pairs(Config.Models) do
        if weaponHash == GetHashKey(name) then
            return GetHashKey(model)
        end
    end
    return nil
end

currWeapon = GetHashKey("WEAPON_UNARMED")

Citizen.CreateThread(function()
    while true do
        Wait(250)
        local playerPed = PlayerPedId()
        local weapon = GetSelectedPedWeapon(playerPed)
        local currentTime = GetGameTimer()

        -- Ignore weapon checks for 500 ms after toggle
        if currentTime - lastToggleTime < toggleCooldown then
            -- Just update currWeapon and skip checks
            currWeapon = weapon
        else
            if currWeapon ~= weapon then
			    if weapon == GetHashKey("WEAPON_UNARMED") or (sling and weapon ~= slungWeaponHash) then
			        currWeapon = weapon
			        sling = false
			        removeSlungWeapon()
			    else
			        if isWeaponSMG(weapon) and not recentlyUnslinged then
					    local vehicle = VehicleInFront()
					    if GetVehiclePedIsIn(playerPed, false) == 0 and (not DoesEntityExist(vehicle) or not IsEntityAVehicle(vehicle)) and not hasDuffelBag(playerPed) then
					        -- Not allowed: force unarmed and notify
					        drawNotification(Config.Warn)
					        SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
					    else
					        currWeapon = weapon
					    end
					else
					    currWeapon = weapon
					end
				end
			end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(250)
        local playerPed = PlayerPedId()
        local weapon = GetSelectedPedWeapon(playerPed)

        if weapon ~= currWeapon and weapon ~= GetHashKey("WEAPON_UNARMED") and isWeaponSMG(weapon) then
            local vehicle = VehicleInFront()
            if not hasDuffelBag(playerPed) and (not vehicle or not IsEntityAVehicle(vehicle)) then
                drawNotification(Config.Warn)
                SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
            end
        end
    end
end)

function attachSlungWeapon(modelHash)
    local playerPed = PlayerPedId()
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(100)
    end

    local boneIndex = GetPedBoneIndex(playerPed, 24818) -- Spine bone
    local coords = GetEntityCoords(playerPed)

    slungWeaponEntity = CreateObject(modelHash, coords.x, coords.y, coords.z, true, true, false)
    AttachEntityToEntity(slungWeaponEntity, playerPed, boneIndex, 0.0, -0.18, 0.05, 0.0, 0.0, 180.0, true, true, false, true, 1, true)
end

function removeSlungWeapon()
	if slungWeaponEntity ~= nil then
		DeleteEntity(slungWeaponEntity)
		slungWeaponEntity = nil
	end
end

function VehicleInFront()
	local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end

function isWeaponSlingable(model)
	for _, gun in pairs(Config.SlingableWeapons) do
		if model == GetHashKey(gun) then
			return true
		end
	end

	return false
end

if Config.EnableSling then
	RegisterCommand(Config.SlingCommand, function()
	    toggleSling()
	end, false)

	RegisterKeyMapping(Config.SlingCommand, "Toggle Weapon Sling", "keyboard", Config.SlingDefaultKey)

	function toggleSling()
		local playerPed = PlayerPedId()
	    local weapon = GetSelectedPedWeapon(playerPed)

	    if isWeaponSMG(weapon) and not sling then
	        drawNotification(Config.Sling)
	        sling = true
	        slungWeaponHash = weapon

	        local model = getWeaponModelName(weapon)
	        if model then
	            attachSlungWeapon(model)
	            currWeapon = GetHashKey("WEAPON_UNARMED")
	            SetCurrentPedWeapon(playerPed, currWeapon, true)
	            lastToggleTime = GetGameTimer()
	        else
	            drawNotification("Could not find weapon model to sling.")
	        end

	    elseif sling then
		    sling = false
		    GiveWeaponToPed(playerPed, slungWeaponHash, 250, false, true)
		    Citizen.Wait(100)
		    SetCurrentPedWeapon(playerPed, slungWeaponHash, true)
		    slungWeaponHash = nil
		    removeSlungWeapon()

		    recentlyUnslinged = true
		    Citizen.SetTimeout(2000, function()
		        recentlyUnslinged = false
		    end)
	    else
	        drawNotification(Config.Unsling)
	    end
	end
end


function hasDuffelBag(ped)
	local drawable = GetPedDrawableVariation(ped, 5)
	local texture = GetPedTextureVariation(ped, 5)
	local palette = GetPedPaletteVariation(ped, 5)

	-- Your specific duffelbag check
	return drawable == 45 and texture == 0 and palette == 0
end

function drawNotification(Notification)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(Config.Prefix .. "~c~" .. Notification)
	DrawNotification(false, false)
end
