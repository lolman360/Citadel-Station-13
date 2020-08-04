#define MODULE_CLASS_NONE 0
#define MODULE_CLASS_LIGHT 1
#define MODULE_CLASS_MEDIUM 2
#define MODULE_CLASS_HEAVY 3
#define MODULE_CLASS_ULTRA 4s
#define MODULE_CLASS_VISION 6


/obj/item/rigcontrol
	name = "the metaphysical concept of resource integration gear"
	desc = "Hey, report this on the github, this shouldn't exist at all ever."
	icon_state = "spaceold"
	item_state = "spaceold"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	slot_flags = ITEM_SLOT_BACK
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
	//heat
	var/heat_dissipation = 10 //10 degrees of heat removed every process tick
	var/heat = 293 //starts at 20 degreees c heat
	var/maxheat = 400 //400 kelvin
	var/insulated = FALSE //insulated rigs don't car about environment temp and dont heat up/cool down in wierd atmos.
	var/heatmod = 1//heat generated modifier
	//modules.
	var/module_classes = list(
	head = MODULE_CLASS_NONE,
	chest = MODULE_CLASS_NONE,
	boots = MODULE_CLASS_NONE,
	gloves = MODULE_CLASS_NONE
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
	START_PROCESSING(SSobj, src)


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
	module_classes[head] = righelm.modclass
	module_classes[chest] = rigchest.modclass
	module_classes[boots] = rigboots.modclass
	module_classes[gloves] =

	//heatmod
	heatmod = 1 + rigchest.heatmod + rigboots.heatmod
	heat_dissipation = 10 + righelm.dissipation + rigchest.dissipation + rigboots.dissipation + riggloves.dissipation














/obj/item/rigcontrol/proc/deploy(mob/living/carbon/human/H)
	if(src.loc != H)
		to_chat(H, "You can't deploy the suit if you're not wearing it!")
	if(H.equip_to_slot_if_possible(righelm,SLOT_HEAD,0,0,1)
		to_chat(H, "The [righelm] deploys from the control module.")
	if(H.equip_to_slot_if_possible(rigchest,SLOT_OCLOTHING,0,0,1)
		to_chat(H, "The [rigchest] deploys from the control module.")
	if(H.equip_to_slot_if_possible(riggloves,SLOT_GLOVES,0,0,1)
		to_chat(H, "The [riggloves] deploys from the control module.")
	if(H.equip_to_slot_if_possible(rigboots,SLOT_FEET,0,0,1)
		to_chat(H, "The [righelm] deploys from the control module.")
