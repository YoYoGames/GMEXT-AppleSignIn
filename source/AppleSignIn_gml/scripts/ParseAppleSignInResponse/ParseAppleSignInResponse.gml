function ParseAppleSignInResponse(appleSignInResponse)
{
	if(appleSignInResponse == "")
		exit
	
	var jsonMap = json_decode(appleSignInResponse);
	if(!ds_exists(jsonMap,ds_type_map))
		exit
	
	if(jsonMap[? "success"])
	{
		show_debug_message("Apple Sign In Succeeded");
		var userId = jsonMap[? "userIdentifier"];
		var identityToken = jsonMap[? "identityToken"];
		var authCode = jsonMap[? "authCode"];
		var realUser = jsonMap[? "realUserStatus"];
			
		show_debug_message("User: " + string(userId) + " | " + string(identityToken) + " | " + string(authCode) + " | " + string(realUser) );
			
		appleSignInState = applesignin_state_authorized;
		
	}
	else
	{
		show_debug_message("Apple Sign In Failed");
		appleSignInState = 0;
	}
		
	ds_map_destroy(jsonMap);
}
