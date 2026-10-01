script quickplay_choose_random_venue 
	if NOT GotParam \{can_change_level}
		can_change_level = 1
	endif
	unlocked_levels = []
	GetArraySize \{$LevelZoneArray}
	level_zone_array_size = <array_size>
	index = 0
	begin
	get_LevelZoneArray_checksum index = <index>
	if NOT StructureContains Structure = ($LevelZones.<level_checksum>) debug_only
		FormatText checksumname = venue_checksum 'venue_%s' s = ($LevelZones.<level_checksum>.name)
		GetGlobalTags <venue_checksum> param = unlocked
		add_venue = 0
		if (<unlocked> = 1)
			add_venue = 1
		endif
		if ($Cheat_UnlockATTBallpark = 1)
			if (<level_checksum> = load_z_Ballpark)
				add_venue = 1
			endif
		endif
		if (<add_venue> = 1)
			AddArrayElement array = <unlocked_levels> element = <level_checksum>
			<unlocked_levels> = <array>
		endif
	endif
	<index> = (<index> + 1)
	repeat <array_size>
	GetArraySize <unlocked_levels>
	if (<can_change_level> = 1)
		if (<array_size> != 0)
			GetRandomValue a = 0 b = (<array_size> - 1) Integer name = random_int
			change current_level = (<unlocked_levels> [<random_int>])
		else
			change \{current_level = load_z_bayou}
		endif
		if ($black_background = 1)
			change \{current_level = load_z_viewer}
		endif
	endif
endscript

script create_band \{async = 0}
	printf \{channel = AnimInfo
		qs("\Lcreate_band")}
	if ($disable_band = 1)
		return \{true}
	endif
	Band_ClearAnimTempo
	band_builder_create_band async = <async> min_time = <min_time>
	KillSpawnedScript \{name = PrepareBandForRenderUpdateLoop}
	spawnscriptnow \{PrepareBandForRenderUpdateLoop}
	debug_toggle_band_visiblity
	change \{enable_guitarist_camera_swapping = false}
	GetGlobalTags \{user_options
		attract_mode_fix = 1}
	if GotParam \{AirInstruments}
		if (<AirInstruments> = 1)
			change \{Cheat_AirInstruments = 1}
		else
			change \{Cheat_AirInstruments = 2}
		endif
	endif
	if GotParam \{InvisibleCharacters}
		if (<InvisibleCharacters> = 1)
			change \{Cheat_InvisibleCharacters = 1}
		else
			change \{Cheat_InvisibleCharacters = 2}
		endif
	endif
	BandManager_AirGuitarCheat
	BandManager_InvisibleCharactersCheat
	return \{true}
endscript

script BandManager_AirGuitarCheat 
	if ($Cheat_AirInstruments = 1)
		BandManager_HideAllInstruments
	elseif ($black_background = 1)
		BandManager_HideAllInstruments
	endif
endscript

script BandManager_InvisibleCharactersCheat 
	if ($Cheat_InvisibleCharacters = 1)
		BandManager_HideAllMusicians
	elseif ($black_background = 1)
		BandManager_HideAllMusicians
	endif
endscript

script GuitarEvent_StarPowerOn 
	KillSpawnedScript \{name = highway_pulse_black}
	if ($drum_solo_songtime_paused = 0)
		GH_Star_Power_Verb_On player = <player>
	endif
	if ($black_background = 0)
		FormatText checksumname = scriptID '%p_StarPower_StageFX' p = <player_text>
		SpawnScriptLater Do_StarPower_StageFX id = <scriptID> params = {<...>}
	endif
	StarPowerOn player = <player>
	if ($current_num_players = 4)
		if (all_players_using_starpower)
			spawnscriptnow \{play_group_star_power_animation}
			change \{achievements_121_jigowatts_flag = 1}
		endif
	endif
endscript

Default_Intro_Transition = {
	time = 3000
	ScriptTable = [
	]
}

