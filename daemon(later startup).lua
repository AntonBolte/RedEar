--[RedEar daemon]--
print("Starting RedEar Daemon...")

if not fs.exists("/Redear/APIs/LogAPI") then
    print("LogAPI not found. Installing...")
    shell.run("wget run https://raw.githubusercontent.com/AntonBolte/LogAPI/refs/heads/master/LogAPI_installer.lua /Redear/APIs/LogAPI")
end
local Log = require("/Redear/APIs/LogAPI")
Log.SetLogPath("/RedEar/logs/")

LogInfo("RedEar Daemon initializing...", "Daemon")

local snifferID = multishell.launchShell("/RedEar/sniffer.lua")
multishell.setTitle(snifferID, "RE Sniffer")

local daemonID = multishell.getCurrent()
multishell.setTitle(daemonID, "RE Daemon")

Log.Info("RedEar Sniffer shell started. Shell ID: " .. snifferID, "Daemon")

