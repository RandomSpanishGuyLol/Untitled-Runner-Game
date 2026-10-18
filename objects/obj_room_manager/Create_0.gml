// Run the script once to "load" the global.chunks data
randomize();
scr_room_data(); 

player_room_index = 0
ROOM_GEN_HISTORY = [{name: "StartingRoom", chunk_blocks: [], end_x: 0, width: 1500, exit_y: 800}];

lurker_spawned = false
rooms_since_lurker_spawn = 0

water_room_cooldown = 0