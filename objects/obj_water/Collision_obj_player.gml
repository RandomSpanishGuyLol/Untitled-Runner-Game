if obj_player.burning {
	obj_player.burning = false
	
	audio_stop_sound(soundreality_blazing_fire_394355)
	audio_play_sound(universfield_water_splash_02_352021, 2, false)
}