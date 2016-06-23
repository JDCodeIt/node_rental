function node_rental:player_exists(name)
	return minetest.auth_table[name] ~= nil
end

function has_items_rented_out(owner_name)
	for id, rental in pairs(node_rental.node_rental) do
		if rental and rental.owner == owner_name then
			return true
		end
	end
	return false
end

-- Save the node_rental table to a file
function node_rental:save()
	local datastr = minetest.serialize(node_rental.node_rental)
	if not datastr then
		minetest.log("error", "[node_rental] Failed to serialize node rental data!")
		return
	end
	local file, err = io.open(node_rental.config.filename, "w")
	if err then
		return err
	end
	file:write(datastr)
	file:close()
end

-- Load the node_rental table from the saved file
function node_rental:load()
	local file, err = io.open(node_rental.config.filename, "r")
	if err then
		self.node_rental = node_rental.node_rental or {}
		return err
	end
	self.node_rental = minetest.deserialize(file:read("*a"))
	if type(node_rental.node_rental) ~= "table" then
		node_rental.node_rental = {}
	end
	file:close()
end

-- Finds the first usable index in a table
-- Eg: {[1]=false,[4]=true} -> 2
local function findFirstUnusedIndex(t)
	local i = 0
	repeat i = i + 1
	until t[i] == nil
	return i
end

-- Add a node rental, returning the new area's id.
function node_rental:add(renter, owner, node_name, quantity, rental_unit_price)
	local id = findFirstUnusedIndex(self.node_rental)
	node_rental.node_rental[id] = {renter=renter, owner=owner, node_name=node_name, quantity=quantity, rental_unit_price=rental_unit_price}
	return id
end

-- Remove a node rental, and optionally it's children recursively.
function node_rental:remove(id)
	-- Remove main entry
	node_rental.node_rental[id] = nil
end

function node_rental_return_item(renter, pos, stack)
	local name = ""
	local itemname = ""
	local owner = ""
	local remainqty = 0
	local returnedqty = 0
	if renter then
		name = renter:get_player_name()
	end
	if pos then
		local meta = minetest.get_meta(pos)
		owner = meta:get_string("owner")
	end
	if stack then
		itemname = stack:get_name()
		remainqty = stack:get_count()
	end
	if remainqty > 0 then
		for id, rental in pairs(node_rental.node_rental) do
			if rental and rental.renter == name and rental.owner == owner and itemname == rental.node_name then
				if rental.quantity > remainqty then
					-- partially fill the return of rented item
					returnedqty = returnedqty + remainqty
					rental.quantity = rental.quantity - remainqty
					return returnedqty
				else
					returnedqty = returnedqty + rental.quantity
					remainqty = remainqty - rental.quantity
					node_rental:remove(id)
				end
			end
		end
	end
	if returnedqty > 0 then
		node_rental.save()
	end
	return returnedqty
end

function node_rental_rent_item(renter, pos, stack, unit_price)
	local name = ""
	local itemname = ""
	local owner = ""
	local rentedqty = 0
	if renter then
		name = renter:get_player_name()
	end
	if pos then
		local meta = minetest.get_meta(pos)
		owner = meta:get_string("owner")
	end
	if stack then
		itemname = stack:get_name()
		rentedqty = stack:get_count()
	end
	node_rental:add(name, owner, itemname, rentedqty, unit_price)
	node_rental:save()
	return rentedqty
end

function bill_renters()
	for i, rental in ipairs(node_rental.node_rental) do
		if rental then
			local payment = rental.quantity * rental.rental_unit_price
			if money.get_money(rental.renter) < payment then
				money.set_money(rental.owner, money.get_money(rental.owner) + money.get_money(rental.renter))
				money.set_money(rental.renter, 0)
				minetest.chat_send_player(rental.owner, "Renter " .. rental.renter .. " stopped paying rent!")
				minetest.chat_send_player(rental.renter, "You ran out of money! Pay " .. rental.owner .. " or they will REPO your stuff!")
			else
				money.set_money(rental.owner, money.get_money(rental.owner) + payment)
				money.set_money(rental.renter, money.get_money(rental.renter) - payment)
			end
		end
	end
end

-- Checks if the user has sufficient privileges.
function node_rental:canPlayerListRent(name)
	local privs = minetest.get_player_privs(name)
	if privs.node_rental then
		return true
	else
		return false
	end
end

-- Given a id returns a string in the format:
-- "<name> [id]: from <owner> <node_name> rent_per_day"
function node_rental:toString(id)
	local rental = node_rental.node_rental[id]
	local message = ""
	if rental then
		message = ("%s [%d]:renting %d %s from %s at %d per day"):format(
			rental.renter, id, rental.quantity, rental.node_name, rental.owner, 
			rental.rental_unit_price)
	end
	return message
end


-- Global step to watch for day change, then charge the renter
local timer = 0
local daycount = 0
-- minetest.log("action", "node_rental starts with day_count = " .. ("%d"):format(daycount))


minetest.register_globalstep(function(dtime)
	timer = timer + dtime;
	if timer >= 60 then
		-- check if a day has passed every 10 minutes
		if core.get_day_count() > daycount then
			daycount = core.get_day_count()
			-- perform billing
			bill_renters()
		end
		timer = 0
	end
end)
