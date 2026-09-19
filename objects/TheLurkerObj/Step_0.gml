if dead {
	if deadTimer == 20 {
		sprite_index = TheLurkerSprDead
		deadTimer -= 1
	}
	else if deadTimer == 0 {
		instance_destroy()
	}
	else {
	deadTimer -= 1
	}
	exit
}

if moveDir > 0 {
	sprite_index = TheLurkerSprRight
}
else if moveDir < 0 {
	sprite_index = TheLurkerSprLeft
}

function AllCollisionCheck(cx, cy) {
	var collidable = [obj_block2, obj_slope1, obj_slope2, obj_slope3, obj_slope4, obj_saferoomdoor]
	
	for (i=0; i<array_length(collidable); i++) {
		if place_meeting(cx, cy, collidable[i]) {
			return true
		}
	}
	
	return false
}

xspd = moveDir * moveSpd

var subPixel = .5;

var collidable = [obj_block2, obj_slope1, obj_slope2, obj_slope3, obj_slope4, obj_saferoomdoor]

for (i=0; i<array_length(collidable); i++) {
	if place_meeting(x + xspd, y, collidable[i]) {
		// Check if there is a slope
		if (!AllCollisionCheck(x + xspd, y - abs(xspd) - 1)) {

			while (AllCollisionCheck(x + xspd, y)) {
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

yspd += grav

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


// Check if gotcha

if (point_distance(obj_player.x, obj_player.y, x, y) < 150 and !obj_player.is_in_locker) {
	camera = view_camera[0]
	var cur_x = camera_get_view_x(camera);
	var cur_y = camera_get_view_y(camera);
	instance_create_layer(cur_x, cur_y, "VisualEffects", obj_darkscreen)
	obj_timemanager.remaining_time -= round(0.5 * 60 * 60)
	
	audio_play_sound(snd_TheLurkerGotchaSound, 2, false)
	
	instance_destroy()
}


// If the player falls off the bottom, jump back to the start (for testing)
if (y > 5000) { //
    instance_destroy()
}

if (obj_player.x - x > 60 * 100) {
	instance_destroy()
}