if not fs.exists("LogAPI") then
    shell.run("wget run https://raw.githubusercontent.com/AntonBolte/LogAPI/refs/heads/master/LogAPI_installer.lua")
end

local Log = require("LogAPI")
local modem = peripheral.find("modem") or error("No modem found", 0)
Log.SetLogPath("RedEar/Logs/RedEarLog.txt")
local dbPath = "RedEar/Database.json"

for i = 65500, 65535 do
    modem.open(i)
    Log.Comment("Opened port " .. i)
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

    Log.Comment("Storing message in database...\n" .. textutils.serialize(packet))

    local db = fs.open(dbPath, "w")
    db.writeLine(textutils.serializeJSON(packet))
    db.close()
    end
    
