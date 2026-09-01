high_priority_anim_timer = 20

if last_direction >= 0 {
sprite_index = PlayerSpritePunch
}
else {
sprite_index = PlayerSpritePunchLeft
}
image_index = 1

with (TheScorcherObject) {
	if point_distance(obj_player.x, obj_player.y, x, y) <= 300 {
		self.dead = true
	}
}

with (TheLurkerObj) {
	if point_distance(obj_player.x, obj_player.y, x, y) <= 300 {
		self.dead = true
	}
}