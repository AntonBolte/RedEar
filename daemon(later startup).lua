--[RedEar daemon]--
print("Starting RedEar Daemon...")
shell.run("wget run https://raw.githubusercontent.com/AntonBolte/LogAPI/refs/heads/master/LogAPI_installer.lua /Redear/APIs/LogAPI.lua")
local Log = require("/Redear/APIs/LogAPI")
Log.SetLogPath("/RedEar/logs/")

Log.Info("RedEar Daemon initializing...", "Daemon")

--Updating/Installing sniffer
Log.Install("https://raw.githubusercontent.com/AntonBolte/RedEar/refs/heads/master/RedEar/sniffer.lua")

local snifferID = multishell.launchShell("/RedEar/sniffer.lua")
multishell.setTitle(snifferID, "RE Sniffer")

local daemonID = multishell.getCurrent()
multishell.setTitle(daemonID, "RE Daemon")

Log.Info("RedEar Sniffer shell started. Shell ID: " .. snifferID, "Daemon")

