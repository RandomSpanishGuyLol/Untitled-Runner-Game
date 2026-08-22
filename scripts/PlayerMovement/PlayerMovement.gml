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

function PlayerMovement()
{
    var moving = false;
    var step_x;

    // --- HORIZONTAL MOVEMENT WITH COLLISION ---
    if (keyboard_check(vk_left))
    {
        step_x = -move_speed;
        // move step by step to avoid clipping through walls
        for (var i = 0; i < abs(step_x); i++)
        {
            if (!CollisionCheck(x + sign(step_x), y))
            {
                x += sign(step_x);
            }
            else break; // hit a wall
        }

        sprite_index = PlayerLeftTest;
        moving = true;
    }

    if (keyboard_check(vk_right))
    {
        step_x = move_speed;
        for (var i = 0; i < abs(step_x); i++)
        {
            if (!CollisionCheck(x + sign(step_x), y))
            {
                x += sign(step_x);
            }
            else break;
        }

        sprite_index = PlayerRightTest;
        moving = true;
    }

    // --- IDLE SPRITE ---
    if (!moving)
    {
        sprite_index = PlayerSpriteTest;
    }
}

