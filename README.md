# node_rental
Minetest mod that allows a player to rent out any node they have. Requires <A href=https://github.com/ChaosWormz/minetest-money>money</A> mod .

Players craft the rental office node from materials.

Players then place the node where they want to offer their items for rent.

Right clicking the rental node:

- if the owner: allows the owner to add and remove items for rent, similar to chests.

- if another player: allows to browse items for rent. 

Moving an item from the for rent area to the player's inventory and creates a rental record for the amount offered by the owner.

Moving an item from the players inventory to the rental office returns spot closes the rent for that item and makes it to be able to be rented again.

Rent is applied daily near Minetest time 00:00. Money is moved from the renter's account to the rental office owner's account.

Renter's accounts can go negative. The desired behaviour here would be to cause a repossession, but it is difficult to find the item in the world, so rent will continue to be assessed until the item is returned. The penalty for the renter is that they must make more money before buying other things. The renter also cannot rent more items with a negative balance.

Chat commands

/rent \<empty\> | \<player\> - shows the list of items currently being rented by the player and their daily rent amount.
If \<player\> is supplied and the player has the rent privilege, that player's items and rent amounts are displayed (administrative).

/rented - shows the list of items you have rented out. You need to get them all back before you can destroy your rental office.

