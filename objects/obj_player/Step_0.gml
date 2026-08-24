function CollisionCheck(cx, cy) {
	if (place_meeting(cx, cy, obj_block2)) {
		return true
	}
	if (place_meeting(cx, cy, obj_slope1) or place_meeting(cx, cy, obj_slope2) or place_meeting(cx, cy, obj_slope3) or place_meeting(cx, cy, obj_slope4)) {
		return true
	}
	if (place_meeting(cx, cy, obj_saferoomdoor)) {
		return true
	}
	return false
}

if (!is_in_locker) {
	// Horizontal movement
	PlayerMovement();

	// Gravity + vertical collision
	vsp += grav;

	if (place_meeting(x, y + vsp, obj_block2))
	{
	    while (!CollisionCheck(x, y  + sign(vsp)))
	    {
	        y += sign(vsp);
	    }
	    vsp = 0;
	}

	y += vsp;

	// Jumping
	if (keyboard_check_pressed(vk_space))
	{
	    if (CollisionCheck(x, y + 1))
	    {
	        vsp = jump;
	    }
	}

	if (keyboard_check(vk_shift)) 
	{
	    move_speed = 16;
	} 
	else 
	{
	    move_speed = 4;
	}
	image_speed = move_speed / 16

	// If the player falls off the bottom, jump back to the start (for testing)
	if (y > 999999999999) { //2000) {
	    x = 100;
	    y = 100;
	    vspeed = 0;
	}
}