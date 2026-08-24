if (abs(obj_player.x - x) > 50) {
	x += sign(obj_player.x - x)
}

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

// If the player falls off the bottom, jump back to the start (for testing)
if (y > 999999999999) { //2000) {
    instance_destroy()
}