script ui_create_pausemenu \{for_practice = 0}
	if ($is_network_game = 1)
		spawn_player_drop_listeners \{drop_player_script = pause_drop_player
			end_game_script = pause_end_game}
	endif
	enable_pause
	player_device = ($last_start_pressed_device)
	player = 1
	i = 1
	begin
	GetPlayerInfo <i> controller
	if (<controller> = <player_device>)
		player = <i>
		break
	endif
	i = (<i> + 1)
	repeat ($current_num_players)
	SoundEvent \{event = Pause_Menu_SFX}
	vocals_mute_all_mics \{mute = true}
	if NOT ($guitar_motion_enable_test = 1)
		if (<controller> >= 4)
			title_text = qs("AUTOPLAY PAUSED")
		else
			if ($g_in_tutorial = 1)
				title_text = <tutorial_pause_title>
			else
				title_text = qs("PAUSED")
			endif
			if NOT isSinglePlayerGame
				FormatText TextName = title_text qs("P%p PAUSED") p = <player>
			endif
		endif
		if ($g_in_tutorial = 1)
			if (<tutorial_failed> = 0)
				<pad_back_script> = tutorial_resume
			else
				<pad_back_script> = nullscript
			endif
		else
			<pad_back_script> = ui_pausemenu_exit
		endif
		ui_pausemenu_create_bg title_text = <title_text>
		if pausemenu_bg :Desc_ResolveAlias \{name = alias_menu}
			<parent> = <resolved_id>
		endif
		make_menu {
			parent = <parent>
			centered_offset = (-400.0, -275.0)
			pad_back_script = <pad_back_script>
			exclusive_device = <player_device>
			extra_z = 600
			centered
			spacing_between = -10
			noBG
		}
	else
		make_menu {
			pad_back_script = ui_pausemenu_exit
			exclusive_device = <player_device>
			centered
			noBG
			centered_offset = (400.0, 0.0)
			spacing_between = 0
		}
	endif
	if ($special_event_stage != 0)
		if ($current_special_event_num = 1)
			format_time_from_seconds time = ($total_special_event_time)
			total_time = <time_formatted>
			GetSpecialEventTimer
			format_time_from_seconds time = <time>
			time_left = <time_formatted>
			FormatText TextName = Timer_text qs("STUDIO TIME: %a (%b)") a = <total_time> b = <time_left>
			add_menu_item {
				text = <Timer_text>
				not_focusable
			}
			format_time_from_seconds time = ($special_event_total_expense_time / 1000)
			add_menu_item {
				text = (qs("SECTION LENGTH: ") + <time_formatted>)
				not_focusable
			}
			add_menu_item \{text = qs("RESUME")
				pad_choose_script = ui_pausemenu_exit}
			add_menu_item \{text = qs("START AGAIN")
				pad_choose_script = paused_special_event_start_again}
			add_menu_item \{text = qs("QUIT SEGMENT")
				pad_choose_script = paused_special_event_quit_segment}
			add_menu_item \{text = qs("QUIT CHALLENGE")
				pad_choose_script = paused_special_event_quit_challenge}
		elseif ($current_special_event_num = 2)
			GetSpecialEventTimer
			format_time_from_seconds time = <time>
			add_menu_item {
				text = (qs("TIME LEFT: ") + <time_formatted>)
				not_focusable
			}
			continue_practicing_text = qs("CONTINUE PRACTICING")
			if ($special_event_stage = 2)
				<continue_practicing_text> = qs("RESUME TEST")
			endif
			add_menu_item {
				text = <continue_practicing_text>
				pad_choose_script = ui_pausemenu_exit
			}
			if ($special_event_stage = 1)
				add_menu_item \{text = qs("TAKE THE TEST")
					pad_choose_script = special_event_2_ingame_setup}
			endif
			add_menu_item \{text = qs("QUIT CHALLENGE")
				pad_choose_script = paused_special_event_quit_challenge}
		endif
	else
		if ($g_in_tutorial = 1)
			if (<tutorial_failed> = 1)
				add_menu_item \{text = qs("RETRY")
					pad_choose_script = tutorial_restart}
				add_menu_item \{text = qs("SKIP LESSON")
					pad_choose_script = tutorial_skip_lesson}
			else
				add_menu_item \{text = qs("RESUME")
					pad_choose_script = tutorial_resume}
				add_menu_item \{text = qs("RESTART")
					pad_choose_script = tutorial_restart_warning}
				add_menu_item \{text = qs("SKIP LESSON")
					pad_choose_script = tutorial_skip_lesson}
			endif
		else
			add_menu_item \{text = qs("RESUME")
				pad_choose_script = ui_pausemenu_exit}
			if ($is_network_game = 0)
				if ($battle_do_or_die = 0)
					if ($end_credits = 0)
						add_menu_item \{text = qs("RESTART")
							choose_state = uistate_pausemenu_restart_warning}
					endif
				endif
			endif
		endif
		if (<for_practice> = 1 || $game_mode = training)
			if NOT PlayerInfoEquals \{1
					part = Vocals}
				add_menu_item \{text = qs("CHANGE SPEED")
					choose_state = uistate_pausemenu_quit_warning
					choose_state_data = {
						option2_text = qs("CHANGE SPEED")
						option2_func = {
							quit_warning_select_quit
							params = {
								callback = generic_event_back
								data = {
									state = uistate_practice_select_speed
								}
							}
						}
					}}
			endif
			add_menu_item \{text = qs("CHANGE SECTION")
				choose_state = uistate_pausemenu_quit_warning
				choose_state_data = {
					option2_text = qs("CHANGE SECTION")
					option2_func = {
						quit_warning_select_quit
						params = {
							callback = generic_event_back
							data = {
								state = uistate_select_song_section
							}
						}
					}
				}}
			if ($came_to_practice_from = main_menu)
				add_menu_item \{text = qs("NEW SONG")
					choose_state = uistate_pausemenu_quit_warning
					choose_state_data = {
						option2_text = qs("NEW SONG")
						option2_func = {
							quit_warning_select_quit
							params = {
								callback = song_ended_menu_select_new_song
							}
						}
					}}
			endif
			add_menu_item {
				text = qs("OPTIONS")
				choose_state = uistate_pause_options
				choose_state_data = {player_device = <player_device> player = <player>}
			}
		elseif NOT ($g_in_tutorial = 1)
			if ($is_network_game = 0)
				GameMode_GetType
				if ($current_song = jamsession)
					if NOT ui_event_exists_in_stack \{name = 'jam'}
						if (<type> = quickplay)
							if ($num_quickplay_song_list > 1)
								add_menu_item \{choose_state = uistate_pausemenu_quit_warning
									choose_state_data = {
										option2_text = qs("SKIP SONG")
										option2_func = quickplay_skip_song
										failed_song
									}
									text = qs("SKIP SONG")}
							endif
						endif
					endif
				else
					if NOT ($game_mode = p2_pro_faceoff || $game_mode = p2_faceoff || $game_mode = p2_battle)
						if ($end_credits = 0)
							add_menu_item {
								text = qs("DIFFICULTY")
								choose_state = UIstate_pausemenu_change_difficulty
								choose_state_data = {player_device = <player_device> player = <player>}
							}
						endif
					endif
					if (<type> = quickplay)
						if ($num_quickplay_song_list > 1)
							add_menu_item \{choose_state = uistate_pausemenu_quit_warning
								choose_state_data = {
									option2_text = qs("SKIP SONG")
									option2_func = quickplay_skip_song
									failed_song
								}
								text = qs("SKIP SONG")}
						endif
					endif
					if ($current_num_players = 1)
						if ($end_credits = 0)
							add_menu_item \{text = qs("PRACTICE")
								choose_state = uistate_practice_warning}
						endif
					endif
				endif
				if ($end_credits = 0)
					if ($battle_do_or_die = 0)
						add_menu_item {
							text = qs("OPTIONS")
							choose_state = uistate_pause_options
							choose_state_data = {player_device = <player_device> player = <player>}
						}
					endif
				endif
			endif
		endif
		quit_script = generic_event_choose no_sound = no_sound
		quit_script_params = {state = uistate_pausemenu_quit_warning}
		if ($is_in_debug)
			if ($end_credits = 1)
				quit_script = debug_quitcredits
				quit_script_params = {}
			else
				quit_script = generic_event_back
				quit_script_params = {state = uistate_debug}
			endif
		elseif ($is_network_game = 1)
			quit_script = select_quit_network_game
			quit_script_params = {}
		elseif ($g_in_tutorial = 1)
			quit_script = tutorial_quit_warning
			quit_script_params = {}
		endif
		if ($end_credits = 0)
			add_menu_item {
				text = qs("QUIT")
				pad_choose_script = <quit_script>
				pad_choose_params = <quit_script_params>
			}
		endif
	endif
	if ($enable_button_cheats = 1)
		add_menu_item \{text = qs("\LDebug Menu")
			choose_state = uistate_debug
			choose_state_data = {
				from_gameplay = 1
			}
			scale = (0.4, 0.36)}
	endif
	add_gamertag_helper \{exclusive_device = $last_start_pressed_device}
	if ($g_in_tutorial = 1)
		if (<tutorial_failed> = 0)
			<event_handlers> = [{pad_start tutorial_resume}]
			current_menu :SE_SetProps event_handlers = <event_handlers>
		else
			menu_finish \{no_back_button = 1}
			return
		endif
	endif
	menu_finish
