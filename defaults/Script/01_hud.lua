local function tr(en, ru) return settings.get("ui_language") == 1 and ru or en end
-- Unix Lua: custom HUD, with controls in the Lua tab.
local enabled = ui.checkbox("enabled", "Custom HUD", true)
local x = ui.slider("x", "Position X", 24, 0, 1920)
local y = ui.slider("y", "Position Y", 140, 0, 1080)
local accent = ui.color("accent", "Accent", render.color(110, 100, 240))

client.on("on_frame", function(dt)
    if not enabled:get() then return end
    local status = game.status()
    local ghost = game.ghost()
    local px, py = x:get(), y:get()
    if render.drag then px, py = render.drag("main", px, py, 300, 94) end
    render.rect_filled(px, py, 300, 94, render.color(12, 12, 18, 220), 8)
    render.rect_filled(px, py, 3, 94, accent:get(), 1)
    render.text(px + 14, py + 12, accent:get(), "Unix / Lua HUD", 17)
    render.text(px + 14, py + 37, render.color(235, 232, 245),
        string.format("%.0f fps | %s ping", client.fps(),
            status.ping >= 0 and tostring(status.ping) .. " ms" or "--"), 15)
    local sanity = status.sanity_valid and string.format("%.0f%%", status.sanity) or "--"
    local kind = ghost.valid and ghost.type or "--"
    render.text(px + 14, py + 63, render.color(185, 180, 210),
        tr("Sanity: ","Рассудок: ") .. sanity .. tr(" | Ghost: "," | Призрак: ") .. kind, 14)
end)

client.on("on_ui_change", function(id, value)
    client.log("Changed", id, value)
end)
client.log("HUD ready. Its position and color are saved per script.")
