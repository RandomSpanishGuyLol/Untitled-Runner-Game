import os
import json
import shutil

rooms_root = "rooms/"
out_folder = "room_data_jsons/"

if os.path.exists(out_folder):
    shutil.rmtree(out_folder)
os.makedirs(out_folder)

raw_room_data = {}

for f in os.listdir(rooms_root):
    file_path = f"{rooms_root}{f}/{f}.yy"

    with open(file_path, 'r', encoding='utf-8') as file:
        text = file.read()

        # Remove trailing comma
        text = text.replace("\n", "")

        while True:
            new_text = text.replace(", ", ",")
            if new_text == text:
                break
            text = new_text

        text = text.replace(",}", "}")
        text = text.replace(",]", "]")

        #text = text.replace(",},", "},")
        #text = text.replace("},\n  ]", "}\n  ]")
        #text = text.replace("},\n      ]", "}\n      ]")
        #text = text.replace(",\n  }", "\n  }")
        #text = text.replace(",\n}", "\n}")

        data = json.loads(text)

        instances = data["layers"]
        instances = [layer for layer in instances if layer["%Name"] == "Instances"]
        print(f"{f}: {len(instances[0]["instances"]) if instances else 0} objects")

    with open(os.path.join(out_folder, f + ".json"), 'w') as file:
        json.dump(data, file, indent=4)

    raw_room_data[f] = data

output = "function scr_room_data() {\nglobal.chunks =  {\n normal: [\n"

def add_rooms(out, room_keyword, room_type, is_last=False):
    rooms = {room_name: raw_room_data[room_name] for room_name in raw_room_data.keys() if room_name.startswith(room_keyword)}

    for room_name, room_data in rooms.items():
        out += "  {\n"
        out += f"    name: {room_name},\n"

        out += "   shape: [\n"

        instances = room_data["layers"]
        instances = [layer for layer in instances if layer["%Name"] == "Instances"]
        instances = instances[0]["instances"] if instances else []

        for instance in instances:
            out += "    {\n"
            out += f"      object: {instance['objectId']['name']},\n"
            out += f"      x: {instance['x']},\n"
            out += f"      y: {instance['y']},\n"
            out += f"      rotation: {instance['rotation']},\n"
            out += "    },\n"

        out += "   ]\n"

        if is_last:
            out += "   }\n\n"
        else:
            out += "   },\n\n"

normal_rooms = {room_name: raw_room_data[room_name] for room_name in raw_room_data.keys() if room_name.startswith("NormalRoom")}
special_rooms = {room_name: raw_room_data[room_name] for room_name in raw_room_data.keys() if room_name.startswith("SafeRoom")}
    
add_rooms(output, "NormalRoom", "normal")
add_rooms(output, "WaterRoom", "water")
add_rooms(output, "LockerRoom", "locker")
add_rooms(output, "SafeRoom", "special", is_last=True)

output += "\n]\n}\n}"

script_name = "scr_room_data"
out_path = f"scripts/{script_name}/{script_name}.gml"

with open(out_path, 'w') as file:
    file.write(output)

print()

print(f"Room data script updated")
print(out_path)

input("Press Enter to exit...")