local WriteInfoLogs = false -- Set to true to enable info logging

local ItemToWatch = "80"
local ItemQuantityToAdd = 1

local ItemManager = sdk.get_managed_singleton("app.ItemManager")
local CharacterManager = sdk.get_managed_singleton("app.CharacterManager")

-- Log Functions
local function log_info(infoMessage)
    if WriteInfoLogs then
        log.info("[Mr. Boobie Buyer > Eternal Ferrystone]: " .. infoMessage)
    end
end

local function log_error(errorMessage)
    log.error("[Mr. Boobie Buyer > Eternal Ferrystone]: " .. errorMessage)
end

-- Function to add the item back to the player's inventory
local function add_item_back_to_inventory()
    local playerCharacter = CharacterManager:get_field("<ManualPlayer>k__BackingField")
    if playerCharacter then
        ItemManager:call("getItem", 80, ItemQuantityToAdd, 2891076981, false, false, false, 0)
        log_info("Item with ID " .. ItemToWatch .. " added back to inventory.")
    else
        log_error("Player character ID not found, cannot add item back.")
    end
end

-- Hook
sdk.hook(sdk.find_type_definition("app.FerrystoneFlowController"):get_method("startReal"),
    function(args)
        add_item_back_to_inventory()
    end,
    nil
)