local bridgeCoords = vector3(545.3, 1735.2, 187.8)

---Return the rayfire map object of the baccus bridge.
---@return number
local function GetBacchusBridgeRayfireMapObject()
    return GetRayfireMapObject(bridgeCoords.x, bridgeCoords.y, bridgeCoords.z, 100.0, "des_trn3_bridge")
end

---Set the state of the bacchus bridge
---@param state number
local function SetBacchusBridgeState(state)
    local rayfireMapObject = GetBacchusBridgeRayfireMapObject()
    if (not DoesRayfireMapObjectExist(rayfireMapObject)) then return end
    SetStateOfRayfireMapObject(rayfireMapObject, state)
end

---Return the state of the bacchus bridge
---@return number
local function GetBacchusBridgeState()
    local rayfireMapObject = GetBacchusBridgeRayfireMapObject()
    if (not DoesRayfireMapObjectExist(rayfireMapObject)) then return -1 end
    return GetStateOfRayfireMapObject(rayfireMapObject)
end

---Set the bacchus bridge to destroyed or not.
---@param isDestroyed boolean
local function SetBacchusBridgeDestroyed(isDestroyed)
    SetBacchusBridgeState(isDestroyed and 9 or 4)
end

---Destroy the bacchus bridge.
local function DestroyBacchusBridge()
    SetBacchusBridgeState(6)
    TriggerEvent("srb_bacchusbridge:OnDestroyBacchusBridge")
end

---Set the bacchus bridge state.
---@param destroy boolean
RegisterNetEvent("srb_bacchusbridge:Client:SetBacchusBridgeDestroyed", function(destroy)
    TriggerEvent("srb_bacchusbridge:OnBacchusBridgeStateChange", destroy)
    if (destroy) then
        DestroyBacchusBridge()
    else
        SetBacchusBridgeDestroyed(false)
    end
end)

---Replicate the bacchus bridge state if the player was not in the area when the bridge was destroyed/rebuilt.
Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(2000)
        
        if (#(GetEntityCoords(PlayerPedId()) - bridgeCoords) < 100.0) then
            local state = GetBacchusBridgeState()
            if ((state == 3 or state == 5) and GlobalState.isBacchusBridgeDestroyed) then -- Not destroyed
                SetBacchusBridgeDestroyed(true)
            elseif (state == 10 and not GlobalState.isBacchusBridgeDestroyed) then -- Destroyed
                SetBacchusBridgeDestroyed(false)
            end
        end
    end
end)