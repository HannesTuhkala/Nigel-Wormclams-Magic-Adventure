local hooks = {}
hooks.internal = {}

hooks.add = function(event, id, fn)
	local ev = hooks.internal[event]
	
	if not ev then
		hooks.internal[event] = {fn}
	else
		ev = table.insert(ev, fn)
		hooks.internal[event] = ev
	end
end

hooks.run = function(event, ...)
	local fn_table = hooks.internal[event]
	if not fn_table then return end
	
	local args = {...}
	for _, fn in pairs(fn_table) do
		fn(args)
	end
end

return hooks