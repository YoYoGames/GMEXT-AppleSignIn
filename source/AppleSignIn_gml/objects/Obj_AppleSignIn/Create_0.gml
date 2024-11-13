

event_inherited()

text = "Sign In"
appleSignInState = 0;

AppleSignIn_Init()
AppleSignIn_GetCredentialState("")//Apple "identitiyToken"

AppleSignIn_AddScope(applesignin_scope_fullname);
AppleSignIn_AddScope(applesignin_scope_email);
