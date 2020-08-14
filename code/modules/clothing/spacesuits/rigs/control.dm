#define MODULE_CLASS_NONE 0
#define MODULE_CLASS_LIGHT 1
#define MODULE_CLASS_MEDIUM 2
#define MODULE_CLASS_HEAVY 3
#define MODULE_CLASS_ULTRA 4s
#define MODULE_CLASS_VISION 6


/obj/item/rigcontrol
	name = "the metaphysical concept of resource integration gear"
	desc = "Hey, report this on the github, this shouldn't exist at all ever."
	icon = 'icons/obj/iv_drip.dmi'
	icon_state = "iv_drip"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	//pieces
	var/obj/item/clothing/head/helmet/rig/righelm
	var/obj/item/clothing/suit/rig/rigchest
	var/obj/item/clothing/shoes/magboots/rig/rigboots
	var/obj/item/clothing/gloves/rig/riggloves
	var/obj/item/clothing/glasses/rigglasses
	//cell/power
	var/obj/item/stock_parts/cell/rigcell
	var/celldrain = 0 //cell drain per tick.
	//panel
	var/panel_open = FALSE //its not open
	//online/offline stuff
	var/offline_slowdown = 6
	slowdown = 6// regular slowdown is always 0, pieces dictate slowdown
	var/active = FALSE //we start uninitialized
	//modules.
	var/module_classes = list(
	head = MODULE_CLASS_NONE,
	chest = MODULE_CLASS_NONE,
	boots = MODULE_CLASS_NONE,
	gloves = MODULE_CLASS_NONE,
	vision = MODULE_CLASS_VISION
	)

	var/module_slots = list(
	head = null,
	chest = null,
	boots = null,
	gloves = null,
	vision = null
	)

/obj/item/rigcontrol/Initialize(mapload)
	. = ..()//bruh
	START_PROCESSING(SSobj, src)
	righelm = new /obj/item/clothing/head/helmet/rig(src)
	righelm.suit = src
	rigchest = new /obj/item/clothing/suit/rig(src)
	rigchest.suit = src
	rigboots = new /obj/item/clothing/shoes/magboots/rig(src)
	rigboots.suit = src
	riggloves = new /obj/item/clothing/gloves/rig(src)
	riggloves.suit = src



/obj/item/rigcontrol/Destroy()
	STOP_PROCESSING(SSobj, src)


/obj/item/rigcontrol/proc/partcheck()
	if(!righelm)
		return FALSE
	if(!rigchest)
		return FALSE
	if(!riggloves)
		return FALSE
	if(!rigboots)
		return FALSE
	//module classes
	module_classes["head"] = righelm.modclass
	module_classes["chest"] = rigchest.modclass
	module_classes["boots"] = rigboots.modclass
	module_classes["gloves"] = riggloves.modclass

/obj/item/rigcontrol/AltClick(mob/user)
	if(ishuman(user) && loc == user)
		var/mob/living/carbon/human/H = user
		deploy(H)
	else
		..()








/obj/item/rigcontrol/proc/deploy(mob/living/carbon/human/H)
	if(!righelm)
		return FALSE
	if(!rigchest)
		return FALSE
	if(!riggloves)
		return FALSE
	if(!rigboots)
		return FALSE
	if(src.loc != H)
		to_chat(H, "You can't deploy the suit if you're not wearing it!")
	if(H.equip_to_slot_if_possible(righelm,SLOT_HEAD,0,0,1))
		to_chat(H, "The [righelm] deploys from the control module.")
	if(H.equip_to_slot_if_possible(rigchest,SLOT_WEAR_SUIT,0,0,1))
		to_chat(H, "The [rigchest] deploys from the control module.")
	if(H.equip_to_slot_if_possible(riggloves,SLOT_GLOVES,0,0,1))
		to_chat(H, "The [riggloves] deploys from the control module.")
	if(H.equip_to_slot_if_possible(rigboots,SLOT_SHOES,0,0,1))
		to_chat(H, "The [righelm] deploys from the control module.")

/obj/item/clothing/head/helmet/rig
	name = "righelm"
	var/modclass = 1
	var/obj/item/rigcontrol/suit = null

/obj/item/clothing/head/helmet/rig/dropped(mob/user)
	..()
	if(suit && !ismob(loc)) //equipped() will handle mob cases, so it doesn't disengage twice.
		forceMove(suit)

/obj/item/clothing/head/helmet/rig/equipped(mob/user, slot)
	..()
	if(slot != SLOT_HEAD)
		if(suit)
			forceMove(suit)
		else
			qdel(src)

/obj/item/clothing/suit/rig
	name = "rigchest"
	var/modclass = 1
	var/obj/item/rigcontrol/suit = null

/obj/item/clothing/suit/rig/dropped(mob/user)
	..()
	if(suit && !ismob(loc)) //equipped() will handle mob cases, so it doesn't disengage twice.
		forceMove(suit)

/obj/item/clothing/suit/rig/equipped(mob/user, slot)
	..()
	if(slot != SLOT_WEAR_SUIT)
		if(suit)
			forceMove(suit)
		else
			qdel(src)

/obj/item/clothing/shoes/magboots/rig
	name = "rigboots"
	var/modclass = 1
	var/obj/item/rigcontrol/suit = null

/obj/item/clothing/shoes/magboots/rig/dropped(mob/user)
	..()
	if(suit && !ismob(loc)) //equipped() will handle mob cases, so it doesn't disengage twice.
		forceMove(suit)

/obj/item/clothing/shoes/magboots/rig/equipped(mob/user, slot)
	..()
	if(slot != SLOT_SHOES)
		if(suit)
			forceMove(suit)
		else
			qdel(src)

/obj/item/clothing/gloves/rig
	name = "riggloves"
	var/modclass = 1
	var/obj/item/rigcontrol/suit = null

/obj/item/clothing/gloves/rig/dropped(mob/user)
	..()
	if(suit && !ismob(loc)) //equipped() will handle mob cases, so it doesn't disengage twice.
		forceMove(suit)

/obj/item/clothing/suit/gloves/rig/equipped(mob/user, slot)
	..()
	if(slot != SLOT_GLOVES)
		if(suit)
			forceMove(suit)
		else
			qdel(src)
