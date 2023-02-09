In order to sign the apple sign in dylib correctly:

1. Build the project: 
    xcodebuild project=AppleSignInMacLip.xcodeproj/

1b. Verify the result of the build, at the time of writing this is created in maciapextension/build/Release/libAppleSignInMacLib.dylib

*** MAC APP STORE ADDITIONAL STEPS ***

2. Codesign the result with the entitlements file
*******************************************************************************************************************************************************************
If any customer wants to rebuild this lib, they'll need to use their own "Mac Developer" or other suitable keypair to sign this lib with the correct entitlements.
Otherwise, all binaries will be resigned by the mac app store. 
*******************************************************************************************************************************************************************
    codesign -f -s "Mac Developer: developer@company.com" libAppleSignInMacLib.dylib --entitlements ../../AppleSignInMacLib/signin.entitlements

