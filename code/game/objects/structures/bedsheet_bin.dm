/*
CONTAINS:
BEDSHEETS
LINEN BINS
*/

/obj/item/weapon/bedsheet
	name = "bedsheet"
	desc = "A surprisingly soft linen bedsheet."
	icon = 'icons/obj/bed.dmi'
	icon_state = "sheet"
	item_state = "bedsheet"
	slot_flags = SLOT_BACK
	layer = 4.0
	throwforce = 1
	throw_speed = 1
	throw_range = 2
	w_class = ITEM_SIZE_SMALL

/obj/item/weapon/bedsheet/attack_self(mob/user as mob)
	user.drop_from_inventory(src)
	if(layer == initial(layer))
		layer = 5
		pixel_x = 0
		pixel_y = 0
	else
		layer = initial(layer)
	add_fingerprint(user)
	return


/obj/item/weapon/bedsheet/blue
	icon_state = "sheetblue"

/obj/item/weapon/bedsheet/green
	icon_state = "sheetgreen"

/obj/item/weapon/bedsheet/orange
	icon_state = "sheetorange"

/obj/item/weapon/bedsheet/purple
	icon_state = "sheetpurple"

/obj/item/weapon/bedsheet/rainbow
	icon_state = "sheetrainbow"

/obj/item/weapon/bedsheet/red
	icon_state = "sheetred"

/obj/item/weapon/bedsheet/yellow
	icon_state = "sheetyellow"

/obj/item/weapon/bedsheet/mime
	icon_state = "sheetmime"

/obj/item/weapon/bedsheet/clown
	icon_state = "sheetclown"

/obj/item/weapon/bedsheet/captain
	icon_state = "sheetcaptain"

/obj/item/weapon/bedsheet/rd
	icon_state = "sheetrd"

/obj/item/weapon/bedsheet/medical
	icon_state = "sheetmedical"

/obj/item/weapon/bedsheet/hos
	icon_state = "sheethos"

/obj/item/weapon/bedsheet/hop
	icon_state = "sheethop"

/obj/item/weapon/bedsheet/ce
	icon_state = "sheetce"

/obj/item/weapon/bedsheet/brown
	icon_state = "sheetbrown"


/obj/structure/bedsheetbin
	name = "linen bin"
	desc = "A linen bin. It looks rather cosy."
	icon = 'icons/obj/structures.dmi'
	icon_state = "linenbin-full"
	anchored = 1
	var/amount = 20
	var/list/sheets = list()
	var/obj/item/hidden = null


/obj/structure/bedsheetbin/examine(mob/user)
	. = ..()

	if(amount < 1)
		user << "There are no bed sheets in the bin."
		return
	if(amount == 1)
		user << "There is one bed sheet in the bin."
		return
	user << "There are [amount] bed sheets in the bin."


/obj/structure/bedsheetbin/update_icon()
	switch(amount)
		if(0)				icon_state = "linenbin-empty"
		if(1 to amount / 2)	icon_state = "linenbin-half"
		else				icon_state = "linenbin-full"


/obj/structure/bedsheetbin/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/bedsheet))
		user.drop_from_inventory(I, src)
		sheets.Add(I)
		amount++
		user << SPAN_NOTE("You put [I] in [src].")
	//make sure there's sheets to hide it among, make sure nothing else is hidden in there.
	else if(amount && !hidden && I.w_class < ITEM_SIZE_HUGE && user.unEquip(I, src))
		hidden = I
		user << SPAN_NOTE("You hide [I] among the sheets.")

/obj/structure/bedsheetbin/attack_hand(mob/user as mob)
	if(amount >= 1)
		amount--

		var/obj/item/weapon/bedsheet/B
		if(sheets.len > 0)
			B = sheets[sheets.len]
			sheets.Remove(B)

		else
			B = new /obj/item/weapon/bedsheet(loc)

		user.put_in_hands(B)
		user << SPAN_NOTE("You take [B] out of [src].")

		if(hidden)
			hidden.loc = user.loc
			user << SPAN_NOTE("[hidden] falls out of [B]!")
			hidden = null


	add_fingerprint(user)

/obj/structure/bedsheetbin/attack_tk(mob/user as mob)
	if(amount >= 1)
		amount--

		var/obj/item/weapon/bedsheet/B
		if(sheets.len > 0)
			B = sheets[sheets.len]
			sheets.Remove(B)

		else
			B = new /obj/item/weapon/bedsheet(loc)

		B.loc = loc
		user << SPAN_NOTE("You telekinetically remove [B] from [src].")
		update_icon()

		if(hidden)
			hidden.loc = loc
			hidden = null


	add_fingerprint(user)
