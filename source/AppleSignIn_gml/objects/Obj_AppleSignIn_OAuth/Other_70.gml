/// @description Insert description here
// You can write your code in this editor

if (async_load[? "type"] == "apple_signin_login_oauth") {
	
	nonce = async_load[? "nonce"];
	client_id = async_load[? "client_id"];
	redirect_uri = async_load[? "redirect_uri"];
	
	// At this point the OAuth happened within the server
	// we need to query the token from the server now.
	alarm[0] = game_get_speed(gamespeed_fps);
}