/mob/living/carbon/human/emote(var/act,var/m_type=1,var/message = null)
	var/param = null

	if (findtext(act, "-", 1, null))
		var/t1 = findtext(act, "-", 1, null)
		param = copytext(act, t1 + 1, length(act) + 1)
		act = copytext(act, 1, t1)

	if(findtext(act,"s",-1) && !findtext(act,"_",-2))//Removes ending s's unless they are prefixed with a '_'
		act = copytext(act,1,length(act))

	var/muzzled = is_muzzled()
	//var/m_type = 1

	for (var/obj/item/weapon/implant/I in src)
		if (I.implanted)
			I.trigger(act, src)

	var/miming=0
	if(mind)
		miming=mind.miming

	if(src.stat == 2.0 && (act != "deathgasp"))
		return
	switch(act) //Please keep this alphabetically ordered when adding or changing emotes.
		if ("aflap") //Any emote on human that uses miming must be left in, oh well.
			if (!src.restrained())
				message = "<B>[src]</B> ���������� ������� ��������!"
				m_type = 2

		if ("choke")
			if (miming)
				message = "<B>[src]</B> �������� ��������� �� ����� � �������!"
			else
				..(act)

		if ("chuckle")
			if(miming)
				message = "<B>[src]</B> ������ ���, ��� ��������."
			else
				..(act)

		if ("clap")
			if (!src.restrained())
				message = "<B>[src]</B> �������."
				m_type = 2

		if ("collapse")
			Paralyse(2)
			message = "<B>[src]</B> ������!"
			m_type = 2

		if ("cough")
			if (miming)
				message = "<B>[src]</B> ������ ���, ��� �������!"
			else
				if (!muzzled)
					message = "<B>[src]</B> �������!"
					m_type = 2
				else
					message = "<B>[src]</B> ����� ������� ����."
					m_type = 2

		if ("cry")
			if (miming)
				message = "<B>[src]</B> ������."
			else
				if (!muzzled)
					message = "<B>[src]</B> ������."
					m_type = 2
				else
					message = "<B>[src]</B> ����� ������ ����. ��������."
					m_type = 2

		if ("custom")
			var/input = copytext(sanitize(input("Choose an emote to display.") as text|null),1,MAX_MESSAGE_LEN)
			if (!input)
				return
			if(copytext(input,1,5) == "says")
				src << "<span class='danger'>Invalid emote.</span>"
				return
			else if(copytext(input,1,9) == "exclaims")
				src << "<span class='danger'>Invalid emote.</span>"
				return
			else if(copytext(input,1,5) == "asks")
				src << "<span class='danger'>Invalid emote.</span>"
				return
			else
				var/input2 = input("Is this a visible or hearable emote?") in list("Visible","Hearable")
				if (input2 == "Visible")
					m_type = 1
				else if (input2 == "Hearable")
					if(miming)
						return
					m_type = 2
				else
					alert("Unable to use this emote, must be either hearable or visible.")
					return
				message = "<B>[src]</B> [input]"

		if ("dap")
			m_type = 1
			if (!src.restrained())
				var/M = null
				if (param)
					for (var/mob/A in view(1, src))
						if (param == A.name)
							M = A
							break
				if (M)
					message = "<B>[src]</B> ��� �������������� ����� [M]."
				else
					message = "<B>[src]</B> � ���������, ���������� ��� ������, ����� ���������������� ���� ����� �������� �������, ��������������� ��� ����. ���������."

		if ("eyebrow")
			message = "<B>[src]</B> ��������� �����."
			m_type = 1

		if ("flap")
			if (!src.restrained())
				message = "<B>[src]</B> ������� ��������."
				m_type = 2

		if ("gasp")
			if (miming)
				message = "<B>[src]</B> ��������, ��� ���-�� ����������!"
			else
				..(act)

		if ("giggle")
			if (miming)
				message = "<B>[src]</B> ��������� ��������!"
			else
				..(act)

		if ("groan")
			if (miming)
				message = "<B>[src]</B> ������ ���, ��� ������!"
			else
				if (!muzzled)
					message = "<B>[src]</B> ������!"
					m_type = 2
				else
					message = "<B>[src]</B> ����� ������� ���."
					m_type = 2

		if ("grumble")
			if (!muzzled)
				message = "<B>[src]</B> ������!"
			else
				message = "<B>[src]</B> ����� ����."
				m_type = 2

		if ("handshake")
			m_type = 1
			if (!src.restrained() && !src.r_hand)
				var/mob/M = null
				if (param)
					for (var/mob/A in view(1, src))
						if (param == A.name)
							M = A
							break
				if (M == src)
					M = null
				if (M)
					if (M.canmove && !M.r_hand && !M.restrained())
						message = "<B>[src]</B> �������� ���� [M]."
					else
						message = "<B>[src]</B> ����������� ���� ��� ����������� [M]."

		if ("hug")
			m_type = 1
			if (!src.restrained())
				var/M = null
				if (param)
					for (var/mob/A in view(1, src))
						if (param == A.name)
							M = A
							break
				if (M == src)
					M = null
				if (M)
					message = "<B>[src]</B> �������� [M]."
				else
					message = "<B>[src]</B> �������� ��� ����."

		if ("johnny")
			var/M
			if (param)
				M = param
			if (!M)
				param = null
			else
				if(miming)
					message = "<B>[src]</B> ������������ ��������� � �������� �� \"[M]\" ���� ���."
				else
					message = "<B>[src]</B> says, \"[M], ����������. � ���� �����.\" [src.name] ������������ ��������� � �������� ��� � ����� ��� �����."
					m_type = 2

		if ("me")
			if(silent)
				return
			if (src.client)
				if (client.prefs.muted & MUTE_IC)
					src << "<span class='danger'>�� �� ������ ���������� IC ���������. (muted).</span>"
					return
				if (src.client.handle_spam_prevention(message,MUTE_IC))
					return
			if (stat)
				return
			if(!(message))
				return
			if(copytext(message,1,5) == "says")
				src << "<span class='danger'>Invalid emote.</span>"
				return
			else if(copytext(message,1,9) == "exclaims")
				src << "<span class='danger'>Invalid emote.</span>"
				return
			else if(copytext(message,1,5) == "asks")
				src << "<span class='danger'>Invalid emote.</span>"
				return
			else
				message = "<B>[src]</B> [message]"

		if ("moan")
			if(miming)
				message = "<B>[src]</B> ��������, ��� ���-�� ������!"
			else
				message = "<B>[src]</B> ������!"
				m_type = 2

		if ("mumble")
			message = "<B>[src]</B> ��������!"
			m_type = 2

		if ("pale")
			message = "<B>[src]</B> �� ������� ���������."
			m_type = 1

		if ("raise")
			if (!src.restrained())
				message = "<B>[src]</B> ��������� ����."
			m_type = 1

		if ("salute")
			if (!src.buckled)
				var/M = null
				if (param)
					for (var/mob/A in view(1, src))
						if (param == A.name)
							M = A
							break
				if (!M)
					param = null
				if (param)
					message = "<B>[src]</B> ������������ ������ [param]."
				else
					message = "<B>[src]</b> ������������ ������."
			m_type = 1

		if ("scream")
			if (miming)
				message = "<B>[src]</B> ������ ���, ��� �������������� ������!"
			else
				..(act)

		if ("shit")
			if(need_to_shit < 70)
				src << "����� �����������"
				return

			if((need_to_shit > 70) && (need_to_shit < need_to_shit_max))
				for(var/obj/structure/toilet/T in view(0, src))
					if(T.shit || T.w_items)
						src << "� ��� ��������..."
						Shit(src)
						return
					else
						need_to_shit = 0
						need_to_shit_again = 140
						T.open = 1
						T.shit++
						T.update_icon()
						src << "�� �������� �����, �� �������� ����� �� �����, ������� �� �������"
						return
				src << "����� ����� ��������� ������"
				return

			message = "<B>[src]</B> [pick("������������.", "������ ���� �����.", "������� ����.", "������� �� ���.", "��������� ������ �� ���.")]"
			Shit(src)
			m_type = 1

		if ("shiver")
			message = "<B>[src]</B> ������."
			m_type = 1

		if ("shrug")
			message = "<B>[src]</B> �������� �������."
			m_type = 1

		if ("sigh")
			if(miming)
				message = "<B>[src]</B> ��������."
			else
				..(act)

		if ("signal")
			if (!src.restrained())
				var/t1 = round(text2num(param))
				if (isnum(t1))
					if (t1 <= 5 && (!src.r_hand || !src.l_hand))
						message = "<B>[src]</B> ��������� [t1] �������."
					else if (t1 <= 10 && (!src.r_hand && !src.l_hand))
						message = "<B>[src]</B> ��������� [t1] �������."
			m_type = 1

		if ("sneeze")
			if (miming)
				message = "<B>[src]</B> ������."
			else
				..(act)

		if ("sniff")
			message = "<B>[src]</B> ������."
			m_type = 2

		if ("snore")
			if (miming)
				message = "<B>[src]</B> ������ ����."
			else
				..(act)

		if ("vomit")
			message = "<B>[src]</B> ����� �� ���!"
			var/mob/living/M = src
			M.nutrition -= 20
			M.adjustToxLoss(-3)
			var/turf/T = get_turf(M)
			T.add_vomit_floor(M)
			playsound(M, 'sound/effects/splat.ogg', 50, 1)
			Stun(10)
			m_type = 1

		if ("whimper")
			if (miming)
				message = "<B>[src]</B> �������� ���������."
			else
				..(act)

		if ("yawn")
			if (!muzzled)
				message = "<B>[src]</B> ������."
				m_type = 2

		if ("help") //This can stay at the bottom.
			src << "Help for human emotes. You can use these emotes with say \"*emote\":\n\naflap, airguitar, blink, blink_r, blush, bow-(none)/mob, burp, choke, chuckle, clap, collapse, cough, cry, custom, dance, dap, deathgasp, drool, eyebrow, faint, flap, frown, gasp, giggle, glare-(none)/mob, grin, groan, grumble, handshake, hug-(none)/mob, johnny, jump, laugh, look-(none)/mob, me, moan, mumble, nod, pale, point-(atom), raise, salute, scream, shake, shiver, shrug, sigh, signal-#1-10, sit, smile, sneeze, sniff, snore, stare-(none)/mob, sulk, sway, tremble, twitch, twitch_s, wave, whimper, wink, yawn"

		else
			..(act)

	if(miming)
		m_type = 1



	if (message)
		log_emote("[name]/[key] : [message]")

 //Hearing gasp and such every five seconds is not good emotes were not global for a reason.
 // Maybe some people are okay with that.

		for(var/mob/M in dead_mob_list)
			if(!M.client || istype(M, /mob/new_player))
				continue //skip monkeys, leavers and new players
			if(M.stat == DEAD && (M.client.prefs.toggles & CHAT_GHOSTSIGHT) && !(M in viewers(src,null)))
				M.show_message(message)


		if (m_type & 1)
			visible_message(message)
		else if (m_type & 2)
			audible_message(message)

