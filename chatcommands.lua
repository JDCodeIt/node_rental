minetest.register_chatcommand("rent", {
	description = "/rent | <player> List what your are renting from someone else, or a player's rentals if you are an admin.",
	func = function(name, param)
		local admin = minetest.check_player_privs(name, node_rental.adminPrivs)
		local rentalStrings = {}
		for id, rental in pairs(node_rental.node_rental) do
			if admin and rental and param == rental.renter then
				table.insert(rentalStrings, node_rental:toString(id))
			elseif rental and rental.renter == name then
				table.insert(rentalStrings, node_rental:toString(id))
			end
		end
		if #rentalStrings == 0 then
			return true, "No items are renting."
		end
		return true, table.concat(rentalStrings, "\n")
	end
})

minetest.register_chatcommand("rented", {
	description = "/rented List to whom you are renting items, or a player's rentals if you are an admin.",
	func = function(name, param)
		local admin = minetest.check_player_privs(name, node_rental.adminPrivs)
		local rentalStrings = {}
		for id, rental in pairs(node_rental.node_rental) do
			if admin and rental and (param == rental.owner or #param == 0) then 
				table.insert(rentalStrings, node_rental:toString(id))
			elseif rental and rental.owner == name then
				table.insert(rentalStrings, node_rental:toString(id))
			end
		end
		if #rentalStrings == 0 then
			return true, "No items are renting."
		end
		return true, table.concat(rentalStrings, "\n")
	end
})

minetest.register_chatcommand("rent_delete", {
        description = "/rent_delete <ID> Administrative delete of remtal ID - usually after reposession.",
        func = function(name, param)
                local admin = minetest.check_player_privs(name, node_rental.adminPrivs)
		if admin then
			node_rental.save()
			node_rental:remove(tonumber(param))
		else
			return true, "You do not have the privilege to delete rentals."
		end
	end
})

