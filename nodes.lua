-- Node Rental Node Functions

local function is_rental_office_owner(pos, player)
	local name = ""
	local meta = minetest.get_meta(pos)
	if player then
		name = player:get_player_name()
	end
	if name ~= meta:get_string("owner") then
		return false
	end
	return true
end

local nr_formspec = function(pos, player)
	local meta = minetest.env:get_meta(pos)
	local formspec

	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local meta = minetest.env:get_meta(pos)
	if is_rental_office_owner(pos, player) then
		formspec = 
			"size[8,10]" ..
			default.gui_bg ..
			default.gui_bg_img ..
			default.gui_slots ..
			"field[0,0;0,0;spos;;" .. minetest.pos_to_string(pos) .. "]" ..
			"label[0,0;Owner: move items, set rates $/day/each]" ..
			"field[1.2,0.8;1,1;rent1;;".. tostring(meta:get_int("rent1")) .. "]" ..
			"field[1.2,1.8;1,1;rent2;;".. tostring(meta:get_int("rent2")) .. "]" ..
			"field[1.2,2.8;1,1;rent3;;".. tostring(meta:get_int("rent3")) .. "]" ..
			"field[1.2,3.8;1,1;rent4;;".. tostring(meta:get_int("rent4")) .. "]" ..
			"field[3.2,0.8;1,1;rent5;;".. tostring(meta:get_int("rent5")) .. "]" ..
			"field[3.2,1.8;1,1;rent6;;".. tostring(meta:get_int("rent6")) .. "]" ..
			"field[3.2,2.8;1,1;rent7;;".. tostring(meta:get_int("rent7")) .. "]" ..
			"field[3.2,3.8;1,1;rent8;;".. tostring(meta:get_int("rent8")) .. "]" ..
			"field[5.2,0.8;1,1;rent9;;".. tostring(meta:get_int("rent9")) .. "]" ..
			"field[5.2,1.8;1,1;rent10;;".. tostring(meta:get_int("rent10")) .. "]" ..
			"field[5.2,2.8;1,1;rent11;;".. tostring(meta:get_int("rent11")) .. "]" ..
			"field[5.2,3.8;1,1;rent12;;".. tostring(meta:get_int("rent12")) .. "]" ..
			"field[7.2,0.8;1,1;rent13;;".. tostring(meta:get_int("rent13")) .. "]" ..
			"field[7.2,1.8;1,1;rent14;;".. tostring(meta:get_int("rent14")) .. "]" ..
			"field[7.2,2.8;1,1;rent15;;".. tostring(meta:get_int("rent15")) .. "]" ..
			"field[7.2,3.8;1,1;rent16;;".. tostring(meta:get_int("rent16")) .. "]" ..
			"list[nodemeta:".. spos .. ";main;0,0.5;1,4;0]" ..
			"list[nodemeta:".. spos .. ";main;2,0.5;1,4;4]" ..
			"list[nodemeta:".. spos .. ";main;4,0.5;1,4;8]" ..
			"list[nodemeta:".. spos .. ";main;6,0.5;1,4;12]" ..
			"list[current_player;main;0,4.85;8,1;]" ..
			"list[current_player;main;0,6.08;8,3;8]" ..
			"listring[current_name;main]" ..
			"listring[current_player;main]" ..
			"button_exit[3,9;2,1;exit;OK]" ..
			default.get_hotbar_bg(0,4.85)
	else
		formspec = 
			"size[8,10]" ..
			default.gui_bg ..
			default.gui_bg_img ..
			default.gui_slots ..
			"field[0,0;0,0;spos;;" .. minetest.pos_to_string(pos) .. "]" ..
			"label[0,0;Take items to rent ($/day/each), return them here-->]" ..
			"label[1.2,1.3;".. tostring(meta:get_int("rent1")) .. "]" ..
			"label[1.2,2.3;".. tostring(meta:get_int("rent2")) .. "]" ..
			"label[1.2,3.3;".. tostring(meta:get_int("rent3")) .. "]" ..
			"label[1.2,4.3;".. tostring(meta:get_int("rent4")) .. "]" ..
			"label[3.2,1.3;".. tostring(meta:get_int("rent5")) .. "]" ..
			"label[3.2,2.3;".. tostring(meta:get_int("rent6")) .. "]" ..
			"label[3.2,3.3;".. tostring(meta:get_int("rent7")) .. "]" ..
			"label[3.2,4.3;".. tostring(meta:get_int("rent8")) .. "]" ..
			"label[5.2,1.3;".. tostring(meta:get_int("rent9")) .. "]" ..
			"label[5.2,2.3;".. tostring(meta:get_int("rent10")) .. "]" ..
			"label[5.2,3.3;".. tostring(meta:get_int("rent11")) .. "]" ..
			"label[5.2,4.3;".. tostring(meta:get_int("rent12")) .. "]" ..
			"label[7.2,1.3;".. tostring(meta:get_int("rent13")) .. "]" ..
			"label[7.2,2.3;".. tostring(meta:get_int("rent14")) .. "]" ..
			"label[7.2,3.3;".. tostring(meta:get_int("rent15")) .. "]" ..
			"label[7.2,4.3;".. tostring(meta:get_int("rent16")) .. "]" ..
			"list[nodemeta:".. spos .. ";returns;7.2,0;1,1;0]" ..
			"list[nodemeta:".. spos .. ";main;0,1;1,4;0]" ..
			"list[nodemeta:".. spos .. ";main;2,1;1,4;4]" ..
			"list[nodemeta:".. spos .. ";main;4,1;1,4;8]" ..
			"list[nodemeta:".. spos .. ";main;6,1;1,4;12]" ..
			"list[current_player;main;0,5.35;8,1;]" ..
			"list[current_player;main;0,6.58;8,3;8]" ..
			"listring[current_name;main]" ..
			"listring[current_player;main]" ..
			"button_exit[3,9.5;2,1;exit;Close]" ..
			default.get_hotbar_bg(0,45.35)
	end
	return formspec