endscript

script PlayMovieAndWait 
	return
endscript

script GH3_Crowd_Event_Listener 
	printf \{channel = sfx
		qs("\LCrowd Event Listener: Game Mode = %s")
		s = $game_mode}
	if NOT ($crowd_in_jam_mode_song_state = 1)
		GetPakManCurrent \{map = zones}
		printf channel = sfx qs("\LCrowd Event Listener: Pak = %s") s = <pak>
		if (<pak> != z_studio && <pak> != z_studio2 && <pak> != z_tool && <pak> != z_credits && <pak> != z_viewer)
			if NOT ($game_mode = training)
				if GotParam \{event_type}
					printf channel = sfx qs("\LCROWD PARAM!!!!!      %s") s = <event_type>
					switch <event_type>
						case 1
						if ($Turn_Off_OneShot_Cheers = 0)
							Play_A_Short_Crowd_Swell_For_This_Venue
						endif
						case 2
						if ($Turn_Off_OneShot_Cheers = 0)
							Play_A_Crowd_Applause_For_This_Venue
						endif
						case 3
						if ($current_crowd >= 1.3333)
							if ($Turn_Off_OneShot_Cheers = 0)
								Crowd_Surge_And_Sustain_At_End_Of_Song
							endif
						endif
						case 4
						Play_A_Crowd_Whistle_Good_Based_On_Venue
						case 5
						if ($current_crowd >= 1.3333)
							GH3_AdjustCrowdFastSmallSurge
						endif
						case 6
						if ($current_crowd >= 1.3333)
							if ($Turn_Off_OneShot_Cheers = 0)
								Play_A_Short_Crowd_Swell_For_This_Venue_Softer
							endif
							GH3_AdjustCrowdFastBigSurge
						endif
						case 7
						if ($current_crowd >= 1.3333)
							if ($Turn_Off_OneShot_Cheers = 0)
								Play_A_Med_Crowd_Swell_For_This_Venue
							endif
							GH3_AdjustCrowdMedSurge
						endif
						case 8
						if ($current_crowd >= 1.3333)
							if ($Turn_Off_OneShot_Cheers = 0)
								Play_A_Long_Crowd_Swell_For_This_Venue
							endif
							GH3_AdjustCrowdSlowBigSurge
						endif
						case 9
						printf \{'Not Working Right Now'}
						case 10
						Song_Quiet_Adjust_All_SFX_Down
						case 11
						Song_Quiet_Over_Adjust_All_SFX_To_Normal
						case 12
						Moment_On_Stage_Crowd_Reaction_SFX
						default
						printf \{channel = sfx
							qs("\LUh, oh!  NO EVENT TYPE SPECIFIED!!!!")}
					endswitch
				endif
			endif
		else
			printf \{channel = sfx
				qs("\LGH3_Crowd_Event_Listener: we are in one of the forbidden zones for crowd events!!!!")}
		endif
	else
		printf \{channel = sfx
			qs("\LGH3_Crowd_Event_Listener: $crowd_in_jam_mode_song_state equals 1, so we are in a jam mode song, so not playing any crowd listener events!")}
	endif
