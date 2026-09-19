if dead {
	if deadTimer == 18 {
		sprite_index = TheScorcherSpriteDeadLol
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


if !gotcha {
moveDir = 0

if obj_player.is_in_locker {
	moveDir = 0
}
else if (abs(obj_player.x - x) > 50) {
	moveDir = sign(obj_player.x - x)
}

if moveDir == 1 {
sprite_index = TheScorcherSpriteRight
}
else if moveDir == -1 {
	sprite_index = TheScorcherSpriteLeft
}
else {
	sprite_index = TheScorcherSprite
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

// If the player falls off the bottom, jump back to the start (for testing)
if (y > 2000) { //2000) {
    instance_destroy()
}

if point_distance(obj_player.x, obj_player.y, x, y) <= 100 and !obj_player.burning {
	gotcha = true
	obj_player.burning = true
	sprite_index = TheScorcherSpriteFlame
	
	audio_play_sound(soundreality_blazing_fire_394355, 2, true, 0.5)
}
}
else 
{
	x = obj_player.x
	y = obj_player.y - 200
	
	if !obj_player.burning {
		dead = true
	}
}