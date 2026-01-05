m = Map("system", translate("Shutdown / Reboot"),
    translate("Use the buttons below to reboot or shut down the device. Actions are executed via XHR without reloading the page."))

s = m:section(SimpleSection)
s.template = "shutdown/actions"

return m
