exit;

var minutes = floor(remaining_time / 3600)
var seconds = floor((remaining_time - minutes * 60 * 60) / 60)
var milliseconds = remaining_time - minutes * 60 * 60 - seconds * 60

seconds = string(seconds)
if (string_length(seconds) < 2) {
	seconds = "0" + seconds
}

var timer_text = string(minutes) + ":" + string(seconds) + "." + string(milliseconds)

draw_set_font(fnt_TimerFont)
draw_text(960, 0, timer_text)