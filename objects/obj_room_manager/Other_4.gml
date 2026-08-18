// 1. Force the window size
var camera_width = 1920;
var camera_height = 1080; 
var w = 1200;
var h = 720;
window_set_size(w, h);

// 2. Resize the game drawing surface to match (Fixes stretching)
surface_resize(application_surface, w, h);

// 3. Set the camera to see that exact same size
camera_set_view_size(view_camera[0], camera_width, camera_height)