if (timer_is_running) {
    remaining_time -= 1;
	if obj_player.burning {
		remaining_time -= 1;
	}
	
	if remaining_time <= 0 {
		timer_is_running = false
		var explosion = instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_gameoverexplosion)
		game_over_timer = 16
		
		audio_play_sound(dragon_studio_loud_explosion_425457, 2, false, 0.5)
	}
}

if game_over_timer > 0 {
	game_over_timer -= 1
	
	if game_over_timer == 0 {
		room_restart()
	}
}

var minutes = floor(remaining_time / 3600);
var seconds = floor((remaining_time mod 3600) / 60);

// Split minutes into two digits
var minute_tens = floor(minutes / 10);
var minute_ones = minutes mod 10;

// Split seconds into two digits
var second_tens = floor(seconds / 10);
var second_ones = seconds mod 10;

// Set the sprite frames
digit1.image_index = minute_tens;
digit2.image_index = minute_ones;
digit3.image_index = second_tens;
digit4.image_index = second_ones;