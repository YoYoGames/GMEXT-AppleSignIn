// CONSTANTS

/** 
 * @const applesignin_scope
 * @desc These constants specify the scope.
 * @member applesignin_scope_fullname Requests the user's full name.
 * @member applesignin_scope_email Requests the user's e-mail address.
 * @const_end
 */

/** 
 * @const applesignin_response
 * @desc These constants specify the type of response.
 * @member applesignin_signin_response Requests the user's full name.
 * @member applesignin_credential_response Requests the user's e-mail address.
 * @const_end
 */

/** 
 * @const applesignin_realuserstatus
 * @desc These constants specify a user status.
 * @member applesignin_realuserstatus_likelyreal The user is likely a real person.
 * @member applesignin_realuserstatus_unknown The system hasn't determined whether the user might be a real person.
 * @member applesignin_realuserstatus_unsupported This indicates that the IAP product ID has already been added to the internal product list.
 * @const_end
 */

/** 
 * @const applesignin_state
 * @desc These constants specify the user's authorisation state.
 * @member applesignin_state_authorized The user has been authorised and has a valid session.
 * @member applesignin_state_revoked The user's credentials have been revoked and the session terminated.
 * @member applesignin_state_not_found The user doesn't appear to have a session with your app.
 * @const_end
 */

/** 
 * @const mac_applesignin_scope
 * @desc These constants specify the scope.
 * @member mac_applesignin_scope_fullname Requests the user's full name.
 * @member mac_applesignin_scope_email Requests the user's e-mail address.
 * @const_end
 */

/** 
 * @const mac_applesignin_response
 * @desc These constants specify the type of response.
 * @member mac_applesignin_signin_response Requests the user's full name.
 * @member mac_applesignin_credential_response Requests the user's e-mail address.
 * @const_end
 */

/** 
 * @const mac_applesignin_realuserstatus
 * @desc These constants specify a user status.
 * @member mac_applesignin_realuserstatus_likelyreal The user is likely a real person.
 * @member mac_applesignin_realuserstatus_unknown The system hasn't determined whether the user might be a real person.
 * @member mac_applesignin_realuserstatus_unsupported This indicates that the IAP product ID has already been added to the internal product list.
 * @const_end
 */

/** 
 * @const mac_applesignin_state
 * @desc These constants specify the user's authorisation state.
 * @member mac_applesignin_state_authorized The user has been authorised and has a valid session.
 * @member mac_applesignin_state_revoked The user's credentials have been revoked and the session terminated.
 * @member mac_applesignin_state_not_found The user doesn't appear to have a session with your app.
 * @const_end
 */

// FUNCTIONS

/**
 * @func AppleSignIn_CrossPlatform_AddScope
 * @desc This function adds a scope for the sign in request to request additional pieces of user data.
 * 
 * The additional data you can request are for an email address and the user's full name. These are requested using the ${constant.applesignin_scope} or ${constant.mac_applesignin_scope} constants.
 * 
 * @param {constant.applesignin_scope|constant.mac_applesignin_scope} scope One of the scope constants
 * 
 * @example
 * The following code example would go in the ${event.step} of a button object to check for a user wanting to sign in using the Apple Sign In API:
 * 
 * ```gml
 * if mouse_check_button_pressed(mb_left)
 * {
 *     if instance_position(mouse_x, mouse_y, id)
 *     {
 *         AppleSignIn_CrossPlatform_AddScope(applesignin_scope_fullname);
 *         AppleSignIn_CrossPlatform_AddScope(applesignin_scope_email);
 *         AppleSignIn_CrossPlatform_AuthoriseUser();
 *     }
 * }
 * ```
 * @func_end
 */
function AppleSignIn_CrossPlatform_AddScope() {}

