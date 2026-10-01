# guitar-hero-world-tour-custom-edition

a custom edition of guitar hero world tour stripped out of all songs and prepared for custom

Features:
	Uses a different save file
	option to use black background
	all cheats unlocked by default
	option to use pad to play instruments
	option to enable debug menu (doesn't enable select viewer)

To make customs use honeycomb to convert the custom to ghwt pc then remove the "a" at the beggining of the chart file name and copy it to DATA\SONGS
Remove every ".xen" from the audios file names and encrypt them with onyx command line using the command "encrypt-gh-fsb ghwt" then copy them to DATA/MUSIC
add your song to songlist.q in DATA/patch and compile it to a pak using honeycomb
Keep in mind that everytime you add or remove a custom your save will become unusable

To have your customs show up in quickplay you'll need to use the Unlock All option in the mod menu

There's no PS3 version because the game kept crashing when loading a save and i couldn't disable saving. PS3 has no games