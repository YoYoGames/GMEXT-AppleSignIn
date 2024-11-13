
show_debug_message(json_encode(async_load))

switch(async_load[?"id"])
{
	case applesignin_signin_response:
	
		show_debug_message("applesignin_signin_response")
		
		var responseJson = async_load[?"response_json"];
		if(responseJson != "")
			ParseAppleSignInResponse(responseJson);
		
	break;
	
	case applesignin_credential_response:
	
		show_debug_message("applesignin_credential_response")
		
		var responseJson = async_load[?"response_json"];
		if(responseJson != "")
			ParseAppleCredentialResponse(responseJson);
		
	break
}
