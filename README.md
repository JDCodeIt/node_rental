# node_rental
Minetest mod that allows a player to rent out any node they have. Requires <A href=https://github.com/ChaosWormz/minetest-money>money</A> mod .

Players craft the Rental Office node from materials.

Players then place the node where they want to offer their items for rent. The Rental Office is protected so only the owner can remove it.

Right clicking the rental node:

- if the owner: allows the owner to add and remove items, and change prices of items for rent.

- if another player: allows to browse items for rent, take items to be rented, or return items that are rented. 

Moving an item from the for rent area to the player's inventory creates a rental record for the amount offered by the owner. The player's money level must be at least 5 times the daily rental fee - like a credit check.

Moving an item from the players inventory to the rental office inventory cancels the player's rent for that item.

Rent is applied daily near Minetest time 00:00. Money is moved from the renter's account to the rental office owner's account.

Renter's accounts cannot go negative, and when their money has gone to zero, the owner stops receiving rent. The desired behaviour here would be to cause a repossession, but it is difficult to find the item in the world. The penalty for the renter is that they must make more money before buying other things in the world.

A message will appear on the owner's chat and renter's chat if rent is not being paid. They can choose to take appropriate action, perhaps involving the system admin.

Chat commands

/rent \<empty\> | \<player\> - shows the list of items currently being rented by the player and their daily rent amount.
If \<player\> is supplied and the player has the rent privilege, that player's items and rent amounts are displayed (administrative).

