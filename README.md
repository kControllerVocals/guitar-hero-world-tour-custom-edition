# guitar-hero-world-tour-custom-edition

a custom edition of guitar hero world tour stripped out of all songs and prepared for customs

Features:
	
-	Uses a different save file

-	option to use black background
	
	
-	all cheats unlocked by default
	
	
-	option to use pad to play instruments
	
	
-	option to enable debug menu (doesn't enable select viewer)

To make customs use honeycomb to convert the custom to ghwt pc then remove the "a" at the beggining of the chart file name and copy it to DATA\SONGS
PS3 ONLY: extract the chart pack with honeycomb and recompile it for ps3
PS3 ONLY: copy the chart file and paste it in the same folder and add "_VRAM" just before ".PAK.PS3" (Exemple: SATCHBOOGIE_SONG.PAK.PS3 -> SATCHBOOGIE_SONG_VRAM.PAK.PS3)
Remove every ".xen" from the audios file names and encrypt them with onyx command line using the command "encrypt-gh-fsb ghwt" then copy them to DATA/MUSIC
PS3 ONLY: rename the files to all caps and and replace ".xen" with ".PS3" PS3 needs to have all of its files all caps or it will not work
add your song to songlist.q in DATA/patch and compile it to a pak using honeycomb
Keep in mind that everytime you add or remove a custom your save will become unusable
 
To have your customs show up in quickplay you'll need to use the Unlock All option in the mod menu

On the ps3 build the original songs are still in the songlist.q or the game will crash when loading a save
Xbox has them removed