spif (is_in_locker) {
	visible = true;
	is_in_locker = false;
	
	yspd -= 30
	xspd += (keyboard_check(vk_right) - keyboard_check(vk_left)) * 30
}
else {
	var closest_locker = instance_nearest(x, y, obj_locker);
	var dist = point_distance(x, y, closest_locker.x, closest_locker.y)

	if (dist <= 400) {
		show_debug_message(closest_locker);

		if (closest_locker != noone)
		{
		    x = closest_locker.x + 50;
		    y = closest_locker.y + 250;
			

		    visible = false;
			is_in_locker = true;
		}
	}
}