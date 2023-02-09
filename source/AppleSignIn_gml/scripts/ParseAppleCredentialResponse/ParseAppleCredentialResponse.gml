function ParseAppleCredentialResponse(responseJson)
{
	var jsonMap = json_decode(responseJson);
	if(!ds_exists(jsonMap,ds_type_map))
		exit
	
	var state = jsonMap[? "state"];
	
	global.appleSignInState = state;
	
	switch (state)
	{
		case applesignin_state_authorized:
			show_debug_message("Authorized!");
			break;
		case applesignin_state_revoked:
			show_debug_message("Revoked");
			break;
		case applesignin_state_not_found:
			show_debug_message("Not found");
			break;
	}
	
	ds_map_destroy(jsonMap);
}
