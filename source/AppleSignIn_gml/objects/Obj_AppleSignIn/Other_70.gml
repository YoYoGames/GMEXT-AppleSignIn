
switch(async_load[?"id"])
{
	case mac_applesignin_signin_response:
	case applesignin_signin_response:
		
		var responseJson = async_load[?"response_json"];
		if(responseJson != "")
			ParseAppleSignInResponse(responseJson);
		
	break;
	
	case mac_applesignin_credential_response:
	case applesignin_credential_response:
		
		var responseJson = async_load[?"response_json"];
		if(responseJson != "")
			ParseAppleCredentialResponse(responseJson);
		
	break
}
