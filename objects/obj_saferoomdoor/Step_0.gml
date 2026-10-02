var dist = point_distance(obj_player.x, obj_player.y, x, y)

if (dist <= 400) {
	time_to_open -= 1
	
	if (time_to_open == 0) {
		instance_destroy()
		
		obj_timemanager.timer_is_running = true
		
		audio_stop_sound(mus_hamster_DumSpiroSpero)
		audio_play_sound(mus_where_6, 1, false)
	}
}