-- Unix Lua API 2.0: alpha is 0..255; zero removes the background.
local alpha = ui.slider("alpha", "HUD background alpha", 100, 0, 255)
local opacity = ui.slider("opacity", "HUD opacity", 1, 0, 1)
client.on("on_frame", function()
    render.layer("background")
    render.opacity(opacity:get())
    local px, py = 24, 180
    if render.drag then px, py = render.drag("transparent", px, py, 250, 72) end
    render.rect_filled(px, py, 250, 72, {18, 18, 24, alpha:get()}, 10)
    render.text(px + 12, py + 12, {255, 255, 255, 255}, "Unix custom HUD", 18)
    render.text(px + 12, py + 40, {180, 180, 200, 255}, "FPS: " .. math.floor(client.fps()), 14)
end)
