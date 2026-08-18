// Inside obj_door_trigger -> Collision with obj_player
if (!instance_exists(obj_entrance_marker)) { // Prevent double-triggering
    
    // 1. Tell the manager to build the NEXT room hidden in the distance
	if (should_generate_chunk) {
		should_generate_chunk = false
		with(obj_room_manager) {
			event_user(0); 
		}
	}
	
	obj_room_manager.player_room_index = set_room_index

    // instance_destroy(); // Get rid of the old door
}

