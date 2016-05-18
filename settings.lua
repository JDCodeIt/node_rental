local world_path = minetest.get_worldpath()

node_rental.config = {}

local function setting(tp, name, default)
	local full_name = "node_rental."..name
	local value
	if tp == "boolean" then
		value = minetest.setting_getbool(full_name)
	elseif tp == "string" then
		value = minetest.setting_get(full_name)
	elseif tp == "position" then
		value = minetest.setting_get_pos(full_name)
	elseif tp == "number" then
		value = tonumber(minetest.setting_get(full_name))
	else
		error("Invalid setting type!")
	end
	if value == nil then
		value = default
	end
	node_rental.config[name] = value
end

--------------
-- Settings --
--------------

setting("string", "filename", world_path.."/node_rental.dat")

