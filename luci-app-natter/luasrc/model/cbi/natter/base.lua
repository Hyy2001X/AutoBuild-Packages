m = Map("natter", translate("Natter"), translate("Open Port under FullCone NAT (NAT 1)"))
s = m:section(TypedSection, "base")

s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("Enable"))
enable.default = 0

enable_fullcone_nat = s:option(Flag, "enable_fullcone_nat", translate("Enable FullCone NAT (NAT 1)"))
enable_fullcone_nat.default = 0

local_ip = s:option(Value, "local_ip", translate("Local IP Address"))
local_ip.default = "0.0.0.0"
local_ip.placeholder = "0.0.0.0"
local_ip.datatype = "host"
local_ip.rmempty = false

log_path = s:option(Value, "log_path", translate("Log Path"), translate("Directory to save natter logs"))
log_path.default = "/tmp/natter"
log_path.placeholder = "/tmp/natter"
log_path.rmempty = false

keep_alive_server = s:option(Value, "keep_alive_server", translate("Keep Alive Server"))
keep_alive_server.rmempty = false

tcp_stun_server = s:option(DynamicList, "tcp_stun_server", translate("TCP STUN Server"), translate("Please DO NOT handle the IP address/domain name/port of the TCP/UDP STUN server (3478) while running proxy"))
udp_stun_server = s:option(DynamicList, "udp_stun_server", translate("UDP STUN Server"))
udp_stun_server.rmempty = false

--[[
s = m:section(TypedSection, "stun_servers", translate("STUN Server Settings"))

s.addremove = true
s.anonymous = true
s.template = "cbi/tblsection"

enable_stun_server = s:option(Flag, "enable_stun_server", translate("Enable"))
enable_stun_server.default = 1
enable_stun_server.rmempty = false

stun_server_name = s:option(Value, "stun_server_name", translate("STUN Server Name"))
stun_server_name.rmempty = true 

stun_server_domain = s:option(Value, "stun_server_domain", translate("STUN Server Domain"))
stun_server_domain.rmempty = false 

stun_server_type = s:option(ListValue, "stun_server_type", translate("STUN Server Type"))
stun_server_type:value("udp", translate("UDP"))
stun_server_type:value("tcp", translate("TCP"))
stun_server_type.default = tcp
stun_server_type.rempty = false
--]]

s = m:section(TypedSection, "ports", translate("Port Settings"))
s.anonymous = true
s.addremove = true
s.template = "cbi/tblsection"
s.extedit = luci.dispatcher.build_url("admin", "network", "natter", "ports", "%s")
function s.create(...)
	local sid = TypedSection.create(...)
	if sid then
		luci.http.redirect(s.extedit % sid)
		return
	end
end

enable_port = s:option(Flag, "enable_port", translate("Enable"))
enable_port.default = 1
enable_port.width = "5%"

remarks = s:option(DummyValue, "remarks", translate("Remarks"))
remarks.width = "10%"

forward_mode = s:option(DummyValue, "forward_mode", translate("Forward Mode"))
forward_mode.width = "8%"

external_port = s:option(DummyValue, "external_port", translate("External Port"))
external_port.width = "12%"

enable_forward = s:option(Flag, "enable_forward", translate("Forward"))
enable_forward.default = 0

internal_ip = s:option(DummyValue, "internal_ip", translate("Internal IP Address"))
internal_ip.width = "12%"

internal_port = s:option(DummyValue, "internal_port", translate("Internal Port"))
internal_port.width = "12%"

return m
