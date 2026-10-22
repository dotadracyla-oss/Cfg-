-- Read-only discovery for the installed build. No features or actions run.
local settings_button = ui.button("catalog_settings", "List native settings")
local features_button = ui.button("catalog_features", "List ported feature groups")
local actions_button = ui.button("catalog_actions", "List available action IDs")

client.on("on_ui_change", function(id)
    if id == "catalog_settings" then
        local list = settings.list()
        client.log("Native settings:", #list)
        for _, item in ipairs(list) do
            client.log(item.name, item.type, item.min, item.max, settings.get(item.name))
        end
    elseif id == "catalog_features" then
        local groups = features.list()
        local names = {}
        for name in pairs(groups) do names[#names + 1] = name end
        table.sort(names)
        client.log("Ported feature groups:", #names)
        for _, name in ipairs(names) do
            local keys = {}
            for key in pairs(groups[name]) do keys[#keys + 1] = key end
            table.sort(keys)
            client.log(name .. ": " .. table.concat(keys, ", "))
        end
    elseif id == "catalog_actions" then
        local actions = features.actions()
        table.sort(actions)
        client.log("Available actions:", #actions)
        for _, action in ipairs(actions) do client.log(action) end
    end
end)
client.log("Use the buttons, then open the Lua console. This script only reads metadata.")
