This repository contains some scripts I have created to help automate various tasks in minecraft.  I am a huge fan of modded minecraft and how far its come.  Computercraft remains one of my favorite mods, as it adds 'turtles' which are essentially Lua controlled robots.

## Pastebin
Here is a link to the [Pastebin](https://pastebin.com/u/Webb24) so that you can download any script within the computercraft terminal.

    pastebin get <pastebin_id> <script_name>

## Computercraft scripts

 -  **clear.lua**
	 - Usage: `clear <amount_forward> <amount_left> <amount_up>`
	 - Attempts to clear the blocks within the area given by the user.  If it is clearing on its starting Y level, it will place the block in its second slot below it, creating a ground in uneven terrain
 - **lavacast.lua**
	 - Usage: `lavacast <type>`
	- Lavacasting refers to a technique that uses water and lava to create structures out of the cobble they create.  This lavacasting script uses a single lava and water bucket to lavacast different designs:
		- `lavacast tower <height>`
			- Creates a cobblestone tower `<height>` blocks tall
		-  `lavacast pyramid <height>`
			- Creates a pyramid structure `<height>` blocks tall
			- Note `<height>` is not a 1-1 with y-height
		- `lavacast wall <height> <length>`
			- Under construction
-  **mobfarm.lua**
	 - Usage: `mobfarm`
	 - Once this script starts, it will endlessly attack in front of itself and once full of items will turn around and empty itself into an inventory. 
	 - If mobs are routed via any means such that they are forced in front of the turtle, this script can be used to grind mobs with **player damage**, meaning you also get exp.
	 - This script is one you want to consider adding to startup, such that the farm will start back up after its chunk has been unloaded