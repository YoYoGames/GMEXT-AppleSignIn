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
 * @func AppleSignIn_AddScope
 * @desc This function can be used to add a scope for the sign in request to request additional pieces of user data. The additional data you can request are for an email address and the user's full name, and these are requested using the ${constant.applesignin_scope} constants.
 * @param {constant.applesignin_scope} scope One of the scope constants
 * 
 * @example
 * The following code example would go in the Step event of a button object to check for a user wanting to sign in using the Apple Sign In API:
 * 
 * ```gml
 * if mouse_check_button_pressed(mb_left)
 * {
 *     if instance_position(mouse_x, mouse_y, id)
 *     {
 *         AppleSignIn_AddScope(applesignin_scope_fullname);
 *         AppleSignIn_AddScope(applesignin_scope_email);
 *         AppleSignIn_AuthoriseUser();
 *     }
 * }
 * ```
 * @func_end
 */
function AppleSignIn_AddScope() {}

/**
 * @func AppleSignIn_ClearScopes
 * @desc This function is used to clear the scope(s) set for the user when requesting Sign In authorisation. In general this is not required at any time, but may be useful if you wish to – for example – have a sign in with email and full name permissions. The user may cancel this as they don’t want to share that data, so you can clear the permissions using this function and then let them sign in again with only basic permission scopes.
 * @example The code below shows an example of the Asynchronous Social Event after the user has pressed a button to sign in to your app and the function ${func.AppleSignIn_AuthoriseUser} has been called:
 * 
 * ```gml
 * var _event_id = async_load[? "id"];
 * switch (_event_id)
 * {
 *     case applesignin_signin_response:
 *     global.appleSignInState = -1;
 *     var _json = async_load[? "response_json"];
 *     if _json != ""
 *     {
 *         var _map = json_decode(_json);
 *         if _map[? "success"] == true
 *         {
 *             show_debug_message("Apple Sign In Succeeded");
 *             global.appleSignInState = applesignin_state_authorized;
 *         }
 *         ds_map_destroy(_map);
 *     }
 *     if global.appleSignInState == -1
 *     {
 *         AppleSignIn_ClearScopes();
 *     }
 *     break;
 * }
 * ```
 * 
 * @func_end
 */
function AppleSignIn_ClearScopes() {}

/**
 * @func AppleSignIn_AuthoriseUser
 * @desc This function will authorise a user using the Apple Sign In API and their Apple ID credentials. The function will trigger an Asynchronous System Event where the async_load DS map "id" key will be (depending on the platform) the constant applesignin_signin_response / mac_applesignin_signin_response. The async_load map will also contain the key "response_json", which can then be decoded into another DS map using the function json_decode(). This map will have the following keys:
 * * "success" – This will be true or false depending on whether authorisation was granted or not. If this is false, none of the other keys listed will be present.
 * * "identityToken" – This will hold the unique identity token string for the session.
 * * "userIdentifier" – This will hold the unique user identifier string.
 * * "realUserStatus" – This will hold one of the ${constant.applesignin_realuserstatus} constants
 * * "authCode" – This will hold the unique authorisation code string.
 * 
 * Additionally, if you have used the AppleSignIn_AddScope() / Mac_AppleSignIn_AddScope() function before calling the authorise function, then you may have the following additional keys – first, for the applesignin_scope_email / mac_applesignin_scope_email scope:
 * 
 * * "email" – This will be the users email address (as a string)
 * 
 * Then for the applesignin_scope_fullname / mac_applesignin_scope_fullname scope (note that these are all strings if the data is available, and empty strings "" if not):
 * 
 * * "namePrefix" – The user's name prefix
 * * "phoneticRepresentation" – A phonetic representation of the name
 * * "givenName" – The first name of the user
 * * "middleName" – The middle name of the user
 * * "nameSuffix" – Any suffix that may be applicable to the name
 * * "nickname" – The user's nickname
 * * "familyName" – The user's family (second) name
 * 
 * @example
 * The authorise function would normally be called from a button or a controller object in your game, and would generate an Asynchronous Social Event that can be dealt with in the following way:
 * 
 * ```gml
 * var _event_id = async_load[? "id"];
 * switch (_event_id)
 * {
 *     case applesignin_signin_response:
 *         global.appleSignInState = -1;
 *         var _json = async_load[? "response_json"];
 *         if _json != ""
 *         {
 *             var _map = json_decode(_json);
 *             if _map[? "success"] == true
 *             {
 *                 show_debug_message("Apple Sign In Succeeded");
 *                 global.appleSignInState = applesignin_state_authorized;
 *             }
 *             ds_map_destroy(_map);
 *         }
 *         break;
 * }
 * ```
 * 
 * Note that we have a global variable to store the sign in state for future reference, where -1 means not signed in / no action has been taken, and then we can use one of the ${constant.applesignin_state} extension constants to check for other states as required.
 * 
 * @func_end
 */
function AppleSignIn_AuthoriseUser() {}

