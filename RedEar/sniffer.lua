--[RedEar listner/sniffer]--
local modem = peripheral.find("modem") or error("No modem found", 0)
local dbPath = "RedEar/Database.json"
local Log = dofile("/LogAPI.lua")
local width, height = term.getSize()

for i = 65500, 65535 do
    modem.open(i)
    Log.Comment("Opened port " .. i, "Sniffer")
end

while true do
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    local startTime = os.clock()
    Log.Info(("Message received on side %s on channel %d (reply to %d) from %f blocks away with message %s"):format(
        side, channel, replyChannel, distance, textutils.serialize(message)))

    local packet = {
        ts = os.time("utc"),
        sCh = channel,
        rCh = replyChannel,
        dist = distance,
        msg = message,
    }

    Log.Comment("Storing message in database...", "Sniffer")

    local db = fs.open(dbPath, "a")
    db.write(textutils.serializeJSON(packet))
    db.close()

    Log.Info("Message stored in database.", "Sniffer")

    local Time = os.clock() - startTime
    Log.Info("Message processed and stored in " .. Time .. " seconds.", "Sniffer")

    print(("#"):rep(width))
    end