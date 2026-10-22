-- Uses native HUD cards; no guessed countdowns or protection guarantees.
local incense = ui.checkbox("native_incense", "Native incense timer",
    settings.get("incense_timer") == true)
local crucifix = ui.checkbox("native_crucifix", "Native crucifix status",
    settings.get("crucifix_hud") == true)
local streamproof = ui.checkbox("native_streamproof", "Stream proof",
    settings.get("streamproof") == true)
local refresh = ui.button("native_refresh", "Read current native settings")

client.on("on_ui_change", function(id, value)
    if id == "native_incense" then
        settings.set("incense_timer", value)
    elseif id == "native_crucifix" then
        settings.set("crucifix_hud", value)
    elseif id == "native_streamproof" then
        settings.set("streamproof", value)
    elseif id == "native_refresh" then
        incense:set(settings.get("incense_timer") == true)
        crucifix:set(settings.get("crucifix_hud") == true)
        streamproof:set(settings.get("streamproof") == true)
    end
end)
client.log("Controls apply when changed. Stop leaves native settings as selected.")
client.log("Incense shows prevention/distraction separately; crucifix shows uses, base radius and distance.")
