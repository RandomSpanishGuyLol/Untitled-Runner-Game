high_priority_anim_timer = 20

sprite_index = PlayerSpritePunch
image_index = 1

with (TheScorcherObject) {
	if point_distance(obj_player.x, obj_player.y, x, y) <= 400 {
		self.dead = true
	}
}

with (TheLurkerObj) {
	if point_distance(obj_player.x, obj_player.y, x, y) <= 400 {
		self.dead = true
	}
}