-- One shared embedded WebView2 browser; Runtime must be installed.
local two = ui.button("two", "Open 2D browser")
local three = ui.button("three", "Open 3D browser")
local both = ui.button("both", "Open both modes")
local close = ui.button("close", "Close browser")
client.on("on_ui_change", function(id)
    if id == "two" then browser.open("https://www.google.com", "2d") end
    if id == "three" then browser.open("https://www.google.com", "3d") end
    if id == "both" then browser.open("https://www.google.com", "both") end
    if id == "close" then browser.close() end
end)
client.on("on_shutdown", function() browser.close() end)
