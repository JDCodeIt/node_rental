-- node_renta mod by JDCodeIt
-- Based on node_ownership
-- License: LGPLv3

node_rental = {}
node_rental.adminPrivs = {node_rental=true}
node_rental.startTime = os.clock()

node_rental.modpath = minetest.get_modpath("node_rental")
dofile(node_rental.modpath.."/settings.lua")
dofile(node_rental.modpath.."/internal.lua")
dofile(node_rental.modpath.."/nodes.lua")
dofile(node_rental.modpath.."/crafting.lua")
dofile(node_rental.modpath.."/chatcommands.lua")

node_rental:load()

minetest.register_privilege("node_rental", {
	description = "Can administer node_rental."
})

if minetest.setting_getbool("log_mod") then
	local diffTime = os.clock() - node_rental.startTime
	minetest.log("action", "node_rental loaded in "..diffTime.."s.")
end

