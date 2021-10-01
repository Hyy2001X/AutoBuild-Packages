m=Map("npc")
m.title=translate("NPS Client")
m.description=translate("Nps is a fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet.")

m:section(SimpleSection).template  = "npc/npc_status"

s=m:section(TypedSection,"npc")
s.addremove=false
s.anonymous=true

s:tab("basic",translate("Basic Setting"))
enable=s:taboption("basic",Flag,"enabled",translate("Enable"))
enable.rmempty=false

server=s:taboption("basic",Value,"server_addr",translate("Server Address"),translate("Server IPv4 address or Domain Name"))
server.optional=false
server.rmempty=false

port=s:taboption("basic",Value,"server_port",translate("Port"))
port.datatype="port"
port.default="8024"
port.optional=false
port.rmempty=false

vkey=s:taboption("basic",Value,"vkey",translate("vkey"))
vkey.optional=false
vkey.password=true
vkey.rmempty=false

protocol=s:taboption("basic",ListValue,"protocol",translate("Protocol Type"))
protocol.default="tcp"
protocol:value("tcp",translate("TCP Protocol"))
protocol:value("kcp",translate("KCP Protocol"))

max_conn=s:taboption("basic",Value,"max_conn",translate("Max Connection"),translate("Maximum number of connections (Not necessary)"))
max_conn.optional=true
max_conn.rmempty=true

rate_limit=s:taboption("basic",Value,"rate_limit",translate("Rate Limit"),translate("Client rate limit (Not necessary)"))
rate_limit.optional=true
rate_limit.rmempty=true

flow_limit=s:taboption("basic",Value,"flow_limit",translate("Flow Limit"),translate("Client flow limit (Not necessary)"))
flow_limit.optional=true
flow_limit.rmempty=true

compress=s:taboption("basic",Flag,"compress",translate("Enable Compression"),translate("The contents will be compressed to speed up the traffic forwarding speed, but this will consume some additional cpu resources."))
compress.default="0"
compress.rmempty=false

crypt=s:taboption("basic",Flag,"crypt",translate("Enable Encryption"),translate("Encrypted the communication between Npc and Nps, will effectively prevent the traffic intercepted."))
crypt.default="0"
crypt.rmempty=false

log_path=s:taboption("basic",Value,"log_path",translate("Log Path"))
log_path.optional=false
log_path.rmempty=false
log_path.default="/tmp/npc.log"

log_level=s:taboption("basic",ListValue,"log_level",translate("Log Level"))
log_level:value(0,"Emergency")
log_level:value(2,"Critical")
log_level:value(3,"Error")
log_level:value(4,"Warning")
log_level:value(7,"Debug")
log_level.default="3"

return m