/**
 * @func AppleSignIn_CrossPlatform_ClearScopes
 * @desc This function clears the scope(s) set for the user when requesting Sign In authorisation.
 * 
 * In general this is not required at any time, but may be useful if you wish to – for example – have a sign in with email and full name permissions.
 * The user may cancel this as they don't want to share that data, so you can clear the permissions using this function and then let them sign in again with only basic permission scopes.
 * 
 * @example The code below shows an example of the ${event.social} after the user has pressed a button to sign in to your app and the function ${function.AppleSignIn_CrossPlatform_AuthoriseUser} has been called:
 * 
 * ```gml
 * var _event_id = async_load[? "id"];
 * switch (_event_id)
 * {
 *     case applesignin_signin_response:
 *     case mac_applesignin_signin_response:
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
 *         if global.appleSignInState == -1
 *         {
 *             AppleSignIn_CrossPlatform_ClearScopes();
 *         }
 *         break;
 * }
 * ```
 * 
 * @func_end
 */
function AppleSignIn_CrossPlatform_ClearScopes() {}

/**
 * @func AppleSignIn_CrossPlatform_AuthoriseUser
 * @desc This function authorises a user using the Apple Sign In API and their Apple ID credentials.
 * 
 * The ${var.async_load} map will contain the key "response_json", which can then be decoded into another DS map using the function ${function.json_decode} or into a struct using ${function.json_parse}.
 * 
 * @event social
 * @desc The following keys are always present: 
 * @member {boolean} success This contains whether authorisation was granted or not. If this is `false`, none of the other keys listed will be present.
 * @member {string} identityToken This holds the unique identity token string for the session.
 * @member {string} userIdentifier This holds the unique user identifier string.
 * @member {constant.applesignin_realuserstatus|constant.mac_applesignin_realuserstatus} realUserStatus This holds the real user status of the user.
 * @member {string} authCode This holds the unique authorisation code string.
 * @event_end
 * 
 * @event social
 * @desc If you have used the ${function.AppleSignIn_CrossPlatform_AddScope} function before calling the authorise function, then you may have the following additional keys – first, for the `applesignin_scope_email` / `mac_applesignin_scope_email` scope:
 * @member {string} email This will be the user's email address
 * @event_end
 * 
 * @event social
 * @desc For the `applesignin_scope_fullname` / `mac_applesignin_scope_fullname` scope (note that all of these contain an empty string `""` if not available):
 * @member {string} namePrefix The user's name prefix
 * @member {string} phoneticRepresentation A phonetic representation of the name
 * @member {string} givenName The first name of the user
 * @member {string} middleName The middle name of the user
 * @member {string} nameSuffix Any suffix that may be applicable to the name
 * @member {string} nickname The user's nickname
 * @member {string} familyName The user's family (second) name
 * @event_end
 * 
 * @example
 * The authorise function would normally be called from a button or a controller object in your game, and would generate an ${event.social} that can be dealt with in the following way:
 * 
 * ```gml
 * var _event_id = async_load[? "id"];
 * switch (_event_id)
 * {
 *     case applesignin_signin_response:
 *     case mac_applesignin_signin_response:
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
 * A global variable stores the sign in state for future reference, where -1 means not signed in / no action has been taken. You can use one of the ${constant.applesignin_state} or ${constant.mac_applesignin_state} extension constants to check for other states as required.
 * 
 * @func_end
 */
function AppleSignIn_CrossPlatform_AuthoriseUser() {}

/**
 * @func AppleSignIn_CrossPlatform_GetCredentialState
 * @desc This function retrieves the credential sign in state for your game.
 * 
 * You supply the identity token string for the session (returned as part of the callback when you use the function ${function.AppleSignIn_CrossPlatform_AuthoriseUser} and the function will trigger an ${event.social} where the {var.async_load} DS map **"id"** key will be `applesignin_credential_response` or `mac_applesignin_credential_response`.
 * 
 * The ${var.async_load} map will then have a further key "response_json", which will hold a JSON string which can be parsed into a DS map using the function ${function.json_decode}. This map will have the key **"status"**, which will be one of the ${constant.applesignin_state} or ${constant.mac_applesignin_state} constants.
 * @param {string} token The session identity token
 * 
 * @event social
 * @desc The event of `applesignin_credential_response`. It contains the following: 
 * @member {constant.applesignin_state|constant.mac_applesignin_state} status The authorisation status of the user
 * @event_end
 * 
 * @example
 * The following code shows an example of how the callback response for this function would be parsed in the ${event.social}:
 * 
 * ```gml
 * var _event_id = async_load[? "id"];
 * switch (_event_id)
 * {
 *     case applesignin_credential_response:
 *     case mac_applesignin_credential_response:
 *         global.appleSignInState = -1;
 *         var _json = async_load[? "response_json"];
 *         if _json != ""
 *         {
 *             var _map = json_decode(_json);
 *             global.appleSignInState = _map[? "state"];
 *             ds_map_destroy(_map);
 *         }
 *         break;
 * }
 * ```
 * 
 * @func_end
 */
