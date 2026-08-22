var cam = view_camera[0];
var camera_speed = 0.1
var cur_x = camera_get_view_x(cam);
var cur_y = camera_get_view_y(cam);

var current_room = obj_room_manager.ROOM_GEN_HISTORY[obj_room_manager.player_room_index]

var target_x = clamp(obj_player.x, 0, current_room.end_x)
var target_y = obj_player.y-800
var new_x = lerp(cur_x, target_x, camera_speed)
var new_y = lerp(cur_y, target_y, camera_speed)

camera_set_view_pos(cam, new_x, new_y);

