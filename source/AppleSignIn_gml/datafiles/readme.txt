########### MAC OS NOTES ###########

NOTE1:	If you require AppleSignIn functionality in a Mac App Store build of your game, then replace libAppleSignInMacLib.dylib with the App Store variant. 
	Make sure the lib is called libAppleSignInMacLib.dylib, to ensure GameMaker extension function mapping persists.

NOTE2: 	If used on VM this a provisioning profile needs to be added to the "included files". Check the manual for more details.