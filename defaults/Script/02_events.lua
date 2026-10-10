local enabled = ui.checkbox("enabled", "Event notifications", true)
local lifetime = ui.slider("lifetime", "Duration", 5, 1, 10)
local count = storage.get("hunts", 0)
local messages = {}

local function add(text, tint)
    if not enabled:get() then return end
    messages[#messages + 1] = {text = text, tint = tint, at = client.time()}
    if #messages > 5 then table.remove(messages, 1) end
    client.log(text)
end

client.on("on_hunt_start", function(event)
    count = count + 1
    storage.set("hunts", count)
    add("Hunt started / #" .. count, render.color(250, 105, 115))
end)
client.on("on_hunt_end", function(event)
    add(string.format("Hunt ended / %.1f s%s", event.duration,
        event.partial and " (partial)" or ""), render.color(130, 220, 170))
end)
client.on("on_ghost_event", function(event)
    add(event.test and "Test notification" or "Ghost event", render.color(155, 145, 250))
end)
client.on("on_incense", function(event)
    add("Incense used", render.color(240, 210, 120))
end)
client.on("on_frame", function(dt)
    if not enabled:get() then return end
    local width = render.screen()
    for i = #messages, 1, -1 do
        if client.time() - messages[i].at > lifetime:get() then
            table.remove(messages, i)
        end
    end
    for i, message in ipairs(messages) do
        local x, y = width / 2 - 160, 70 + (i - 1) * 42
        render.rect_filled(x, y, 320, 34, render.color(15, 14, 23, 225), 6)
        render.text(x + 12, y + 8, message.tint, message.text, 15)
    end
end)
client.log("Events ready. Existing active hunts do not emit a new start.")
