---Set the bacchus bridge to destroyed or not.
---@param isDestroyed boolean
function SetBacchusBridgeDestroyed(isDestroyed)
    if (GlobalState.isBacchusBridgeDestroyed == isDestroyed) then return end
    GlobalState.isBacchusBridgeDestroyed = isDestroyed
end
exports("SetDestroyed", SetBacchusBridgeDestroyed)

---Destroy or rebuild the Bacchus Bridge on server state change.
AddStateBagChangeHandler("isBacchusBridgeDestroyed", nil, function(bagName, key, value)
    if (key ~= "isBacchusBridgeDestroyed") then return end
    TriggerEvent("srb_bacchusbridge:OnBacchusBridgeStateChange", value)
    TriggerClientEvent("srb_bacchusbridge:Client:SetBacchusBridgeDestroyed", -1, value)
end)

---Destroy the bridge with animation.
RegisterServerEvent("srb_bacchusbridge:Server:DestroyBacchusBridge", function()
    SetBacchusBridgeDestroyed(true)
end)

---Initialize the bacchus bridge state.
Citizen.CreateThread(function()
    SetBacchusBridgeDestroyed(Config.IsDestroyed)
end)

if (Config.Command) then
    RegisterCommand(Config.Command, function(source, args)
        if (source == 0 or IsPlayerAceAllowed(source, "srb_bacchusbridge.setDestroyed")) then
            local destroy = args[1] == "1"
            SetBacchusBridgeDestroyed(destroy)
        end
    end, false)
end