extends Node

@warning_ignore("unused_signal")
signal game_lost(reason)
#emited lose_game_zone , 


@warning_ignore("unused_signal")
signal game_won
#emited: target_zone


@warning_ignore("unused_signal")
signal activate_delete_areas(value)
#emited: level_interface


signal set_current_level(level_number)
#emited: start_level_button


signal activate_impulse_areas(value)
#emited: level_interface