/**
 * @func AppleSignIn_GetCredentialState
 * @desc With this function you can retrieve the credential sign in state for your game. You supply the identity token string for the session (which is returned as part of the callback when you use the function ${function.AppleSignIn_AuthoriseUser} / Mac_AppleSignIn_AuthoriseUser()) and the function will trigger an Asynchronous System Event where the [`async_load`](https://manual.yoyogames.com/GameMaker_Language/GML_Overview/Variables/Builtin_Global_Variables/async_load.htm) DS map **"id"** key will be ${constant.applesignin_credential_response}. The async_load map will then have a further key "response_json", which will hold a JSON string which can be parsed into a DS map using the function [`json_decode()`](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/File_Handling/Encoding_And_Hashing/json_decode.htm). This map will have the key **"status"**, which will be one of the ${constant.applesignin} constants.
 * @param {string} token The session identity token
 * 
 * @example
 * The following code shows an example of how the callback response for this function would be parsed in the [Asynchronous Social Event](https://manual.yoyogames.com/The_Asset_Editors/Object_Properties/Async_Events/Social.htm):
 * 
 * ```gml
 * var _event_id = async_load[? "id"];
 * switch (_event_id)
 * {
 *     case applesignin_credential_response:
 *     global.appleSignInState = -1;
 *     var _json = async_load[? "response_json"];
 *     if _json != ""
 *     {
 *         var _map = json_decode(_json);
 *         global.appleSignInState = _map[? "state"];
 *         ds_map_destroy(_map);
 *     }
 *     break;
 * }
 * ```
 * 
 * @func_end
 */
function AppleSignIn_GetCredentialState() {}

/**
 * @func Mac_AppleSignIn_RegisterWindow
 * @desc This **macOS only** function must be used before calling any other function to register the game window for authorisation UI overlays.
 * 
 * @example
 * The following code example would go in the Step event of a button object to check for a user wanting to sign in using the Apple Sign In API:
 * 
 * ```gml
 * if mouse_check_button_pressed(mb_left)
 * {
 *     if instance_position(mouse_x, mouse_y, id)
 *     {
 *         Mac_AppleSignIn_RegisterWindow();
 *         Mac_AppleSignIn_AddScope(applesignin_scope_fullname);
 *         Mac_AppleSignIn_AddScope(applesignin_scope_email);
 *         Mac_AppleSignIn_AuthoriseUser();
 *     }
 * }
 * ```
 * 
 * @func_end
 */
function Mac_AppleSignIn_RegisterWindow() {}

/**
 * @func RegisterCallbacks
 * @desc This is an internal function for **macOS only**. This function should never be called in your code, and you should not edit or change anything about it otherwise the extension may no longer work.
 * @func_end
 */
function RegisterCallbacks() {}

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
 * @member applesignin_state_revoked The user's credentials have been revoked and the session terminated.
 * @member applesignin_state_not_found The user does not appear to have a session with your app.
 * @const_end
 */

// MODULES

/** 
 * @module home
 * @title Home
 * @desc This wiki is designed for you to use as a reference to the different Apple Sign In extension functions for iOS, tvOS and macOS, and as such does not contain a tutorial on how to set up the API in your games. We recommend that before doing anything with this extension, you take a moment to look over the official Apple Sign In API documentation, as it will familiarise you with many of the terms and concepts required to use the extension correctly:
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
 * Extension, along with any constants that they may use or return and examples of code that use them. 
 * Some of the examples are Extended Examples that also show code from callbacks in the [Asynchronous 
 * System Event](https://manual.yoyogames.com/The_Asset_Editors/Object_Properties/Async_Events/System.htm).
 * Use of this extension is required by Apple whenever your app provides a third-party sign in option (for 
 * example, Facebook), and is available for iOS/tvOS 13 and above and macOS 10.15 (Beta) and above. 
 * To test your apps, you'll need to use the latest beta version of Xcode 11 and update your devices to 
 * the latest OS versions (which may require you to update to beta versions).
 * Additionally, for macOS to use this extension you will be required to provide a **Signing Identifier** in the 
 * [macOS Game Options](https://manual.yoyogames.com/Settings/Game_Options/macOS.htm):
 *
 * ![Signing Identifier](assets/macOS_Game_Options_Signing_Identifier.png "Signing Identifier")
 *
 * And you will also need to check the **Enable Sign In With Apple** checkbox in the Social section:
 * 
 * ![Enable Sign In with Apple](assets/macOS_Game_Options_Enable_SignIn_with_Apple.png "Enable Sign In with Apple")
 *
 * Also note that if you are compiling for macOS using the VM and not the YYC, then Xcode will not be 
 * used and so you need to take an extra step to ensure that your game will function correctly. This 
 * requires you to retrieve a Provisioning Profile for your game
 * (see the article [Download manual provisioning profiles](https://help.apple.com/xcode/mac/current/#/deva899b4fe5) for more information)
 * and add it into GameMaker as an [included file](https://manual.yoyogames.com/Settings/Included_Files.htm):
 * 
 * ![Provisioning Profile in Included Files](assets/Provisioning_Profile_in_Included_Files.png "Provisioning Profile")
 * 
 * This profile should be valid for the **App ID**, **Team Identifier** and **Signing Identifier** used in the [Game Options](https://manual.yoyogames.com/Settings/Game_Options/macOS.htm).
 * 
 * Once you have everything set up, it's simply a case of adding a button object into your game and having 
 * it call the appropriate functions when pressed, and then parsing the
 * [Asynchronous System Event](https://manual.yoyogames.com/The_Asset_Editors/Object_Properties/Async_Events/System.htm)
 * to get the necessary data from the callback.
 *
 * IMPORTANT! This functionality cannot be tested by running the game from the GameMaker IDE
 * and it is required that you create an executable for the target platform to properly test.
 *
 * @section_func
 * @ref function.AppleSignIn_Init
 * @ref function.Mac_AppleSignIn_Final
 * @ref function.AppleSignIn_AddScope
 * @ref function.AppleSignIn_ClearScopes
 * @ref function.AppleSignIn_AuthoriseUser
 * @ref function.AppleSignIn_GetCredentialState
 * @ref function.Mac_AppleSignIn_RegisterWindow
 * @ref function.RegisterCallbacks
 * @section_end
 * 
 * @module_end
 */