endscript

script Crowd_Singalong_Volume_Up 
	GetPakManCurrent \{map = zones}
	if NOT ((<pak> = z_tool) || (<pak> = z_studio) || (<pak> = z_credits) || (<pak> = z_training) || (<pak> = z_studio2) || (<pak> = z_viewer))
		if NOT ($crowd_is_singing = 1)
			SetSoundBussParams \{Crowd_Singalong = {
					vol = -2
				}
				time = 4}
		endif
		change \{crowd_is_singing = 1}
	endif
endscript

script do_actual_changing_of_looping_sound \{loading_transition = 0
		restarting = 0}
	if GotParam \{crowd_looping_state}
		GetPakManCurrent \{map = zones}
		switch <crowd_looping_state>
			case Bad
			New_BG_Area = $Current_Crowd_Looping_BG_Area_Bad
			New_OneShots = $Current_Crowd_OneShot_Negative_SoundEvent
			case neutral
			New_BG_Area = $Current_Crowd_Looping_BG_Area_Neutral
			New_OneShots = $Current_Crowd_OneShot_Positive_SoundEvent
			case good
			New_BG_Area = $Current_Crowd_Looping_BG_Area_Good
			New_OneShots = $Current_Crowd_OneShot_Positive_SoundEvent
			default
			printf \{channel = sfx
				qs("\LDEFAULT CASE!!!!!!!!   CROWD LOOPING STATE WAS NOT ONE OF THE THREE CASES!!!!")}
			New_BG_Area = $Current_Crowd_Looping_BG_Area_Good
			New_OneShots = $Current_Crowd_OneShot_Positive_SoundEvent
		endswitch
	else
		printf \{channel = sfx
			qs("\LNO CROWD_LOOPING_STATE PARAM WAS PASSED IN!!!!!")}
		return
	endif
	if (($crowd_in_jam_mode_song_state = 1) || (<pak> = z_studio) || (<pak> = z_studio2) || (<pak> = z_tool) || (<pak> = z_credits) || (<pak> = z_viewer))
		New_OneShots = DoNothing_OneShot
	endif
	Skate8_SFX_Backgrounds_New_Area BG_SFX_Area = <New_BG_Area> loading_transition = <loading_transition> restarting = <restarting>
	One_Shot_SoundEvent SoundEvent = <New_OneShots> waittime = 5
endscript

