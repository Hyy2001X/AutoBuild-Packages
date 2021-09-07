module("luci.controller.autoupdate",package.seeall)

function index()
	if not nixio.fs.access("/etc/config/iperf3-server") then
		return
	end

	entry({"admin","system","autoupdate"},cbi("autoupdate"),_("AutoUpdate"),99)
end
