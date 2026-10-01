black_highway = 0
black_background = 0
no_fail = 0
is_custom_mode = 0

script create_main_menu_elements 
	if NOT ($invite_controller = -1)
		return
	endif
	base_menu_pos = (730.0, 125.0)
	main_menu_font = fontgrid_title_a1
	create_viewport_ui \{texture = `tex\zones\Sound_stage\Alpha_texture1.dds`
		texdict = `zones/z_Soundcheck/z_Soundcheck.tex`}
	if ($is_demo_mode = 1)
		demo_mode_disable = {rgba = [128 128 128 255] not_focusable}
	else
		demo_mode_disable = {}
	endif
	if ($is_demo_mode = 0)
		if ($is_multiplayer_beta = 1)
			demo_mode_disable = {rgba = [128 128 128 255] not_focusable}
		else
			demo_mode_disable = {}
		endif
	endif
	if ($is_demo_mode = 1)
		demo_mode_disable = {rgba = [128 128 128 255] not_focusable}
	else
		demo_mode_disable = {}
	endif
	CreateScreenElement {
		type = VMenu
		parent = <window_id>
		id = current_menu
		dims = (1280.0, 720.0)
		just = [left top]
		pos = (0.0, 0.0)
		internal_just = [center bottom]
		event_handlers = [
			{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
		]
		position_children = false
	}
	container_pos = (640.0, 100.0)
	add_mainmenu_item {
		parent = current_menu
		container_params = {
			pos = (<container_pos> + (-160.0, 0.0))
			<demo_mode_disable>
		}
		text_params = {
			text = qs("QUICKPLAY")
			<demo_mode_disable>
		}
		choose_script = main_menu_select_quickplay
	}
	container_pos = (<container_pos> + (0.0, 85.0))
	add_mainmenu_item {
		parent = current_menu
		container_params = {
			pos = <container_pos>
			<demo_mode_disable>
		}
		text_params = {
			text = qs("HEAD TO HEAD")
			<demo_mode_disable>
		}
		choose_script = main_menu_select_multiplayer
	}
	container_pos = (<container_pos> + (0.0, 85.0))
	if isXenon
		online_text = qs("Xbox LIVE")
	else
		online_text = qs("ONLINE")
	endif
	add_mainmenu_item {
		parent = current_menu
		container_params = {
			pos = (<container_pos> + (20.0, 0.0))
			<demo_mode_disable>
		}
		text_params = {
			text = <online_text>
			<demo_mode_disable>
		}
		choose_script = main_menu_select_online
	}
	container_pos = (<container_pos> + (0.0, 85.0))
	add_mainmenu_item {
		parent = current_menu
		container_params = {
			pos = (<container_pos> + (-60.0, 0.0))
		}
		text_params = {
			text = qs("MUSIC STUDIO")
		}
		choose_script = main_menu_select_jam
	}
	container_pos = (<container_pos> + (0.0, 85.0))
	add_mainmenu_item {
		parent = current_menu
		container_params = {
			pos = <container_pos>
			<demo_mode_disable>
		}
		text_params = {
			text = qs("ROCK STAR CREATOR")
			<demo_mode_disable>
		}
		choose_script = main_menu_select_cas
	}
	container_pos = (<container_pos> + (0.0, 85.0))
	add_mainmenu_item {
		parent = current_menu
		container_params = {
			pos = (<container_pos> + (-40.0, 0.0))
			<demo_mode_disable>
		}
		text_params = {
			text = qs("MOD MENU")
			<demo_mode_disable>
		}
		choose_script = main_menu_select_downloads
	}
	container_pos = (<container_pos> + (0.0, 85.0))
	add_mainmenu_item {
		parent = current_menu
		container_params = {
			pos = (<container_pos> + (0.0, 0.0))
			<demo_mode_disable>
		}
		text_params = {
			text = qs("OPTIONS")
			<demo_mode_disable>
		}
		choose_script = main_menu_select_options
	}
	container_pos = (<container_pos> + (0.0, 85.0))
	show_debug_menus = 0
	if ($enable_button_cheats = 1)
		<show_debug_menus> = 1
		if ($enable_debug_menus = 0)
			<show_debug_menus> = 0
		endif
	endif
	if (<show_debug_menus>)
		if ($is_multiplayer_beta = 0)
			add_mainmenu_item {
				parent = current_menu
				container_params = {
					pos = (<container_pos> + (-40.0, 0.0))
					<demo_mode_disable>
				}
				text_params = {
					text = qs("\LDEBUG MENU")
					<demo_mode_disable>
				}
				choose_script = main_menu_select_debug
			}
		endif
	endif
endscript

script ui_create_downloads 
	change \{respond_to_signin_changed = 1}
	change \{respond_to_signin_changed_func = none}
	menu_music_on
	make_menu_frontend \{screen = bassist
		title = qs("MOD MENU")}
	add_menu_frontend_item \{text = qs("Modifiers")
		choose_state = uistate_atom_unlock}	
	add_menu_frontend_item \{text = qs("Unlock All")
		pad_choose_script = playday_unlockall}
	add_menu_frontend_item \{text = qs("Show FPS")
		pad_choose_script = ToggleFPS}
	<item_id> :SE_SetProps {
		event_handlers = [
			{focus retail_menu_focus params = {id = <id>}}
			{unfocus retail_menu_unfocus params = {id = <id>}}
		]
	}
	menu_finish
endscript

script ui_create_atom_unlock 
	make_generic_menu \{title = qs("Modifiers")}
	add_generic_menu_text_item \{text = qs("No Fail")
		pad_choose_script = ui_no_fail_toggle}
	add_generic_menu_text_item \{text = qs("Black Background")
		pad_choose_script = ui_black_background_toggle}
	add_generic_menu_text_item \{text = qs("Use Pad as Instrument")
		pad_choose_script = toggle_allowcontroller}
	add_generic_menu_text_item \{text = qs("Debug Mode")
		pad_choose_script = ui_debug_mode_toggle}
	menu_finish
endscript

script ui_no_fail_toggle
	if ($no_fail = 0)
		Change no_fail = 1
		change \{debug_forcescore = good}
		SoundEvent \{Event = CheckBox_Check_SFX}
	else
		Change no_fail = 0
		change \{debug_forcescore = off}
		SoundEvent \{Event = CheckBox_SFX}
	endif
endscript

script ui_black_highway_toggle
	if ($black_highway = 0)
		Change black_highway = 1
		Change highway_normal = [0 0 0 255]
		Change highway_starpower = [0 0 0 255]
	 	SoundEvent \{Event = CheckBox_Check_SFX}
	else
		Change black_highway = 0
		Change highway_normal = [255 255 255 255]
		Change highway_starpower = [64 255 255 255]
		SoundEvent \{Event = CheckBox_SFX}
	endif
endscript

script ui_debug_mode_toggle
	if ($enable_button_cheats = 0)
		Change enable_button_cheats = 1
		SoundEvent \{Event = CheckBox_Check_SFX}
	else
		Change enable_button_cheats = 0
		SoundEvent \{Event = CheckBox_SFX}
	endif
endscript

script ui_black_background_toggle
	if ($black_background = 0)
		Change black_background = 1
		SoundEvent \{Event = CheckBox_Check_SFX}
	else
		Change black_background = 0
		SoundEvent \{Event = CheckBox_SFX}
	endif
endscript

script toggle_allowcontroller 
	if ($allow_controller_for_all_instruments = 1)
		change \{allow_controller_for_all_instruments = 0}
		SoundEvent \{Event = CheckBox_SFX}
	else
		change \{allow_controller_for_all_instruments = 1}
		SoundEvent \{Event = CheckBox_Check_SFX}
	endif
	toggle_allowcontroller_setprop
endscript