script GH_SFX_Intro_WarmUp 
	GetPakManCurrent \{map = zones}
	switch <pak>
		case z_metalfest
		spawnscriptnow \{metalfest_intro}
		SoundEvent \{event = z_metalfest_intro}
		case z_fairgrounds
		spawnscriptnow \{Fair_Intro}
		SoundEvent \{event = z_fairgrounds_intro}
		case z_newyork
		spawnscriptnow \{metalfest_intro}
		SoundEvent \{event = z_metalfest_intro}
		case z_ballpark
		spawnscriptnow \{metalfest_intro}
		SoundEvent \{event = z_metalfest_intro}
		case z_bayou
		spawnscriptnow \{Med_Inside_Intro}
		SoundEvent \{event = z_harbor_intro}
		case z_castle
		spawnscriptnow \{metalfest_intro}
		SoundEvent \{event = z_castle_intro}
		case z_goth
		spawnscriptnow \{Med_Inside_Intro}
		SoundEvent \{event = z_harbor_intro}
		case z_military
		spawnscriptnow \{Military_Intro}
		SoundEvent \{event = z_military_intro}
		case z_harbor
		spawnscriptnow \{metalfest_intro}
		SoundEvent \{event = z_castle_intro}
		case z_hotel
		spawnscriptnow \{Small_Intro}
		SoundEvent \{event = z_frathouse_intro}
		case z_cathedral
		spawnscriptnow \{Med_Inside_Intro}
		SoundEvent \{event = z_harbor_intro}
		case z_recordstore
		spawnscriptnow \{Small_Intro}
		SoundEvent \{event = z_frathouse_intro}
		case z_frathouse
		spawnscriptnow \{Small_Intro}
		SoundEvent \{event = z_frathouse_intro}
		case z_hob
		spawnscriptnow \{Med_Inside_Intro}
		SoundEvent \{event = z_harbor_intro}
		case z_studio
		SoundEvent \{event = z_studio_intro_1}
		printf \{channel = sfx
			qs("\LThis is Studio 1, and sould be playing sounds")}
		case z_studio2
		SoundEvent \{event = z_studio_intro_1}
		printf \{channel = sfx
			qs("\LNO INTRO!!!")}
		case z_scifi
		spawnscriptnow \{Military_Intro}
		SoundEvent \{event = z_scifi_intro}
		case z_credits
		SoundEvent \{event = z_credits_intro}
		default
		spawnscriptnow \{metalfest_intro}
		SoundEvent \{event = z_harbor_intro}
	endswitch
	if (<pak> != z_studio && <pak> != z_studio2 && <pak> != z_tool && <pak> != z_credits && <pak> != z_viewer)
		SoundEvent \{event = $Current_Crowd_Applause_SoundEvent_L}
		SoundEvent \{event = $Current_Crowd_Applause_SoundEvent_R}
	endif
	KillSpawnedScript \{name = Loading_Screen_Crowd_Swell}
	KillSpawnedScript \{name = Crowd_Loading_Whistle}
	SetSoundBussParams {Crowd_Beds = {vol = (($Default_BussSet.Crowd_Beds.vol))} time = 2}
endscript

script One_Shot_SoundEvent \{waittime = 15
		immediate = 0}
	GetPakManCurrent \{map = zones}
	if NOT ((z_studio = <pak>) || (z_studio2 = <pak>) || (z_soundcheck = <pak>) || (z_board_room = <pak>) || (z_viewer = <pak>))
		if GotParam \{SoundEvent}
			RequestedSoundEvent = <SoundEvent>
		else
			RequestedSoundEvent = DoNothing_OneShot
		endif
		LocalCurrentlyPlaying = $CurrentlyPlayingOneShotSoundEvent
		if (<LocalCurrentlyPlaying> = <RequestedSoundEvent>)
			if NOT ($CurrentOneShotWaitTime = <waittime>)
				DoActualChangeingOfOneShots <...>
			endif
		else
			DoActualChangeingOfOneShots <...>
		endif
	endif
endscript

script SpawnedOneShotBeginRepeatLoop \{waittime = 15}
	if NOT (<myoneshot> = DoNothing_OneShot)
		Wait (RandomFloat (0.3, 0.5) * <waittime>) seconds
		begin
		GetPakManCurrent \{map = zones}
		if NOT ((z_studio = <pak>) || (z_studio2 = <pak>) || (z_soundcheck = <pak>) || (z_board_room = <pak>) || (z_viewer = <pak>))
			SoundEvent event = <myoneshot>
			begin
			if isSoundEventPlaying <myoneshot>
				Wait \{1
					gameframe}
			else
				break
			endif
			repeat
			Wait (RandomFloat (0.9, 1.6) * <waittime>) seconds
		else
			break
		endif
		repeat
	else
	endif
endscript

script play_win_lose_anim_sound \{skip = 0}
	Obj_GetID
	i = 1
	begin
	FormatText checksumname = player_status 'player%a_status' a = <i>
	if (($<player_status>.band_member) = <ObjID>)
		part = ($<player_status>.part)
		skip = 1
		break
	endif
	i = (<i> + 1)
	repeat 5
	if NOT (<skip> = 1)
		switch <ObjID>
			case Guitarist
			part = guitar
			case bassist
			part = Bass
			case vocalist
			part = Vocals
			case Drummer
			part = drum
			default
			part = guitar
		endswitch
	endif
	song = ($current_song)
	if (<song> = bosszakk || <song> = bossted || <song> = dlc1 || <song> = dlc2)
		part = guitar
	endif
	if ($game_mode = p1_career)
		if (<song> = stillborn || <song> = stranglehold)
			part = guitar
		endif
	endif
	part = <part>
	printf channel = sfx qs("\LThis Anim Is playing the < %s > Sound") s = <part>
	GetPakManCurrent \{map = zones}
	if NOT (<pak> = z_tool && <pak> = z_viewer)
		if GotParam \{event}
			switch <event>
				case mic_feedback
				SoundEvent \{event = mic_feedback}
				case mic_grab
				SoundEvent \{event = mic_grab}
				case mic_hit
				SoundEvent \{event = mic_hit}
				case Drummer_sticks_throw
				SoundEvent \{event = Drummer_sticks_throw}
				case Large_Smash
				if GotParam \{part}
					switch <part>
						case Bass
						SoundEvent \{event = large_Bass_smash}
						case guitar
						SoundEvent \{event = large_guitar_smash}
						default
						printf \{channel = sfx
							qs("\LDid not get Part Guitar or Bass for win/lose anims!!!")}
					endswitch
				endif
				case Medium_Smash
				if GotParam \{part}
					switch <part>
						case Bass
						SoundEvent \{event = medium_Bass_smash}
						case guitar
						SoundEvent \{event = medium_guitar_smash}
						default
						printf \{channel = sfx
							qs("\LDid not get Part Guitar or Bass for win/lose anims!!!")}
					endswitch
				endif
				case small_smash
				if GotParam \{part}
					switch <part>
						case Bass
						SoundEvent \{event = small_Bass_smash}
						case guitar
						SoundEvent \{event = small_guitar_smash}
						default
						printf \{channel = sfx
							qs("\LDid not get Part Guitar or Bass for win/lose anims!!!")}
					endswitch
				endif
				case Ozzy_Bucket_Water
				SoundEvent \{event = Ozzy_Bucket_Water}
				case ozzy_bucket_throw
				SoundEvent \{event = ozzy_bucket_throw}
				case Drummer_Tom_Hit
				SoundEvent \{event = Drummer_Tom_Hit}
				case Drummer_Snare_Hit
				SoundEvent \{event = Drummer_Snare_Hit}
				default
				printf \{channel = sfx
					qs("\LWE Are Missing A Win/Lose Anim Sound!!!!!!!!")}
			endswitch
		endif
	endif
