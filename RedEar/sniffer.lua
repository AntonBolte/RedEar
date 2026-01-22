--[RedEar listner/sniffer]--
local modem = peripheral.find("modem") or error("No modem found", 0)
local dbPath = "RedEar/Database.json"
local Log = dofile("/LogAPI.lua")

for i = 65500, 65535 do
    modem.open(i)
    Log.Comment("Opened port " .. i, "Sniffer")
end

while true do
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
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

    local db = fs.open(dbPath, "w")
    db.writeLine(textutils.serializeJSON(packet))
    db.close()
    end
    
