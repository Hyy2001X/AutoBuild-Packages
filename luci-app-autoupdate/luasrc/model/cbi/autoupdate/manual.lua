m = Map("autoupdate",translate("Manual Upgrade"),translate("Manually upgrade Firmware or Script"))
s = m:section(TypedSection,"autoupdate")
s.anonymous = true

local local_version = luci.sys.exec ("bash /bin/AutoUpdate.sh -V")
local local_script_version = luci.sys.exec ("bash /bin/AutoUpdate.sh -v")

check_updates = s:option (Button, "_check_updates", translate("Check Updates"),translate("Please Refresh the page after clicking Check Updates button"))
check_updates.inputtitle = translate ("Check Updates")
check_updates.write = function()
	luci.sys.call ("bash /bin/AutoUpdate.sh -V Cloud > /tmp/Cloud_Version")
	luci.sys.call ("bash /bin/AutoUpdate.sh -v Cloud > /tmp/Cloud_Script_Version")
end

local cloud_version = luci.sys.exec ("cat /tmp/Cloud_Version")
local cloud_script_version = luci.sys.exec ("cat /tmp/Cloud_Script_Version")

upgrade_firmware = s:option (Button, "_upgrade_firmware", translate("Upgrade Firmware"),translate("Common upgrade; Please wait patiently after clicking Do Upgrade button") .. "<br><br>当前固件版本: " .. local_version .. "<br>云端固件版本: " .. cloud_version)
upgrade_firmware.inputtitle = translate ("Do Upgrade")
upgrade_firmware.write = function()
	luci.sys.call ("bash /bin/AutoUpdate.sh -u -P > /dev/null &")
	luci.http.redirect(luci.dispatcher.build_url("admin", "system", "autoupdate","log"))
end

upgrade_firmware_nonkeep = s:option (Button, "_upgrade_firmware_nonkeep", translate("Upgrade Firmware"),translate("Upgrade without keeping System-Config"))
upgrade_firmware_nonkeep.inputtitle = translate ("Do Upgrade")
upgrade_firmware_nonkeep.write = function()
	luci.sys.call ("bash /bin/AutoUpdate.sh -u -n > /dev/null &")
	luci.http.redirect(luci.dispatcher.build_url("admin", "system", "autoupdate","log"))
end

upgrade_script = s:option (Button, "_upgrade_script", translate("Upgrade Script"),translate("Using the latest Script may solve some compatibility problems") .. "<br><br>当前脚本版本: " .. local_script_version .. "<br>云端脚本版本: " .. cloud_script_version)
upgrade_script.inputtitle = translate ("Do Upgrade")
upgrade_script.write = function()
	luci.sys.call ("bash /bin/AutoUpdate.sh -x -P > /dev/null &")
	luci.http.redirect(luci.dispatcher.build_url("admin", "system", "autoupdate","log"))
end

return m
