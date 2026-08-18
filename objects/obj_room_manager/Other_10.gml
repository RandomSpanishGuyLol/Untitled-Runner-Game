randomize();
var chunk = global.chunks.normal[irandom(array_length(global.chunks)-1)];

if (array_length(ROOM_GEN_HISTORY) % 50 == 0) {
	chunk = global.chunks.special[0]
}

var shape = chunk.shape;

var local_ent_y = 0;
var new_exit_y = 0; // Default to current height if X isn't found

var pattern = "▣▤▤⛋▣"; // The vertical signature
for (var r = 0; r < array_length(shape) - 4; r++) {
    var check = string_char_at(shape[r], 1) +
        string_char_at(shape[r+1], 1) +
        string_char_at(shape[r+2], 1) +
        string_char_at(shape[r+3], 1) +
        string_char_at(shape[r+4], 1);
    if (check == pattern) {
        local_ent_y = r - 1 
        break
    }
}

last_room = ROOM_GEN_HISTORY[array_length(ROOM_GEN_HISTORY)-1]
last_room_end_x = last_room[1] + last_room[2]
last_room_exit_y = last_room[3]

var chunk_blocks = []

// 4. SPAWN LOOP
for (var r = 0; r < array_length(shape); r++) {
    var line = shape[r];
    for (var c = 1; c <= string_length(line); c++) {
        var char = string_char_at(line, c);
        var xx = last_room_end_x + ((c - 1) * 100);
        var yy = last_room_exit_y - 400 - (local_ent_y * 100) + (r * 100)

        var obj = -1;
        switch(char) {
			case "▣": obj = obj_block2; break;
			case "◪": obj = obj_slope1; break;
			case "⬕": obj = obj_slope2; break;
			case "◤": obj = obj_slope3; break;
			case "◥": obj = obj_slope4; break;
			case "⚿": 
				var new_inst = instance_create_layer(xx, yy, "Instances", obj_door_trigger);
				new_index = array_length(ROOM_GEN_HISTORY)
				new_inst.set_room_index = new_index
				array_push(chunk_blocks, new_inst)
				break;
			case "⛋":
				obj = -1; // Don't spawn anything
				break;
			case "E":
				var new_inst = instance_create_layer(xx, yy, "Instances", obj_exit_marker);
				new_index = array_length(ROOM_GEN_HISTORY)
				new_inst.set_room_index = new_index
				array_push(chunk_blocks, new_inst)
				
				new_exit_y = yy;
				break;
        }
		
		if (obj != -1) {
		    var new_inst = instance_create_layer(xx, yy, "Instances", obj);
		    array_push(chunk_blocks, new_inst)
		    }
		}
}

generated_room_width = string_length(shape[0]) * 100

room_data = [chunk_blocks, last_room_end_x, generated_room_width, new_exit_y]

array_push(ROOM_GEN_HISTORY, room_data)

// if (array_length(ROOM_GEN_HISTORY) > 5) {
	//var earliest_room = ROOM_GEN_HISTORY[0]
	//for (var b = 0; b < array_length(earliest_room); b++) {
	//	with (earliest_room[b]) {
	//		instance_destroy()
	//	}
	//}
//}
