module("luci.controller.natter",package.seeall)

function index()
	if not nixio.fs.access("/etc/config/natter") then
		return
	end
	entry({"admin", "network", "natter"}, alias("admin", "network", "natter", "base"), _("Natter"), 99).dependent = true
	entry({"admin", "network", "natter", "base"}, cbi("natter/base"), _("Base Settings"), 10).leaf = true
	entry({"admin", "network", "natter", "log"}, form("natter/log"), _("Log"), 30).leaf = true
	entry({"admin", "network", "natter", "print_log"}, call("print_log")).leaf = true
end

local logfile = luci.sys.exec("uci get natter.@natter[0].logfile 2> /dev/null")
function print_log()
	luci.http.write(luci.sys.exec("cat " .. logfile .. " 2> /dev/null"))
end