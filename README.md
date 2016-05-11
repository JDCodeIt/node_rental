# node_rental
Minetest mod that allows a player to rent out any node they have. Requires money mod.

Players craft the rental office node from materials.

Players then place the node where they want to offer their items for rent.

Right clicking the rental node:

- if the owner: allows the owner to add and remove items for rent, similar to chests.

- if another player: allows to browse items for rent. 

Moving an item from the for rent area to the player's inventory updates the total daily rent amount.

Moving an item from the players inventory to the rental office inventory cancels the player's rent for that item

Rent is applied daily at Minetest time 00:00. Money is moved from the renter's account to the rental office owner's account.

If an account goes negative, the item is repossesed (Repo!) and placed into the repo inventory. These items can be viewed by the owner at any of their rental offices and moved back to availble to rent, or into their own inventory. 

Any items held in the rented item will be lost.

Chat commands

/rent \<empty\> | \<player\> - shows the list of items currently being rented by the player and their daily rent amount.
If \<player\> is supplied and the player has the rent privilege, that player's items and rent amounts are displayed (administrative).