function AppleSignIn_CrossPlatform_GetCredentialState() {}

/**
 * @func Mac_AppleSignIn_RegisterWindow
 * @desc This **macOS only** function must be used before calling any other function to register the game window for authorisation UI overlays.
 * 
 * [[NOTE: You don't need to call this yourself if you use the `_CrossPlatform` versions of the functions. The function ${function.AppleSignIn_CrossPlatform_AuthoriseUser} calls this function on iOS and tvOS.]]
 * 
 * @example
 * The following code example would go in the ${event.step} of a button object to check for a user wanting to sign in using the Apple Sign In API:
 * 
 * ```gml
 * Mac_AppleSignIn_RegisterWindow();
 * Mac_AppleSignIn_AuthoriseUser();
 * ```
 * 
 * @func_end
 */
function Mac_AppleSignIn_RegisterWindow() {}

// MODULES

/** 
 * @module home
 * @title Home
 * @desc This is the Apple Sign In extension wiki.
 * 
 * Use of this extension is required by Apple whenever your app provides a third-party sign in option (for example, Facebook), and is available for iOS/tvOS 13 and above and macOS 10.15 (Beta) and above.
 * 
 * This wiki is meant to be used as a reference to the different Apple Sign In extension functions for iOS, tvOS and macOS, and as such does not contain a tutorial on how to set up the API in your games.
 * We recommend that before doing anything with this extension, you take a moment to look over the official Apple Sign In API documentation, as it will familiarise you with many of the terms and concepts required to use the extension correctly:
 * 
 * * [Apple Developer: Sign In With Apple](https://developer.apple.com/sign-in-with-apple/get-started/)
 * 
 * [[NOTE: The macOS and iOS/tvOS Sign In functions **work exactly the same way and have only been separated into two extensions so that you can use one or the other or both as required**.
 * This means that you may need to do certain checks using the [`os_type`](https://manual-en.yoyogames.com/GameMaker_Language/GML_Reference/OS_And_Compiler/os_type.htm) variable to call the correct function for the current platform the game is running on, but the bulk of the code will be the same regardless.
 * This wiki provides a reference of the additional functions in the `AppleSignInCrossPlatformFunctions` script asset, included with the demo project. These functions are named `AppleSignIn_CrossPlatform_*` and call the correct underlying function, independent of the current [`os_type`](https://manual-en.yoyogames.com/GameMaker_Language/GML_Reference/OS_And_Compiler/os_type.htm).
 * The tvOS/iOS constants and their macOS counterparts, however, currently do not share the same value internally and so you should make sure to always check against **both** constants when using the `AppleSignIn_CrossPlatform_*` functions in your code.]]
 * 
 * @section Guides
 * @description The following guides are available for this extension: 
 * @ref page.setup
 * @section_end
 * 
 * @section Modules
 * @description The following modules are available in the Apple Sign In extension: 
 * @ref module.general
 * @section_end
 * @module_end
 */

/**
 * @module general
 * @title General
 * @desc This is a reference guide to all the functions used by the Apple Sign In Extension,
 * along with any constants that they may use or return and examples of code that use them.
 * Some of the examples are Extended Examples that also show code from callbacks in the ${event.social}.
 *
 * @section_func
 * @ref function.AppleSignIn_CrossPlatform_AddScope
 * @ref function.AppleSignIn_CrossPlatform_ClearScopes
 * @ref function.AppleSignIn_CrossPlatform_AuthoriseUser
 * @ref function.AppleSignIn_CrossPlatform_GetCredentialState
 * @ref function.Mac_AppleSignIn_RegisterWindow
 * @section_end
 * 
 * @section_const
 * @ref applesignin_*
 * @ref mac_applesignin_*
 * @section_end
 * 
 * @module_end
 */