endscript

script Setup_All_Crowd_Sounds_Based_On_Zone 
	VenueSize = 'Medium_EXT'
	GetPakManCurrentName \{map = zones}
	FormatText checksumname = scriptgetvenuesize '%s_sfx_Get_Venue_Size' s = <pakname> AddToStringLookup = true
	if ScriptExists <scriptgetvenuesize>
		<scriptgetvenuesize>
	else
		VenueSize = 'Medium_EXT'
	endif
	FormatText checksumname = whistletemp 'Crowd_Whistle_%s_Good' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Whistle_SoundEvent = <whistletemp>
	FormatText checksumname = oneshotgoodtemp 'Crowd_OneShot_%s_Good' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_OneShot_Positive_SoundEvent = <oneshotgoodtemp>
	FormatText checksumname = oneshotbadtemp 'Crowd_OneShot_%s_Bad' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_OneShot_Negative_SoundEvent = <oneshotbadtemp>
	FormatText checksumname = loopgoodtemp 'Crowd_Loop_%s_Good' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Looping_BG_Area_Good = <loopgoodtemp>
	FormatText checksumname = loopneutraltemp 'Crowd_Loop_%s_Neutral' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Looping_BG_Area_Neutral = <loopneutraltemp>
	FormatText checksumname = loopbadtemp 'Crowd_Loop_%s_Bad' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Looping_BG_Area_Bad = <loopbadtemp>
	crowdtransitionchecksum = Crowd_Transition
	state_p_to_m_Left = '_poor_to_med_L'
	state_m_to_p_Left = '_med_to_poor_L'
	state_m_to_g_Left = '_med_to_good_L'
	state_g_to_m_Left = '_good_to_med_L'
	state_p_to_m_Right = '_poor_to_med_R'
	state_m_to_p_Right = '_med_to_poor_R'
	state_m_to_g_Right = '_med_to_good_R'
	state_g_to_m_Right = '_good_to_med_R'
	FormatText checksumname = claptemp 'Crowd_Clap_To_Beat_%s_Normal' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Clap_Normal_SoundEvent = <claptemp>
	FormatText checksumname = claptemp 'Crowd_Clap_To_Beat_%s_Middle' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Clap_Middle_SoundEvent = <claptemp>
	FormatText checksumname = claptemp 'Crowd_Clap_To_Beat_%s_Left_Middle' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Clap_Left_Middle_SoundEvent = <claptemp>
	FormatText checksumname = claptemp 'Crowd_Clap_To_Beat_%s_Right_Middle' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Clap_Right_Middle_SoundEvent = <claptemp>
	FormatText checksumname = claptemp 'Crowd_Clap_To_Beat_%s_Left' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Clap_Left_SoundEvent = <claptemp>
	FormatText checksumname = claptemp 'Crowd_Clap_To_Beat_%s_Right' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Clap_Right_SoundEvent = <claptemp>
	FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Poor_To_Med' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Transition_Bad_To_Neutral = <transitiontemp>
	FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Med_To_Poor' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Transition_Neutral_To_Bad = <transitiontemp>
	FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Med_To_Good' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Transition_Neutral_To_Good = <transitiontemp>
	FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Good_To_Med' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Transition_Good_To_Neutral = <transitiontemp>
	FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Poor_To_Med_L' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Transition_Bad_To_Neutral_L = <transitiontemp>
	FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Poor_To_Med_R' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Transition_Bad_To_Neutral_R = <transitiontemp>
	FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Med_To_Poor_L' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Transition_Neutral_To_Bad_L = <transitiontemp>
	FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Med_To_Poor_R' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Transition_Neutral_To_Bad_R = <transitiontemp>
	FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Med_To_Good_L' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Transition_Neutral_To_Good_L = <transitiontemp>
	FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Med_To_Good_R' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Transition_Neutral_To_Good_R = <transitiontemp>
	FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Good_To_Med_L' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Transition_Good_To_Neutral_L = <transitiontemp>
	FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Good_To_Med_R' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Transition_Good_To_Neutral_R = <transitiontemp>
	FormatText checksumname = battlecheertemp 'Crowd_Battle_Cheer_%s_L_P1' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Battle_Cheer_L_P1 = <battlecheertemp>
	FormatText checksumname = battlecheertemp 'Crowd_Battle_Cheer_%s_R_P1' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Battle_Cheer_R_P1 = <battlecheertemp>
	FormatText checksumname = battlecheertemp 'Crowd_Battle_Cheer_%s_L_P2' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Battle_Cheer_L_P2 = <battlecheertemp>
	FormatText checksumname = battlecheertemp 'Crowd_Battle_Cheer_%s_R_P2' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Battle_Cheer_R_P2 = <battlecheertemp>
	FormatText checksumname = swelltemp 'Crowd_Swell_Short_%s_L' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Swell_Short_SoundEvent_L = <swelltemp>
	FormatText checksumname = swelltemp 'Crowd_Swell_Short_%s_R' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Swell_Short_SoundEvent_R = <swelltemp>
	FormatText checksumname = swelltemp 'Crowd_Swell_Short_Soft_%s_L' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Swell_Short_Soft_SoundEvent_L = <swelltemp>
	FormatText checksumname = swelltemp 'Crowd_Swell_Short_Soft_%s_R' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Swell_Short_Soft_SoundEvent_R = <swelltemp>
	FormatText checksumname = swelltemp 'Crowd_Swell_Med_%s_L' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Swell_Med_SoundEvent_L = <swelltemp>
	FormatText checksumname = swelltemp 'Crowd_Swell_Med_%s_R' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Swell_Med_SoundEvent_R = <swelltemp>
	FormatText checksumname = swelltemp 'Crowd_Swell_Long_%s_L' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Swell_Long_SoundEvent_L = <swelltemp>
	FormatText checksumname = swelltemp 'Crowd_Swell_Long_%s_R' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Swell_Long_SoundEvent_R = <swelltemp>
	FormatText checksumname = encoretemp '%s_Encore_Crowd' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Encore = <encoretemp>
	FormatText checksumname = anticipationtemp '%s_Crowd_Anticipation_Loop' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Anticipation = <anticipationtemp>
	FormatText checksumname = Applausetemp 'Crowd_Applause_%s_L' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Applause_SoundEvent_L = <Applausetemp>
	FormatText checksumname = Applausetemp 'Crowd_Applause_%s_R' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_Applause_SoundEvent_R = <Applausetemp>
	FormatText checksumname = IntroTemp 'Crowd_Venue_Intro_%s' s = <pakname> AddToStringLookup = true
	change Current_Crowd_Venue_Intro_SoundEvent = <IntroTemp>
	FormatText checksumname = PreEncoreTemp 'Crowd_PreEncore_Looping_SoundEvent_%s' s = <VenueSize> AddToStringLookup = true
	change Current_Crowd_PreEncore_Looping_SoundEvent = <PreEncoreTemp>
	FormatText checksumname = tempvenuesize '%s' s = <VenueSize> AddToStringLookup = true
	change Current_Venue_Size = <tempvenuesize>
	if ((<pakname> = 'z_studio') || (<pakname> = 'z_studio2'))
		change \{Current_Crowd_Looping_BG_Area_Bad = MusicStudio}
		change \{Current_Crowd_Looping_BG_Area_Neutral = MusicStudio}
		change \{Current_Crowd_Looping_BG_Area_Good = MusicStudio}
		change \{Current_Crowd_Looping_BG_Area = MusicStudio}
	endif
	if ((<pakname> = 'z_tool') || (<pakname> = 'z_credits') || (<pakname> = 'z_viewer'))
		<VenueSize> = 'Large_EXT'
		FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Poor_To_Med' s = <VenueSize> AddToStringLookup = true
		change Current_Crowd_Transition_Bad_To_Neutral = <transitiontemp>
		FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Med_To_Poor' s = <VenueSize> AddToStringLookup = true
		change Current_Crowd_Transition_Neutral_To_Bad = <transitiontemp>
		FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Med_To_Good' s = <VenueSize> AddToStringLookup = true
		change Current_Crowd_Transition_Neutral_To_Good = <transitiontemp>
		FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Good_To_Med' s = <VenueSize> AddToStringLookup = true
		change Current_Crowd_Transition_Good_To_Neutral = <transitiontemp>
		FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Poor_To_Med_L' s = <VenueSize> AddToStringLookup = true
		change Current_Crowd_Transition_Bad_To_Neutral_L = <transitiontemp>
		FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Poor_To_Med_R' s = <VenueSize> AddToStringLookup = true
		change Current_Crowd_Transition_Bad_To_Neutral_R = <transitiontemp>
		FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Med_To_Poor_L' s = <VenueSize> AddToStringLookup = true
		change Current_Crowd_Transition_Neutral_To_Bad_L = <transitiontemp>
		FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Med_To_Poor_R' s = <VenueSize> AddToStringLookup = true
		change Current_Crowd_Transition_Neutral_To_Bad_R = <transitiontemp>
		FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Med_To_Good_L' s = <VenueSize> AddToStringLookup = true
		change Current_Crowd_Transition_Neutral_To_Good_L = <transitiontemp>
		FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Med_To_Good_R' s = <VenueSize> AddToStringLookup = true
		change Current_Crowd_Transition_Neutral_To_Good_R = <transitiontemp>
		FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Good_To_Med_L' s = <VenueSize> AddToStringLookup = true
		change Current_Crowd_Transition_Good_To_Neutral_L = <transitiontemp>
		FormatText checksumname = transitiontemp 'Crowd_Transition_%s_Good_To_Med_R' s = <VenueSize> AddToStringLookup = true
		change Current_Crowd_Transition_Good_To_Neutral_R = <transitiontemp>
	endif
	printf \{channel = sfx
		qs("\L///////////////////////////////////////////////////////////////////////")}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Whistle_SoundEvent = %s")
		s = $Current_Crowd_Whistle_SoundEvent}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_OneShot_Positive_SoundEvent = %s")
		s = $Current_Crowd_OneShot_Positive_SoundEvent}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_OneShot_Negative_SoundEvent = %s")
		s = $Current_Crowd_OneShot_Negative_SoundEvent}
	printf \{channel = sfx
		qs("\L ")}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Looping_BG_Area_Bad = %s")
		s = $Current_Crowd_Looping_BG_Area_Bad}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Looping_BG_Area_Neutral = %s")
		s = $Current_Crowd_Looping_BG_Area_Neutral}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Looping_BG_Area_Good = %s")
		s = $Current_Crowd_Looping_BG_Area_Good}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Looping_BG_Area = %s")
		s = $Current_Crowd_Looping_BG_Area}
	printf \{channel = sfx
		qs("\L ")}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Transition_Bad_To_Neutral = %s")
		s = $Current_Crowd_Transition_Bad_To_Neutral}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Transition_Neutral_To_Bad = %s")
		s = $Current_Crowd_Transition_Neutral_To_Bad}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Transition_Neutral_To_Good = %s")
		s = $Current_Crowd_Transition_Neutral_To_Good}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Transition_Good_To_Neutral = %s")
		s = $Current_Crowd_Transition_Good_To_Neutral}
	printf \{channel = sfx
		qs("\L ")}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Transition_Bad_To_Neutral_L = %s")
		s = $Current_Crowd_Transition_Bad_To_Neutral_L}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Transition_Bad_To_Neutral_R = %s")
		s = $Current_Crowd_Transition_Bad_To_Neutral_R}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Transition_Neutral_To_Bad_L = %s")
		s = $Current_Crowd_Transition_Neutral_To_Bad_L}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Transition_Neutral_To_Bad_R = %s")
		s = $Current_Crowd_Transition_Neutral_To_Bad_R}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Transition_Neutral_To_Good_L = %s")
		s = $Current_Crowd_Transition_Neutral_To_Good_L}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Transition_Neutral_To_Good_R = %s")
		s = $Current_Crowd_Transition_Neutral_To_Good_R}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Transition_Good_To_Neutral_L = %s")
		s = $Current_Crowd_Transition_Good_To_Neutral_L}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Transition_Good_To_Neutral_R = %s")
		s = $Current_Crowd_Transition_Good_To_Neutral_R}
	printf \{channel = sfx
		qs("\L ")}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Swell_Short_SoundEvent_L = %s")
		s = $Current_Crowd_Swell_Short_SoundEvent_L}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Swell_Short_SoundEvent_R = %s")
		s = $Current_Crowd_Swell_Short_SoundEvent_R}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Swell_Med_SoundEvent_L = %s")
		s = $Current_Crowd_Swell_Med_SoundEvent_L}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Swell_Med_SoundEvent_R = %s")
		s = $Current_Crowd_Swell_Med_SoundEvent_R}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Swell_Long_SoundEvent_L = %s")
		s = $Current_Crowd_Swell_Long_SoundEvent_L}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Swell_Long_SoundEvent_R = %s")
		s = $Current_Crowd_Swell_Long_SoundEvent_R}
	printf \{channel = sfx
		qs("\L ")}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Applause_SoundEvent_L = %s")
		s = $Current_Crowd_Applause_SoundEvent_L}
	printf \{channel = sfx
		qs("\LCurrent_Crowd_Applause_SoundEvent_R = %s")
		s = $Current_Crowd_Applause_SoundEvent_R}
	printf \{channel = sfx
		qs("\L///////////////////////////////////////////////////////////////////////")}
endscript

script Crowd_Surge_And_Sustain_At_End_Of_Song 
	if NOT ((<pak> = z_tool) || (<pak> = z_studio) || (<pak> = z_credits) || (<pak> = z_viewer) || (<pak> = z_studio2))
		SetSoundBussParams {Crowd_Beds = {vol = (($Default_BussSet.Crowd_Beds.vol) + 4)} time = 3.5}
	endif
endscript