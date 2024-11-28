
if(os_type == os_ios or os_browser != browser_not_a_browser)
{	
	AppleSignIn_ClearScopes()

	AppleSignIn_AddScope(applesignin_scope_fullname);
	AppleSignIn_AddScope(applesignin_scope_email);

	AppleSignIn_AuthoriseUser();
}
else
{
	//OAuth for other platforms!
	instance_create_depth(0,0,0,Obj_AppleSignIn_OAuth)
}

