-- Async request. No network traffic until the button is clicked.
local send = ui.button("send", "Fetch example.com")
local open = ui.button("open", "Open browser")
local pending
client.on("on_ui_change", function(id)
    if id == "send" and not pending then
        pending = http.request("https://example.com", {method="GET", headers={Accept="text/html"}})
    elseif id == "open" then browser.open("https://example.com") end
end)
client.on("on_frame", function()
    if not pending then return end
    local response, err = http.poll(pending)
    if err then client.error(err); pending=nil; return end
    if response then
        client.log("HTTP", response.status, "bytes", #response.body, response.error)
        pending=nil
    end
end)
