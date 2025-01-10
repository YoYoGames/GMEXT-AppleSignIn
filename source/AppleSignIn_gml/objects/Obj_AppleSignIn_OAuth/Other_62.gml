
if (async_load[?"status"] != 0)
	exit;

if (search_request == async_load[?"id"])
{
	// This is always a json encoded string
	var _data = json_parse(async_load[?"result"])
	
	if (struct_exists(_data, "errorCode"))
	{
		if (--search_tries > 0) {
			alarm[0] = game_get_speed(gamespeed_fps);
		}
		else {
			var _map = ds_map_create();
			_map[? "id"] = applesignin_signin_response;
			_map[? "success"] = false;
			event_perform_async(ev_async_social, _map);
			instance_destroy();
		}
		return;
	}
	
	var map = ds_map_create()
	
	var _struct = {
		success: true,
		identityToken: _data.id_token,
		nonce: nonce
	}
	
	var _map = ds_map_create();
	_map[? "id"] = applesignin_signin_response;
	_map[? "response_json"] = json_stringify(_struct)
	_map[? "success"] = true;
	event_perform_async(ev_async_social, _map);
	instance_destroy();
}
