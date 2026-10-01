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