end

minetest.register_node("node_rental:rental_office", {
	description = "Rental Office",
	tiles = {"node_rental_top.png", "node_rental_top.png", "node_rental_side.png",
		"node_rental_side.png", "node_rental_side.png", "node_rental_front.png"},
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),

	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		-- meta:set_string("formspec", nr_formspec(pos, placer))
		meta:set_string("infotext", "Node Rental Office (owned by " ..
				meta:get_string("owner") .. ")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Node Rental Office")
		for i = 1,16 do
			meta:set_int("rent" .. tostring(i), 1)
		end
		local inv = meta:get_inventory()
		inv:set_size("main", 4*4)
		inv:set_size("rentals", 4*4) -- reference to rented item when someone takes the last one from main
		inv:set_size("returns", 1)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		local owner = meta:get_string("owner")
		local player_name = player:get_player_name()
		if player_name ~= owner then
			minetest.chat_send_player(player_name, "Only the owner can remove the Rental Office")
			return false
		end
		if has_items_rented_out(owner) then
			minetest.chat_send_player(player_name, "You still have items rented out. Use command /rented to see list.")
			return false
		end
		return inv:is_empty("main")
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		if not is_rental_office_owner(pos, player) then
			return 0
		end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if not is_rental_office_owner(pos, player) then
			if listname ~= "returns" then
				minetest.chat_send_player(player:get_player_name(), "You can only place items in the returns location.")
				return 0
			else
				return node_rental_return_item(player, pos, stack)
			end
		end
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if not is_rental_office_owner(pos, player) then
			local player_name = player:get_player_name()
			-- no more renting with nevative account balance
			if money.get_money(player_name) < 0 then
				minetest.chat_send_player(player:get_player_name(), "You have no money. Earn some more before renting anything.")
				return 0
			else
				local meta = minetest.get_meta(pos);
				return node_rental_rent_item(player, pos, stack, tonumber(meta:get_int("rent" .. tostring(index))))
			end
		end
		return stack:get_count()
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		inv:set_list("rentals", inv:get_list("main"))
		minetest.log("action", player:get_player_name() .. " moves rental items at " 
			.. minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if is_rental_office_owner(pos, player) then
			inv:set_list("rentals", inv:get_list("main"))
		else
			for i = 1,16 do
				if inv:get_stack("rentals", i):get_name() == stack:get_name() then
					if inv:get_stack("main", i):is_empty() then 
						inv:set_stack("main", i, stack)
					else
						inv:add_item("main", stack)
					end
					inv:remove_item("returns",stack)
					break
				end
			end
		end
		minetest.log("action", player:get_player_name() .. " moves " .. tostring(stack:get_count()) .. " " .. stack:get_name()
			.. " to rental office at " .. minetest.pos_to_string(pos))
	end,
 	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() .. " takes " .. tostring(stack:get_count()) .. " " .. stack:get_name() 
			.. " from rental office at " .. minetest.pos_to_string(pos))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "main", drops)
		drops[#drops+1] = "node_rental:rental_office"
		minetest.remove_node(pos)
		return drops
	end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		if not is_rental_office_owner(pos, player) then
			if money.get_money(player:get_player_name()) < 5000 then
				minetest.chat_send_player(player:get_player_name(), "You must have at least 5000 money before renting anything.")
				return
			end
		end
		minetest.show_formspec(
			player:get_player_name(),
			"node_rental:rental",
			nr_formspec(pos,player))
	end,
})

minetest.register_on_player_receive_fields(function(sender, formname, fields)
	if formname == "node_rental:rental" then
		if fields.rent1 ~= nil then
			local pos = minetest.string_to_pos(fields.spos)
			local meta = minetest.env:get_meta(pos)
			local owner = meta:get_string("owner")
			if sender:get_player_name() ~= owner then
				return
			end
			-- owners can change the prices
			for i = 1,16 do
				meta:set_int("rent" .. tostring(i), rawget(fields, "rent" .. tostring(i)))
			end
		end
	end
	return false
end)
