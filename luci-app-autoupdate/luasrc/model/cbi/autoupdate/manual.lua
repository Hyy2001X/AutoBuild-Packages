m = Map("autoupdate",translate("Manual Upgrade"),translate("Manual upgrade Firmware,pause Check Updates button before Upgrade Firmware"))
s = m:section(TypedSection,"autoupdate")
s.anonymous = true

local local_version = luci.sys.exec ("bash /bin/AutoUpdate.sh -V")
local local_script_version = luci.sys.exec ("bash /bin/AutoUpdate.sh -v")

bt_check_updates = s:option (Button, "_bt_check_updates", translate("Check Updates"),translate("Please Refresh the page after clicking Check Updates button"))
bt_check_updates.inputtitle = translate ("Check Updates")
bt_check_updates.write = function()
	luci.sys.call ("bash /bin/AutoUpdate.sh -V Cloud > /tmp/Cloud_Version")
	luci.sys.call ("bash /bin/AutoUpdate.sh -v Cloud > /tmp/Cloud_Script_Version")
end

local cloud_version = luci.sys.exec ("cat /tmp/Cloud_Version")
local cloud_script_version = luci.sys.exec ("cat /tmp/Cloud_Script_Version")

bt_upgrade_firmware = s:option (Button, "_bt_upgrade_firmware", translate("Upgrade Firmware"),translate("Common upgrade; Please wait patiently after clicking Do Upgrade button") .. "<br><br>当前固件版本: " .. local_version .. "<br>云端固件版本: " .. cloud_version)
bt_upgrade_firmware.inputtitle = translate ("Do Upgrade")
bt_upgrade_firmware.write = function()
	luci.sys.call ("bash /bin/AutoUpdate.sh -u -P > /dev/null &")
	luci.http.redirect(luci.dispatcher.build_url("admin", "system", "autoupdate","log"))
end

bt_upgrade_firmware_nonkeep = s:option (Button, "_bt_upgrade_firmware_nonkeep", translate("Upgrade Firmware"),translate("Upgrade without keeping System-Config"))
bt_upgrade_firmware_nonkeep.inputtitle = translate ("Do Upgrade")
bt_upgrade_firmware_nonkeep.write = function()
	luci.sys.call ("bash /bin/AutoUpdate.sh -u -n > /dev/null &")
	luci.http.redirect(luci.dispatcher.build_url("admin", "system", "autoupdate","log"))
end

bt_upgrade_script = s:option (Button, "_bt_upgrade_script", translate("Upgrade Script"),translate("This may solve some compatibility issues") .. "<br><br>当前脚本版本: " .. local_script_version .. "<br>云端脚本版本: " .. cloud_script_version)
bt_upgrade_script.inputtitle = translate ("Do Upgrade")
bt_upgrade_script.write = function()
	luci.sys.call ("bash /bin/AutoUpdate.sh -x -P > /dev/null &")
	luci.http.redirect(luci.dispatcher.build_url("admin", "system", "autoupdate","log"))
end

return m
