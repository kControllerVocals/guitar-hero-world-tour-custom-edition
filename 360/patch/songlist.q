gh_songlist = [
	rebelyell
	jamsession
	DrumStreamTest
	synctest
	synctestplaytoaudio
	synctestaudioandvisual
	synctestmuting
	tenseconddebug
	elevenseconddebug
	twelveseconddebug
	testtones
	Tut_Bass_OpenNote
	Tut_Demo
	Tut_Drum_Activ
	Tut_Drum_Beat1
	Tut_Drum_Beat2
	Tut_Drum_Beat3
	Tut_Drum_Break
	Tut_Drum_Combos
	Tut_Drum_Free
	Tut_Drum_Kick
	Tut_Drum_OneHand
	Tut_Drum_TwoHands
	Tut_Gtr_Chords
	Tut_Gtr_Combos
	Tut_Gtr_DiffNotes
	Tut_Gtr_ExtSus
	Tut_Gtr_HamOn
	Tut_Gtr_LongNotes
	Tut_Gtr_PlayNotes
	Tut_Gtr_PullOff
	Tut_Gtr_Slide
	Tut_Gtr_Tilt
	Tut_Gtr_Wham
	Tut_Vox_Activ
	Tut_Vox_Combos
	Tut_Vox_Freeform
	Tut_Vox_HitNotes
	Tut_Vox_Hype
	Tut_Vox_Spoken
	Tut_VS_BattPow
	Tut_VS_MultAttck
	Tut_VS_Recov
	Tut_VS_Tilt
	PlaceHolderSong
]
final_credits_song = PullMeUnder
download_songlist = [
]
download_songlist_props = {
}
gh_songlist_props = {
	$download_songlist_props
	$permanent_songlist_props
	$jamsession_songlist_props
}
artist_text_by = qs("BY")
artist_text_from = qs("FROM")
artist_text_as_made_famous_by = qs("AS MADE FAMOUS BY")
jamsession_songlist_props = {
	jamsession = {
		checksum = jamsession
		name = 'jamsession'
		title = qs("\LJam Session")
		artist = qs("\LCustom")
		year = qs("\L, 2008")
		year_num = 2008
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 1
		singer = Male
		genre = Rock
		countoff = 'hihat01'
		saved_in_globaltags = 0
	}
}
permanent_songlist_props = {
	rebelyell = {
		checksum = rebelyell
		name = 'RebelYell'
		title = qs("\LREBEL YELL")
		artist = qs("\LBILLY IDOL")
		year = qs("\L, 1983")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 1
		singer = Male
		genre = Punk
		countoff = 'Sticks_Normal'
		drum_kit = 'modernrock'
		drum_solo = 1
		overall_song_volume = -3
		never_show_in_setlist
	}
	synctest = {
		checksum = synctest
		name = 'synctest'
		title = qs("\LDEBUG - VISUAL LAG TEST")
		artist = qs("\LNS")
		year = qs("\L, 2007")
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		leaderboard = 0
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		saved_in_globaltags = 0
	}
	synctestplaytoaudio = {
		checksum = synctestplaytoaudio
		name = 'synctestplaytoaudio'
		title = qs("\LDEBUG - AUDIO LAG TEST")
		artist = qs("\LNS")
		year = qs("\L, 2007")
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		leaderboard = 0
		exit_script = Audio_Sync_Test_Enable_Highway
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		saved_in_globaltags = 0
	}
	synctestaudioandvisual = {
		checksum = synctestaudioandvisual
		name = 'synctestaudioandvisual'
		title = qs("\LDEBUG - COMBINED AUDIO/VISUAL TEST")
		artist = qs("\LNS")
		year = qs("\L, 2007")
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		leaderboard = 0
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		saved_in_globaltags = 0
	}
	synctestmuting = {
		checksum = synctestmuting
		name = 'synctestmuting'
		title = qs("\LDEBUG - SYNC TEST MUTING")
		artist = qs("\LNS")
		year = qs("\L, 2007")
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		leaderboard = 0
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		saved_in_globaltags = 0
	}
	tenseconddebug = {
		checksum = tenseconddebug
		name = 'tenseconddebug'
		title = qs("\LDEBUG - TEN SECOND DEBUG")
		artist = qs("\LNS")
		year = qs("\L, 2008")
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		leaderboard = 0
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
	}
	elevenseconddebug = {
		checksum = elevenseconddebug
		name = 'elevenseconddebug'
		title = qs("\LDEBUG - ELEVEN")
		artist = qs("\LNS")
		year = qs("\L, 2008")
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		leaderboard = 0
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
	}
	twelveseconddebug = {
		checksum = twelveseconddebug
		name = 'twelveseconddebug'
		title = qs("\LDEBUG - TWELVE SECOND DEBUG")
		artist = qs("\LNS")
		year = qs("\L, 2008")
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		leaderboard = 0
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
	}
	testtones = {
		checksum = testtones
		name = 'testtones'
		title = qs("\Ltest tones")
		artist = qs("\LNS")
		year = qs("\L, 2007")
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		leaderboard = 0
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		exit_script = TestToneExitScript
		saved_in_globaltags = 0
	}
	Tut_Bass_OpenNote = {
		checksum = Tut_Bass_OpenNote
		name = 'Tut_Bass_OpenNote'
		title = qs("\LTut_Bass_OpenNote")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Demo = {
		checksum = Tut_Demo
		name = 'Tut_Demo'
		title = qs("\LTut_Demo")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Drum_Activ = {
		checksum = Tut_Drum_Activ
		name = 'Tut_Drum_Activ'
		title = qs("\LTut_Drum_Activ")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Drum_Beat1 = {
		checksum = Tut_Drum_Beat1
		name = 'Tut_Drum_Beat1'
		title = qs("\LTut_Drum_Beat1")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Drum_Beat2 = {
		checksum = Tut_Drum_Beat2
		name = 'Tut_Drum_Beat2'
		title = qs("\LTut_Drum_Beat2")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Drum_Beat3 = {
		checksum = Tut_Drum_Beat3
		name = 'Tut_Drum_Beat3'
		title = qs("\LTut_Drum_Beat3")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Drum_Break = {
		checksum = Tut_Drum_Break
		name = 'Tut_Drum_Break'
		title = qs("\LTut_Drum_Break")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Drum_Combos = {
		checksum = Tut_Drum_Combos
		name = 'Tut_Drum_Combos'
		title = qs("\LTut_Drum_Combos")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Drum_Kick = {
		checksum = Tut_Drum_Kick
		name = 'Tut_Drum_Kick'
		title = qs("\LTut_Drum_Kick")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Drum_Free = {
		checksum = Tut_Drum_Free
		name = 'Tut_Drum_Free'
		title = qs("\LTut_Drum_Free")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Drum_OneHand = {
		checksum = Tut_Drum_OneHand
		name = 'Tut_Drum_OneHand'
		title = qs("\LTut_Drum_OneHand")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Drum_TwoHands = {
		checksum = Tut_Drum_TwoHands
		name = 'Tut_Drum_TwoHands'
		title = qs("\LTut_Drum_TwoHands")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Gtr_Chords = {
		checksum = Tut_Gtr_Chords
		name = 'Tut_Gtr_Chords'
		title = qs("\LTut_Gtr_Chords")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Gtr_Combos = {
		checksum = Tut_Gtr_Combos
		name = 'Tut_Gtr_Combos'
		title = qs("\LTut_Gtr_Combos")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Gtr_DiffNotes = {
		checksum = Tut_Gtr_DiffNotes
		name = 'Tut_Gtr_DiffNotes'
		title = qs("\LTut_Gtr_DiffNotes")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Gtr_ExtSus = {
		checksum = Tut_Gtr_ExtSus
		name = 'Tut_Gtr_ExtSus'
		title = qs("\LTut_Gtr_ExtSus")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Gtr_HamOn = {
		checksum = Tut_Gtr_HamOn
		name = 'Tut_Gtr_HamOn'
		title = qs("\LTut_Gtr_HamOn")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Gtr_LongNotes = {
		checksum = Tut_Gtr_LongNotes
		name = 'Tut_Gtr_LongNotes'
		title = qs("\LTut_Gtr_LongNotes")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Gtr_PlayNotes = {
		checksum = Tut_Gtr_PlayNotes
		name = 'Tut_Gtr_PlayNotes'
		title = qs("\LTut_Gtr_PlayNotes")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Gtr_PullOff = {
		checksum = Tut_Gtr_PullOff
		name = 'Tut_Gtr_PullOff'
		title = qs("\LTut_Gtr_PullOff")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Gtr_Slide = {
		checksum = Tut_Gtr_Slide
		name = 'Tut_Gtr_Slide'
		title = qs("\LTut_Gtr_Slide")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Gtr_Tilt = {
		checksum = Tut_Gtr_Tilt
		name = 'Tut_Gtr_Tilt'
		title = qs("\LTut_Gtr_Tilt")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Gtr_Wham = {
		checksum = Tut_Gtr_Wham
		name = 'Tut_Gtr_Wham'
		title = qs("\LTut_Gtr_Wham")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Vox_Activ = {
		checksum = Tut_Vox_Activ
		name = 'Tut_Vox_Activ'
		title = qs("\LTut_Vox_Activ")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Vox_Combos = {
		checksum = Tut_Vox_Combos
		name = 'Tut_Vox_Combos'
		title = qs("\LTut_Vox_Combos")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Vox_Freeform = {
		checksum = Tut_Vox_Freeform
		name = 'Tut_Vox_Freeform'
		title = qs("\LTut_Vox_Freeform")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Vox_HitNotes = {
		checksum = Tut_Vox_HitNotes
		name = 'Tut_Vox_HitNotes'
		title = qs("\LTut_Vox_HitNotes")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Vox_Hype = {
		checksum = Tut_Vox_Hype
		name = 'Tut_Vox_Hype'
		title = qs("\LTut_Vox_Hype")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_Vox_Spoken = {
		checksum = Tut_Vox_Spoken
		name = 'Tut_Vox_Spoken'
		title = qs("\LTut_Vox_Spoken")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_VS_BattPow = {
		checksum = Tut_VS_BattPow
		name = 'Tut_VS_BattPow'
		title = qs("\LTut_VS_BattPow")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_VS_MultAttck = {
		checksum = Tut_VS_MultAttck
		name = 'Tut_VS_MultAttck'
		title = qs("\LTut_VS_MultAttck")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_VS_Recov = {
		checksum = Tut_VS_Recov
		name = 'Tut_VS_Recov'
		title = qs("\LTut_VS_Recov")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	Tut_VS_Tilt = {
		checksum = Tut_VS_Tilt
		name = 'Tut_VS_Tilt'
		title = qs("\LTut_VS_Tilt")
		artist = qs("\LTutorial")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		allowed_in_quickplay = 0
		saved_in_globaltags = 0
	}
	PlaceHolderSong = {
		checksum = tenseconddebug
		name = 'tenseconddebug'
		title = qs("\LTHE PLACE-HOLDER SONG")
		artist = qs("\LTHE PLACE-HOLDERS")
		year = qs("\L, 2008")
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 0
		singer = Male
		genre = Rock
		countoff = 'sticks_normal'
		drum_kit = 'heavyrock'
		never_show_in_setlist
	}
}

script get_song_original_artist \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		return original_artist = ($gh_songlist_props.<song>.original_artist)
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script get_song_title \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		return song_title = ($gh_songlist_props.<song>.title)
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script get_song_prefix \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		return song_prefix = ($gh_songlist_props.<song>.name)
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script get_song_name \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		return song_name = ($gh_songlist_props.<song>.name)
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script get_song_artist \{song = invalid
		with_year = 1}
	if StructureContains Structure = $gh_songlist_props <song>
		if (<with_year>)
			return song_artist = (($gh_songlist_props.<song>.artist) + ($gh_songlist_props.<song>.year))
		else
			return song_artist = ($gh_songlist_props.<song>.artist)
		endif
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script get_song_artist_text \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		return song_artist_text = ($gh_songlist_props.<song>.artist_text)
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript
Perf2_Settings = [
	{
		song = stillborn
		mode = p1_career
		char_type = vocalist
		char_id = ZakkWylde
	}
	{
		song = Today
		mode = p1_career
		char_type = vocalist
		char_id = Billy
	}
	{
		song = DemolitionMan
		mode = p1_career
		char_type = vocalist
		char_id = RandomCharacter
	}
	{
		song = stillborn
		mode = p1_career
		char_type = Bass
		char_id = RandomCharacter
	}
	{
		song = stillborn
		mode = p2_career
		char_type = vocalist
		char_id = ZakkWylde
	}
	{
		song = Today
		mode = p2_career
		char_type = vocalist
		char_id = Billy
	}
	{
		song = DemolitionMan
		mode = p2_career
		char_type = vocalist
		char_id = RandomCharacter
	}
	{
		song = stillborn
		mode = p2_career
		char_type = Bass
		char_id = RandomCharacter
	}
	{
		song = stillborn
		mode = p3_career
		char_type = vocalist
		char_id = ZakkWylde
	}
	{
		song = Today
		mode = p3_career
		char_type = vocalist
		char_id = Billy
	}
	{
		song = DemolitionMan
		mode = p3_career
		char_type = vocalist
		char_id = RandomCharacter
	}
	{
		song = stillborn
		mode = p3_career
		char_type = Bass
		char_id = RandomCharacter
	}
]

script get_song_performance 
	if StructureContains Structure = $gh_songlist_props <song>
		if StructureContains Structure = ($gh_songlist_props.<song>) performance
			if ($gh_songlist_props.<song>.performance = 1)
				performance = 0
				get_band_name song = <song>
				singing_guitarist = false
				if has_singing_guitarist Band = <Band>
					singing_guitarist = true
				elseif has_singing_bassist Band = <Band>
					singing_guitarist = true
				endif
				if (<singing_guitarist> = true)
					if (($<Band>.vocalist = Jimi) && ($current_num_players = 1))
						performance = 1
					else
						if NOT is_any_player_on_part \{part = Vocals}
							performance = 1
						endif
					endif
				endif
				printf channel = Band qs("\Lusing performance %a") a = (<performance> + 1)
				return song_performance = <performance>
			else
				return song_performance = ($gh_songlist_props.<song>.performance - 1)
			endif
		else
			return \{song_performance = 0}
		endif
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script is_any_player_on_part 
	GameMode_GetNumPlayersShown
	player = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player> AddToStringLookup
	if ($<player_status>.part = <part>)
		return \{true}
	endif
	player = (<player> + 1)
	repeat <num_players_shown>
	return \{false}
endscript

script get_song_struct \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		return song_struct = ($gh_songlist_props.<song>)
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script get_songlist_size 
	GetArraySize \{$gh_songlist}
	size = (<array_size>)
	if GlobalExists \{name = GH4_download_songlist
			type = array}
		GetArraySize \{$GH4_download_songlist}
		size = (<array_size> + <size>)
	endif
	return array_size = <size>
endscript

script get_songlist_checksum 
	GetArraySize \{$gh_songlist}
	if (<index> < <array_size>)
		return song_checksum = ($gh_songlist [<index>])
	else
		return song_checksum = ($GH4_download_songlist [(<index> - <array_size>)])
	endif
endscript

script is_song_downloaded \{song_checksum = schoolsout}
	if StructureContains Structure = ($download_songlist_props) <song_checksum>
		FormatText TextName = filename 'a%s_song.pak' s = (($download_songlist_props.<song_checksum>).name)
		GetContentFolderIndexFromFile <filename>
		if (<device> = content)
			return \{download = 1
				true}
		else
			return \{download = 1
				false}
		endif
	else
		return \{download = 0
			true}
	endif
endscript

script get_song_rhythm_track \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		if StructureContains Structure = ($gh_songlist_props.<song>) rhythm_track
			return rhythm_track = ($gh_songlist_props.<song>.rhythm_track)
		else
			return \{rhythm_track = 0}
		endif
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script get_song_saved_in_globaltags \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		if StructureContains Structure = ($gh_songlist_props.<song>) saved_in_globaltags
			return saved_in_globaltags = ($gh_songlist_props.<song>.saved_in_globaltags)
		else
			return \{saved_in_globaltags = 1}
		endif
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script get_song_allowed_in_quickplay \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		if StructureContains Structure = ($gh_songlist_props.<song>) allowed_in_quickplay
			return allowed_in_quickplay = ($gh_songlist_props.<song>.allowed_in_quickplay)
		else
			return \{allowed_in_quickplay = 1}
		endif
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript
current_song_version = gh4

script get_song_version \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		if StructureContains Structure = ($gh_songlist_props.<song>) version
			return song_version = ($gh_songlist_props.<song>.version)
		else
			return song_version = ($current_song_version)
		endif
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript
drum_kit_types = {
	heavyrock = 0
	classicrock = 1
}

script get_song_drum_kit_index \{song = invalid}
	if ($current_song = jamsession)
		return drum_kit_type = ($drum_kits [0].string_id) drum_kit_index = 0
	endif
	if StructureContains Structure = $gh_songlist_props <song>
		drum_kit_type = ($gh_songlist_props.<song>.drum_kit)
		GetArraySize ($drum_kits)
		drum_kit_index = 0
		begin
		if (<drum_kit_type> = $drum_kits [<drum_kit_index>].string_id)
			break
		endif
		drum_kit_index = (<drum_kit_index> + 1)
		repeat <array_size>
		if (<drum_kit_index> >= <array_size>)
			printscriptinfo \{qs("get_song_drum_kit_index")}
			ScriptAssert \{qs("\LDrum Kit Type not found")}
		endif
		return drum_kit_type = <drum_kit_type> drum_kit_index = <drum_kit_index>
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript
