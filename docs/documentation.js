// FUNCTIONS

/**
 * @func AppleSignIn_Init
 * @desc This function will initialise the Apple Sign In API and **is called automatically by the extension**. As such, you should not be using it ever in your game code as it is not required.
 * @func_end
 */
function AppleSignIn_Init() {}

/**
 * @func Mac_AppleSignIn_Final
 * @desc This function will finalise the Apple Sign In API on macOS and **is called automatically by the extension**. As such, you should not be using it ever in your game code as it is not required.
 * @func_end
 */
function Mac_AppleSignIn_Final() {}

/**
 * @func AppleSignIn_GetCredentialState
 * @desc With this function you can retrieve the credential sign in state for your game. You supply the identity token string for the session (which is returned as part of the callback when you use the function ${function.AppleSignIn_AuthoriseUser} / Mac_AppleSignIn_AuthoriseUser()) and the function will trigger an Asynchronous System Event where the [`async_load`](https://manual.yoyogames.com/GameMaker_Language/GML_Overview/Variables/Builtin_Global_Variables/async_load.htm) DS map **"id"** key will be {constant.applesignin_credential_response}. The async_load map will then have a further key "response_json", which will hold a JSON string which can be parsed into a DS map using the function [`json_decode()`](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/File_Handling/Encoding_And_Hashing/json_decode.htm). This map will have the key **"status"**, which will be one of the {constant.applesignin} constants.
 * @func_end
 */
function AppleSignIn_GetCredentialState() {}

/**
 * @func AppleSignIn_AddScope
 * @desc This function can be used to add a scope for the sign in request to request additional pieces of user data. The additional data you can request are for an email address and the user's full name, and these are requested using the following constants:
 * @func_end
 */
function AppleSignIn_AddScope() {}

/**
 * @func RegisterCallbacks
 * @desc This is an internal function for **macOS only**. This function should never be called in your code, and you should not edit or change anything about it otherwise the extension may no longer work.
 * @func_end
 */
function RegisterCallbacks() {}

/**
 * @func Mac_AppleSignIn_RegisterWindow
 * @desc This **macOS only** function must be used before calling any other function to register the game window for authorisation UI overlays.
 * @example The following code example would go in the Step event of a button object to check for a user wanting to sign in using the Apple Sign In API:
 * ```gml
 * if mouse_check_button_pressed(mb_left)
{
if instance_position(mouse_x, mouse_y, id)
    {
         Mac_AppleSignIn_RegisterWindow();
         Mac_AppleSignIn_AddScope(applesignin_scope_fullname);
         Mac_AppleSignIn_AddScope(applesignin_scope_email);
         Mac_AppleSignIn_AuthoriseUser();
    }
 }

 * ```
 * @func_end
 */
function Mac_AppleSignIn_RegisterWindow() {}

// CONSTANTS

/** 
 * @const applesignin_scope
 * @desc These constants specify the achievement state.
 * @member applesignin_scope_fullname Requests the user's full name.
 * @member applesignin_scope_email Requests the user's e-mail address.
 * @const_end
 */

/** 
 * @const applesignin_event_id
 * @desc These constants specify the achievement state.
 * @member applesignin_signin_response Requests the user's full name.
 * @member applesignin_credential_response Requests the user's e-mail address.
 * @const_end
 */

/** 
 * @const applesignin_realuserstatus
 * @desc These constants specify the achievement state.
 * @member applesignin_realuserstatus_likelyreal The user is likely a real person.
 * @member applesignin_realuserstatus_unknown The system hasn't determined whether the user might be a real person.
 * @member applesignin_realuserstatus_unsupported This indicates that the IAP product ID has already been added to the internal product list.
 * @const_end
 */

/** 
 * @const applesignin_state
 * @desc These constants specify the achievement state.
 * @member applesignin_state_authorized The user has been authorized and has a valid session.
 * @member applesignin_state_revoked The user's credentials have been revoked and the session terminated
 * @member applesignin_state_not_found The user does not appear to have a session with your app
 * @const_end
 */

// MODULES

/** 
 * @module home
 * @title Home
 * @desc This PDF manual is designed for you to use as a reference to the different Apple Sign In extension functions for iOS, tvOS and macOS, and as such does not contain a tutorial on how to set up the API in your games. We recommend that before doing anything with this extension, you take a moment to look over the official Apple Sign In API documentation, as it will familiarise you with many of the terms and concepts required to use the extension correctly:
 * * [Apple Developer: Sign In With Apple](https://developer.apple.com/sign-in-with-apple/get-started/)
 * 
 * Note that this manual covers *both* the macOS and iOS/tvOS Sign In functions, as they **work exactly the same way and have only been separated into two extensions so that you can use one or the other or both as required**. This means that you may need to do certain checks using the [`os_type`](https://manual-en.yoyogames.com/GameMaker_Language/GML_Reference/OS_And_Compiler/os_type.htm) variable to call the correct function for the current platform the game is running on, but the bulk of the code will be the same regardless. The examples in this manual are based on the iOS/tvOS functions and constants, so for macOS you would simply swap (or duplicate, if developing for both platforms) the function/constant names for the macOS versions and the Sign In functionality should work exactly the same.
 * @section General
 * @ref page.async_system_event
 * @ref module.general
 * @section_end
 * @module_end
 */

/**
 * @module general
 * @title General
 * @desc The rest of this manual contains a reference guide to all the functions used by the Apple Sign In
Extension, along with any constants that they may use or return and examples of code that use them. 
Some of the examples are Extended Examplesthat also show code from callbacks in the Asynchronous 
System Event.
Use of this extension is required by Apple whenever your app provides a third-party sign in option (for 
example, Facebook), and is available for iOS/tvOS 13 and above and macOS 10.15 (Beta) and above. 
To test your apps, you'll need to use the latest beta version of Xcode 11 and update your devices to 
the latest OS versions (which may require you to update to beta versions).
Additionally, for macOS to use this extension you will be required to provide a Signing Identifier in the 
macOS Game Options:


And you will also need to check the "Enable Sign In With Apple" checkbox in the Social section:

Also note that if you are compiling for macOS using the VM and not the YYC, then Xcode will not be 
used and so you need to take an extra step to ensure that your game will function correctly. This 
requires you to retrieve a Provisioning Profile for your game (see here for more information) and add 
it into GameMaker Studio 2 as an included file:

This profile should be valid for the App ID, Team Identifier and Signing Identifier used in the Game 
Options.
Once you have everything setup, it's simply a case of adding a button object into your game and having 
it call the appropriate functions when pressed, and then parsing the Asynchronous System Event to 
get the necessary data from the callback.

IMPORTANT! This functionality cannot be tested by running the game from the GameMaker 
Studio IDE and it is required that you create an executable for the target platform to properly 
test.

 * @module_end
 */