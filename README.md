## Description
Replicate bacchus bridge destruction.

## Installation
- add_ace group.admin srb_bacchusbridge.setDestroyed allow
- ensure srb_bacchusbridge

## Usage
To destroy the bridge type: /setBacchusBridgeDestroyed 1 

## For developers
### Functions
```lua
exports.srb_bacchusbridge:SetDestroyed(true)
```

### Events (server & client sides)
```lua
---Called when bridge state changed
---@param destroy boolean
AddEventHandler("srb_bacchusbridge:OnBacchusBridgeStateChange", function(destroy)
    -- ...
end)
```

https://github.com/user-attachments/assets/fc9e11f2-020d-4cda-8ac0-cd7adfddfb83
