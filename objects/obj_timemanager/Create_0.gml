timer_is_running = false
remaining_time = 3 * 60 * 60

ui_pos_x = 500
ui_pos_x_offset = 10
ui_pos_y_offset = 20+40
ui_pos_y = 0

timer_bg = instance_create_layer(ui_pos_x, 0, "UILayer_1", obj_timerbg)

digit1 = instance_create_layer(ui_pos_x + ui_pos_x_offset, ui_pos_y_offset, "UILayer_1", obj_timerdigit)
digit2 = instance_create_layer(ui_pos_x + ui_pos_x_offset + 24, ui_pos_y_offset, "UILayer_1", obj_timerdigit)
digit3 = instance_create_layer(ui_pos_x + ui_pos_x_offset + 57, ui_pos_y_offset, "UILayer_1", obj_timerdigit)
digit4 = instance_create_layer(ui_pos_x + ui_pos_x_offset + 82, ui_pos_y_offset, "UILayer_1", obj_timerdigit)