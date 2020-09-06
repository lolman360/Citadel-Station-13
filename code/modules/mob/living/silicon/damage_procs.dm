
/mob/living/silicon/apply_damage(damage = 0,damagetype = BRUTE, def_zone = null, blocked = FALSE, forced = FALSE, wound_bonus = 0, bare_wound_bonus = 0, sharpness = SHARP_NONE)
	var/hit_percent = (100-blocked)/100
	if(!damage || (!forced && hit_percent <= 0))
		return 0
	var/damage_amount = forced ? damage : damage * hit_percent

	if(istype(src, /mob/living/silicon/robot) && !forced)
		var/mob/living/silicon/robot/R = src
		if(R.shielded)
			R.cell.charge -= min(R.shielded * 62.5, R.cell.charge)
			if(R.cell.charge == 0)
				to_chat(src, "<span class='notice'>Your shield has overloaded!</span>")
			else
				var/true_damage = damage
				damage -= R.shielded
				if(damage <= 0)
					to_chat(R,"<span class='notice'>Your shield has taken an impact of [true_damage] force, and has negated all of its force!</span>")
					return FALSE
				to_chat(R,"<span class='notice'>Your shield has taken an impact of [true_damage] force, and has blocked [R.shielded] damage, resulting in [damage] force being applied.</span>")


	switch(damagetype)
		if(BRUTE)
			adjustBruteLoss(damage_amount, forced = forced)
		if(BURN)
			adjustFireLoss(damage_amount, forced = forced)
		if(OXY)
			if(damage < 0 || forced) //we shouldn't be taking oxygen damage through this proc, but we'll let it heal.
				adjustOxyLoss(damage_amount, forced = forced)
	return 1


/mob/living/silicon/apply_effect(effect = 0,effecttype = EFFECT_STUN, blocked = FALSE)
	return FALSE //The only effect that can hit them atm is flashes and they still directly edit so this works for now

/mob/living/silicon/adjustToxLoss(amount, updating_health = TRUE, forced = FALSE) //immune to tox damage
	return FALSE

/mob/living/silicon/setToxLoss(amount, updating_health = TRUE, forced = FALSE)
	return FALSE

/mob/living/silicon/adjustCloneLoss(amount, updating_health = TRUE, forced = FALSE) //immune to clone damage
	return FALSE

/mob/living/silicon/setCloneLoss(amount, updating_health = TRUE, forced = FALSE)
	return FALSE

/mob/living/silicon/adjustStaminaLoss(amount, updating_health = 1, forced = FALSE)//immune to stamina damage.
	return FALSE

/mob/living/silicon/setStaminaLoss(amount, updating_health = 1)
	return FALSE

/mob/living/silicon/adjustOrganLoss(slot, amount, maximum = 500)
	return FALSE

/mob/living/silicon/setOrganLoss(slot, amount)
	return FALSE
