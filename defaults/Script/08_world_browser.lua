-- WebView2 world panel. Opens only on a button click; one browser is shared.
local open = ui.button("world_open", "Open 3D browser ahead")
local place = ui.button("world_place", "Apply world position")
local close = ui.button("world_close", "Close shared browser")
local x = ui.slider("world_x", "World X", 0, -1000, 1000)
local y = ui.slider("world_y", "World Y", 1.5, -100, 100)
local z = ui.slider("world_z", "World Z", 0, -1000, 1000)
local yaw = ui.slider("world_yaw", "Panel yaw", 0, -180, 180)
local width = ui.slider("world_width", "Panel width", 2.4, 0.1, 10)
local height = ui.slider("world_height", "Panel height", 1.35, 0.1, 10)
local show = ui.checkbox("world_status", "Show browser status", false)
local opened = false

client.on("on_ui_change", function(id)
    if id == "world_open" then
        opened = browser.open("https://example.com", "3d")
        client.log("3D browser queued:", opened)
    elseif id == "world_place" then
        -- Absolute Unity world coordinates, not screen pixels.
        browser.place(x:get(), y:get(), z:get(), yaw:get(), width:get(), height:get())
    elseif id == "world_close" then
        browser.close()
        opened = false
    end
end)

client.on("on_frame", function()
    if not show:get() then return end
    local status = browser.status()
    local px, py = render.drag("world_browser", 24, 300, 460, 76)
    render.rect_filled(px, py, 460, 76, {18, 18, 24, 180}, 8)
    render.text(px + 12, py + 10, {220, 220, 255, 255},
        "3D browser | ready: " .. tostring(status.ready), 16)
    render.text(px + 12, py + 34, {200, 200, 210, 255}, status.title or "", 14)
    render.text(px + 12, py + 54, {190, 180, 220, 255}, status.error or "", 12)
end)

client.on("on_shutdown", function()
    if opened then browser.close() end
end)
client.log("Open places the panel ahead of the camera. Click it to focus; Esc releases input.")
