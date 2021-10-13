m = Map("iperf3-server", translate("iPerf3 Server"),translate("iPerf - The ultimate speed test tool for TCP, UDP and SCTP"))

m:section(SimpleSection).template  = "iperf3-server/iperf3-server_status"

s = m:section(TypedSection,"iperf3-server","")
s.addremove = false
s.anonymous = true

enable=s:option(Flag, "enable", translate("Enable"))
enable.default = "0"
enable.rmempty = false

port=s:option(Value, "port", translate("Port"),translate("iPerf3 Server listening port"))
port.datatype = "port"
port.default="5201"
port.optional=false
port.rmempty=false

options=s:option(Value, "options", translate("Extra options"),translate("Incorrect options may cause iPerf3 Server to fail to start"))
options.optional=true
options.rmempty=true

return m
