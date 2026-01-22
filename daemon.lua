--[RedEar daemon]--
print("Starting RedEar Daemon...")
shell.run("wget run https://raw.githubusercontent.com/AntonBolte/LogAPI/refs/heads/master/LogAPI_installer.lua")
local Log = require("LogAPI")
Log.SetLogPath("/RedEar/logs/")

Log.Info("RedEar Daemon initializing...", "Daemon")

--Updating/Installing sniffer
Log.Install("https://raw.githubusercontent.com/AntonBolte/RedEar/refs/heads/master/RedEar/sniffer.lua", "/RedEar/sniffer.lua")

local snifferID = multishell.launch({}, "/RedEar/sniffer.lua")
multishell.setTitle(snifferID, "RE Sniffer")

local daemonID = multishell.getCurrent()
multishell.setTitle(daemonID, "RE Daemon")

Log.Info("RedEar Sniffer shell started. Shell ID: " .. snifferID, "Daemon")


