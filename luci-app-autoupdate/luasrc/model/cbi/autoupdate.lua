require("luci.sys")

m = Map("autoupdate",translate("AutoUpdate"),
translate("AutoUpdate LUCI supports one-click firmware upgrade and scheduled upgrade")
.. [[<br /><br /><a href="https://github.com/Hyy2001X/AutoBuild-Actions">]]
.. translate("Powered by AutoBuild-Actions")
.. [[</a>]]
)

s = m:section(TypedSection,"autoupdate","")
s.anonymous = true
s.reset = false

o = s:option(Flag, "enable", translate("Enable"),translate("Automatically update firmware during the specified time"))
o.default = 0
o.optional = false
o = s:option(Flag, "proxy", translate("Enable Preference Proxy"),translate("Preference Proxy for speeding up downloads"))
o.default = 0
o.optional = false
o = s:option(Flag, "forceflash", translate("Enable Force Flashing"),translate("Preference Force Flashing while firmware upgrading"))
o.default = 0
o.optional = false

week = s:option(ListValue,"week",translate("AutoUpdate Day"),translate("Recommend to upgrade the firmware automatically at idle time"))
week:value(7,translate("Everyday"))
week:value(1,translate("Monday"))
week:value(2,translate("Tuesday"))
week:value(3,translate("Wednesday"))
week:value(4,translate("Thursday"))
week:value(5,translate("Friday"))
week:value(6,translate("Saturday"))
week:value(0,translate("Sunday"))
week.default = 0

hour = s:option(Value,"hour",translate("AutoUpdate Hour"))
hour.datatype = "range(0,23)"
hour.rmempty = false

minutes = s:option(Value,"minute",translate("AutoUpdate Minute"))
minutes.datatype = "range(0,59)"
minutes.rmempty = false

autocheck = s:option(Value,"autocheck",translate("Check Freq"),translate("Check updates only period periodically 0: Disable"))
autocheck.datatype = "range(0,23)"
autocheck.rmempty = false

local github_url = luci.sys.exec("bash /bin/AutoUpdate.sh --var Github")
o = s:option(Value,"github",translate("Github Url"),translate("For detecting cloud firmware version and downloading firmware"))
o.default = github_url

local local_version = luci.sys.exec ("bash /bin/AutoUpdate.sh -V")
local local_script_version = luci.sys.exec ("bash /bin/AutoUpdate.sh -v")

button_check_updates = s:option (Button, "_button_check_updates", translate("Check Updates"),translate("Please Refresh the page after clicking Check Updates button"))
button_check_updates.inputtitle = translate ("Check Updates")
button_check_updates.write = function()
	luci.sys.call ("bash /bin/AutoUpdate.sh -V Cloud > /tmp/Cloud_Version")
	luci.sys.call ("bash /bin/AutoUpdate.sh -v Cloud > /tmp/Cloud_Script_Version")
end

local cloud_version = luci.sys.exec ("cat /tmp/Cloud_Version")
local cloud_script_version = luci.sys.exec ("cat /tmp/Cloud_Script_Version")

button_upgrade_firmware = s:option (Button, "_button_upgrade_firmware", translate("Upgrade Firmware"),
translatef("Common upgrade; Please wait patiently after clicking Do Upgrade button") .. "<br><br>当前固件版本: " .. local_version .. "<br>云端固件版本: " .. cloud_version)
button_upgrade_firmware.inputtitle = translate ("Do Upgrade")
button_upgrade_firmware.write = function()
	luci.sys.call ("bash /bin/AutoUpdate.sh -u -P > /dev/null")
end

button_upgrade_firmware_nonkeep = s:option (Button, "_button_upgrade_firmware_nonkeep", translate("Upgrade Firmware"),translate("Upgrade without keeping System-Config"))
button_upgrade_firmware_nonkeep.inputtitle = translate ("Do Upgrade")
button_upgrade_firmware_nonkeep.write = function()
	luci.sys.call ("bash /bin/AutoUpdate.sh -u -n > /dev/null")
end

button_upgrade_script = s:option (Button, "_button_upgrade_script", translate("Upgrade Script"),
translatef("This may solve some compatibility issues") .. "<br><br>当前脚本版本: " .. local_script_version .. "<br>云端脚本版本: " .. cloud_script_version)
button_upgrade_script.inputtitle = translate ("Do Upgrade")
button_upgrade_script.write = function()
	luci.sys.call ("bash /bin/AutoUpdate.sh -x > /dev/null")
end

local e=luci.http.formvalue("cbi.apply")
if e then
	io.popen("/etc/init.d/autoupdate restart")
end

return m