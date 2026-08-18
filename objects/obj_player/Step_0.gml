sp// Horizontal movement
PlayerMovement();

// Gravity + vertical collision
vsp += grav;

if (place_meeting(x, y + vsp, obj_block2))
{
    while (!place_meeting(x, y + sign(vsp), obj_block2))
    {
        y += sign(vsp);
    }
    vsp = 0;
}

y += vsp;

// Jumping
if (keyboard_check_pressed(vk_space))
{
    if (place_meeting(x, y + 1, obj_block2))
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