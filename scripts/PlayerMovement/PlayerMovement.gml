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
            if (!place_meeting(x + sign(step_x), y, obj_block2))
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
            if (!place_meeting(x + sign(step_x), y, obj_block2))
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

