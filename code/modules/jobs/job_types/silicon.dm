/*
AI
*/
/datum/job/ai
	title = "AI"
	flag = AI
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 0
	spawn_positions = 1
	selection_color = "#ccffcc"
	supervisors = "����� �������"
	req_admin_notify = 1
	minimal_player_age = 30

/datum/job/ai/equip(mob/living/carbon/human/H)
	return H.AIize(FALSE)

/datum/job/ai/after_spawn(mob/living/silicon/ai/AI, mob/M)
	AI.rename_self("ai", M.client)

	//we may have been created after our borg
	if(SSticker.current_state == GAME_STATE_SETTING_UP)
		for(var/mob/living/silicon/robot/R in silicon_mobs)
			if(!R.connected_ai)
				R.TryConnectToAI()


/datum/job/ai/config_check()
	if(config && config.allow_ai)
		return 1
	return 0

/*
Cyborg
*/
/datum/job/cyborg
	title = "Cyborg"
	flag = CYBORG
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 0
	spawn_positions = 1
	supervisors = "����� ������� � ������ ��"	//Nodrak
	selection_color = "#ddffdd"
	minimal_player_age = 21

/datum/job/cyborg/equip(mob/living/carbon/human/H)
	return H.Robotize(FALSE, FALSE)

/datum/job/cyborg/after_spawn(mob/living/silicon/robot/R, mob/M)
	if(config.rename_cyborg)	//name can't be set in robot/New without the client
		R.rename_self("cyborg", M.client)