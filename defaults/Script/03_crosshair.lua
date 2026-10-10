local enabled = ui.checkbox("enabled", "Lua crosshair", true)
local size = ui.slider("size", "Radius", 14, 3, 80)
local speed = ui.slider("speed", "Rotation speed", 1, -4, 4)
local style = ui.combo("style", "Style", {"Rotating cross", "Ring"}, 1)
local tint = ui.color("tint", "Color", render.color(145, 120, 255))
local reset = ui.button("reset", "Reset angle")
local angle = 0

client.on("on_frame", function(dt)
    if reset:get() then angle = 0 end
    if not enabled:get() then return end
    angle = (angle + dt * speed:get()) % (math.pi * 2)
    local w, h = render.screen()
    local x, y, radius = w / 2, h / 2, size:get()
    if style:get() == 2 then
        render.circle(x, y, radius, tint:get(), 2)
        return
    end
    for i = 0, 3 do
        local a = angle + i * math.pi / 2
        local dx, dy = math.cos(a), math.sin(a)
        render.line(x + dx * 3, y + dy * 3,
            x + dx * radius, y + dy * radius, tint:get(), 2)
    end
end)
client.log("Crosshair ready. Built-in crosshair is independent.")
