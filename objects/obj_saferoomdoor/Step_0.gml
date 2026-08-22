var dist = ((obj_player.x - x) ^ 2 + (obj_player.y - y) ^ 2) ^ 0.5

if (dist <= 50) {
	time_to_open -= 1
	
	if (time_to_open == 0) {
		instance_destroy()
	}
}