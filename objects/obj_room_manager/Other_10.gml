randomize();

var random_index = irandom(array_length(global.chunks.normal) - 1)
var chunk = global.chunks.normal[random_index];

if (array_length(ROOM_GEN_HISTORY) % 50 == 0 or array_length(ROOM_GEN_HISTORY) == 5) {
    chunk = global.chunks.special[0];

    // Massacre all the enemies
    with (TheLurkerObj) {
        instance_destroy();
    }

    with (TheScorcherObject) {
        instance_destroy();
    }
}

show_debug_message(chunk.name)

var shape = chunk.shape;

// Find the entrance Y position in the new instance list
var local_ent_y = 0;

for (var i = 0; i < array_length(shape); i++) {
    var data = shape[i];

    // Entrance is represented by obj_entrance / ⛋ in the generated data.
    // Change this object name if your actual entrance object has a different name.
    if (data.object == obj_entrance_marker) {
        local_ent_y = data.y;
        break;
    }
}


last_room = ROOM_GEN_HISTORY[array_length(ROOM_GEN_HISTORY) - 1];
last_room_end_x = last_room.end_x + last_room.width;
last_room_exit_y = last_room.exit_y;

var chunk_blocks = [];

var entrance_pos = [0, 0];
var new_exit_y = last_room_exit_y;


// Find maximum X for room width
var max_x = 0;


// SPAWN LOOP
for (var i = 0; i < array_length(shape); i++) {
    var data = shape[i];

    var xx = last_room_end_x + data.x;

    // Same vertical alignment system as the old room manager.
    // The entrance is placed at the same height as the previous room's exit.
    var yy = data.y + last_room_exit_y - local_ent_y - 200;

    var obj = data.object;
    var new_inst = noone;


    // ---------------------------------------------------------
    // ENTRANCE
    // ---------------------------------------------------------
    if (obj == obj_entrance_marker) {
        entrance_pos = [xx, yy];
        obj = -1;
    }


    // ---------------------------------------------------------
    // EXIT
    // ---------------------------------------------------------
    else if (obj == obj_exit_marker) {
        new_inst = instance_create_layer(
            xx,
            yy,
            "Instances",
            obj_exit_marker
        );

        new_index = array_length(ROOM_GEN_HISTORY) + 1;
        new_inst.set_room_index = new_index;

        array_push(chunk_blocks, new_inst);

        new_exit_y = yy + 200;

        obj = -1;
    }


    // ---------------------------------------------------------
    // DOOR TRIGGER
    // ---------------------------------------------------------
    else if (obj == obj_door_trigger) {
        new_inst = instance_create_layer(
            xx,
            yy,
            "Instances",
            obj_door_trigger
        );

        new_index = array_length(ROOM_GEN_HISTORY);
        new_inst.set_room_index = new_index;

        array_push(chunk_blocks, new_inst);

        obj = -1;
    }


    // ---------------------------------------------------------
    // ENEMY
    // ---------------------------------------------------------
    else if (obj == obj_enemy_marker) {
        var already_spawned_enemy = false;

        with (TheScorcherObject) {
            already_spawned_enemy = true;
        }

        with (TheLurkerObj) {
            already_spawned_enemy = true;
        }

        if (!already_spawned_enemy) {
            randomize();

            var enemy_i = random(100);

            show_debug_message("Spawned enemy");
            show_debug_message(enemy_i);

            if (enemy_i <= 50) {
                obj = TheScorcherObject;
            }
            else {
                obj = -1;
            }
        }
        else {
            obj = -1;
        }
    }


    // ---------------------------------------------------------
    // NORMAL OBJECT
    // ---------------------------------------------------------
    if (obj != -1) {
        new_inst = instance_create_layer(
            xx,
            yy,
            "Instances",
            obj
        );
		
		new_inst.image_angle = data.rotation

        array_push(chunk_blocks, new_inst);
    }


    // Track room width
    if (data.x > max_x) {
        max_x = data.x;
    }
}


// Room width
generated_room_width = max_x + 100;


// ---------------------------------------------------------
// SPAWN LURKER
// ---------------------------------------------------------

if (array_length(ROOM_GEN_HISTORY) > 2) {
    randomize();

    var enemy_i = random(100);

    if (enemy_i < 50) {
        previous_room = ROOM_GEN_HISTORY[array_length(ROOM_GEN_HISTORY) - 2];

        var xx = previous_room.entrance_pos[0];
        var yy = previous_room.entrance_pos[1];

        instance_create_layer(
            xx,
            yy,
            "Instances",
            TheLurkerObj
        );

        show_debug_message("it is coming.... viene");
    }
}


// ---------------------------------------------------------
// SAVE ROOM DATA
// ---------------------------------------------------------

room_data = {
    id: array_length(ROOM_GEN_HISTORY),
    name: chunk.name,
    chunk_blocks: chunk_blocks,
    end_x: last_room_end_x,
    width: generated_room_width,
    exit_y: new_exit_y,
    entrance_pos: entrance_pos
};

array_push(ROOM_GEN_HISTORY, room_data);


// ---------------------------------------------------------
// DELETE OLD ROOMS
// ---------------------------------------------------------

if (array_length(ROOM_GEN_HISTORY) > 5) {
    var earliest_room = ROOM_GEN_HISTORY[0];

    for (var b = 0; b < array_length(earliest_room.chunk_blocks); b++) {
        with (earliest_room.chunk_blocks[b]) {
            instance_destroy();
        }
    }
}