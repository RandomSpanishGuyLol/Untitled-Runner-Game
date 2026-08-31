function AllCollisionCheck(cx, cy) {
	var collidable = [obj_block2, obj_slope1, obj_slope2, obj_slope3, obj_slope4, obj_saferoomdoor]
	
	for (i=0; i<array_length(collidable); i++) {
		if place_meeting(cx, cy, collidable[i]) {
			return true
		}
	}
	
	return false
}

rightKey = keyboard_check(vk_right);
leftKey = keyboard_check(vk_left);
jumpKeyPressed = keyboard_check_pressed(vk_space)
shiftPressed = 1 + keyboard_check(vk_shift) * 1.5;

moveDir = rightKey - leftKey

if high_priority_anim_timer == 0 {
if moveDir == 1 {
sprite_index = PlayerRightTest
}
else if moveDir == -1 {
	sprite_index = PlayerLeftTest
}
else {
	sprite_index = PlayerSpriteTest
}
}
else {
	high_priority_anim_timer -= 1
}

smoothCof = 0.9
bounceFac = -0.1

// if abs(xspd) < maxSpeed {
	// var signed = sign(xspd)
	xspd = xspd * smoothCof + (moveDir * moveSpd) * shiftPressed * (1-smoothCof)
//}

var subPixel = .5;

var collidable = [obj_block2, obj_slope1, obj_slope2, obj_slope3, obj_slope4, obj_saferoomdoor]

if (!is_in_locker) {
	for (i=0; i<array_length(collidable); i++) {
		if place_meeting(x + xspd, y, collidable[i]) {
			// Check if there is a slope
			if (!AllCollisionCheck(x + xspd, y - abs(xspd) - 1)) {
				show_debug_message("la ladera")
				while (AllCollisionCheck(x + xspd, y)) {
					show_debug_message("asdasdasd")
				    y -= subPixel
				}
				
				break
			}
			// If there's no slope, regular collision
			else 
			{
				var pixelCheck = subPixel * sign(xspd)
				while (!AllCollisionCheck(x + pixelCheck, y)) {
					x += pixelCheck
				}
		
				xspd = 0
				break
			}
		}
	}
	
	x += xspd
}

yspd += grav

if jumpKeyPressed && AllCollisionCheck(x, y+16) && !is_in_locker {
	yspd = jspd
}

if (!is_in_locker) {
	var subPixel = .5;
	for (i=0; i<array_length(collidable); i++)
	{
		if place_meeting(x, y + yspd, collidable[i]) {
			var pixelCheck = subPixel * sign(yspd)
			while (!AllCollisionCheck(x, y+pixelCheck)) {
				y += pixelCheck
			}
		
			yspd = yspd * bounceFac
			break
		}
	}
	
	y += yspd
}

