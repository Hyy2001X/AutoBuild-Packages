m = Map("natter", translate("Port Settings"))
m.redirect = luci.dispatcher.build_url("admin", "network", "natter")

s = m:section(NamedSection, arg[1], "ports", "")
s.addremove = false
s.dynamic = false

local rand_remarks = luci.sys.exec("cut -d '-' -f1 /proc/sys/kernel/random/uuid 2> /dev/null")

enable_port = s:option(Flag, "enable_port", translate("Enable"))

remarks = s:option(Value, "remarks", translate("Remarks"))
remarks.default = rand_remarks
remarks.rmempty = false

forward_mode = s:option(ListValue, "forward_mode", translate("Forward Mode"))
forward_mode:value('1', translate("Natter"))
forward_mode:value('2', translate("Firewall"))
forward_mode.default = 2

external_port = s:option(Value, "external_port", translate("External Port"))
external_port.datatype = "port"
external_port:depends({forward_mode=2})

port_type = s:option(ListValue, "port_type", translate("Port Type"))
port_type:value("udp", translate("UDP"))
port_type:value("tcp", translate("TCP"))
port_type:value("both", translate("TCP + UDP"))
port_type.default = both
port_type.rempty = false

enable_forward = s:option(Flag, "enable_forward", translate("Enable Port Forward"))
enable_forward.default = 0

internal_ip = s:option(Value, "internal_ip", translate("Internal IP address"))
internal_ip.datatype = "ipmask4"
internal_ip:depends({enable_forward=1})
luci.sys.net.ipv4_hints(function(ip, name)
	internal_ip:value(ip, "%s (%s)" %{ ip, name })
end)

internal_port = s:option(Value, "internal_port", translate("Internal Port"))
internal_port.datatype = "port"
internal_port:depends({enable_forward=1})

delay = s:option(Value, "delay", translate("Start delay (Seconds)"))
delay.default = 0
delay.datatype = "uinteger"
delay.rmempty = false

log_level = s:option(ListValue, "log_level", translate("Log Level"))
log_level:value('debug', translate("Debug"))
log_level:value('info', translate("Info"))
log_level:value('warning', translate("Warning"))
log_level:value('error', translate("Error"))

hook = s:option(Value, "hook", translate("Hook"))
hook.rmempty = true

return m
