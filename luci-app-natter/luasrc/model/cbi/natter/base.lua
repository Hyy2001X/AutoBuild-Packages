m=Map("natter",translate("Natter"),translate("Open TCP Port under FullCone NAT (NAT 1)"))
s=m:section(TypedSection,"natter")

s.addremove=false
s.anonymous=true

enable=s:option(Flag,"enable",translate("Enable"))
enable.default= "0"
enable.rmempty=false

logfile=s:option(Value,"logfile",translate("Log File"))
logfile.default= "/tmp/natter.log"
logfile.rmempty=false

reload = s:option(Button, "reload", translate("Reload Service"))
reload.inputtitle = translate("Exec")
reload.write = function()
	luci.sys.call("/etc/init.d/natter restart > /dev/null")
end

clear_log = s:option(Button, "clear_log", translate("Clear Log"))
clear_log.inputtitle = translate("Exec")
clear_log.write = function()
	luci.sys.call("rm -f $(uci get natter.@natter[0].logfile 2>/dev/null) > /dev/null")
end

s = m:section(TypedSection, "ports")
s.anonymous = true
s.addremove = true
s.template = "cbi/tblsection"

enable_port = s:option(Flag, "enable_port", translate("Enable"))
enable_port.default = "1"
enable_port.rmempty = false

port = s:option(Value, "port", translate("Port"))
port.datatype = "port"
port.rmempty = false

address = s:option(Value, "address", translate("IP Address"))
address.datatype = "host"
address.rmempty = true

extra_options = s:option(Value, "extra_options", translate("Extra Options"))
extra_options.rmempty = true
extra_options.password= false

delay = s:option(Value, "delay", translate("Start delay (Seconds)"))
delay.default = "0"
delay.datatype = "uinteger"
delay.rmempty = false

enable_retry = s:option(Flag, "enable_retry", translate("Auto Retry"))
enable_retry.default = "1"
enable_retry.rmempty = false

return m
