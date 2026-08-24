// Inside obj_door_trigger -> Collision with obj_player
if (!instance_exists(obj_entrance_marker)) { // Prevent double-triggering
    
    // 1. Tell the manager to build the NEXT room hidden in the distance
	if (should_generate_chunk) {
		should_generate_chunk = false
		with(obj_room_manager) {
			event_user(0); 
		}
		
		if (obj_room_manager.ROOM_GEN_HISTORY[set_room_index].name == "SafeRoom") {
			audio_play_sound(mus_hamster_DumSpiroSpero, 1, true, 0.6, 0, 0.8)
			audio_stop_sound(mus_where_6)
	
	        obj_timemanager.timer_is_running = false
			obj_timemanager.remaining_time = 3 * 60 * 60
		}
	}
	
	obj_room_manager.player_room_index = set_room_index

    // instance_destroy(); // Get rid of the old door
}

