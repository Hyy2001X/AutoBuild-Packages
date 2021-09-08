m = Map("iperf3-server", translate("iPerf3 Server"),translate("iPerf - The ultimate speed test tool for TCP, UDP and SCTP"))

m:section(SimpleSection).template  = "iperf3-server/iperf3-server_status"

s = m:section(TypedSection,"iperf3-server","")
s.addremove = false
s.anonymous = true

enable=s:option(Flag, "enabled", translate("Enabled"))
enable.default = "0"
enable.rmempty = false

port=s:option(Value, "port", translate("Port"),translate("Server port to listen on"))
port.datatype = "port"

options=s:option(Value, "options", translate("Extra options"),translate("Incorrect options may cause iPerf3 Server to fail to start"))

tips=s:option(TextValue, "tips", translate("Option tips"),translate("For reference only"))

local e=luci.http.formvalue("cbi.apply")
if e then
	io.popen("/etc/init.d/iperf3-server restart")
end
 
return m
