// CONSTANTS

/** 
 * @const applesignin_scope
 * @desc These constants specify the scope. The scope determines which information the user has access to.
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

// FUNCTIONS

/**
 * @func AppleSignIn_AddScope
 * @desc This function adds a scope for the sign in request to request additional pieces of user data.
 * 
 * The additional data you can request are for an email address and the user's full name. These are requested using the ${constant.applesignin_scope} constants.
 * 
 * @param {constant.applesignin_scope} scope One of the scope constants
 * 
 * @example
 * The following code example would go in the ${event.step} of a button object to check for a user wanting to sign in using the Apple Sign In API:
 * 
 * ```gml
 * if (mouse_check_button_pressed(mb_left))
 * {
 *     if (instance_position(mouse_x, mouse_y, id))
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
 * @desc This function clears the scope(s) set for the user when requesting Sign In authorisation.
 * 
 * In general this is not required at any time, but may be useful if you wish to – for example – have a sign in with email and full name permissions.
 * The user may cancel this as they don't want to share that data, so you can clear the permissions using this function and then let them sign in again with only basic permission scopes.
 * 
 * @example The code below shows an example of the ${event.social} after the user has pressed a button to sign in to your app and the function ${function.AppleSignIn_AuthoriseUser} has been called:
 * 
 * ```gml
 * var _event_id = async_load[? "id"];
 * switch (_event_id)
 * {
 *     case applesignin_signin_response:
 *         global.appleSignInState = -1;
 *         var _json = async_load[? "response_json"];
 *         if (_json != "")
 *         {
 *             var _response = json_parse(_json);
 *             if (_response.success)
 *             {
 *                 show_debug_message("Apple Sign In Succeeded");
 *                 global.appleSignInState = applesignin_state_authorized;
 *             }
 *         }
 *         if (global.appleSignInState == -1)
 *         {
 *             AppleSignIn_ClearScopes();
 *         }
 *         break;
 * }
 * ```
 * 
 * @func_end
 */
function AppleSignIn_ClearScopes() {}

/**
 * @func AppleSignIn_AuthoriseUser
 * @desc This function authorises a user using the Apple Sign In API and their Apple ID credentials.
 * 
 * The ${var.async_load} map will contain the key `"response_json"`, which can be parsed into a struct using ${function.json_parse}.
 * 
 * @event social
 * @desc The following keys are always present: 
 * @member {boolean} success This contains whether authorisation was granted or not. If this is `false`, none of the other keys listed will be present.
 * @member {string} identityToken This holds the unique identity token string for the session.
 * @member {string} userIdentifier This holds the unique user identifier string.
 * @member {constant.applesignin_realuserstatus} realUserStatus This holds the real user status of the user.
 * @member {string} authCode This holds the unique authorisation code string.
 * @event_end
 * 
 * @event social
 * @desc If you have used the ${function.AppleSignIn_AddScope} function before calling the authorise function, then you may have the following additional keys – first, for the `applesignin_scope_email` scope:
 * @member {string} email This will be the user's email address
 * @event_end
 * 
 * @event social
 * @desc For the `applesignin_scope_fullname` scope (note that all of these contain an empty string `""` if not available):
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
 *         global.appleSignInState = -1;
 *         var _json = async_load[? "response_json"];
 *         if (_json != "")
 *         {
 *             var _response = json_parse(_json);
 *             if (_response.success)
 *             {
 *                 show_debug_message("Apple Sign In Succeeded");
 *                 global.appleSignInState = applesignin_state_authorized;
 *             }
 *         }
 *         break;
 * }
 * ```
 * 
 * A global variable stores the sign in state for future reference, where -1 means not signed in / no action has been taken. You can use one of the ${constant.applesignin_state} extension constants to check for other states as required.
 * 
 * @func_end
 */
function AppleSignIn_AuthoriseUser() {}

/**
 * @func AppleSignIn_GetCredentialState
 * @desc This function retrieves the credential sign in state for your game.
 * 
 * You supply the identity token string for the session (returned as part of the callback when you use the function ${function.AppleSignIn_AuthoriseUser} and the function will trigger an ${event.social} where the {var.async_load} DS map `"id"` key will be `applesignin_credential_response`.
 * 
 * The ${var.async_load} map will then have a further key `"response_json"`, which will hold a JSON string which can be parsed into a struct using the function ${function.json_parse}. This map will have the key `"status"`, which will be one of the ${constant.applesignin_state} constants.
 * @param {string} token The session identity token
 * 
 * @event social
 * @desc The event of `applesignin_credential_response`. It contains the following: 
 * @member {constant.applesignin_state} status The authorisation status of the user
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
 *         global.appleSignInState = -1;
 *         var _json = async_load[? "response_json"];
 *         if (_json != "")
 *         {
 *             var _response = json_parse(_json);
 *             global.appleSignInState = _response.state;
 *         }
 *         break;
 * }
 * ```
 * 
 * @func_end
 */
function AppleSignIn_GetCredentialState() {}

/**
 * @func AppleSignIn_LoginOAuth
 * @desc This function triggers the OAuth process for logging in with an Apple account.
 * 
 * @param {string} state A unique state string used for security and validation during the OAuth process.
 * @param {String} [scopes] The scopes that will be requested when performing the OAuth authorisation. Defaults to `"name email"`.
 * 
 * @event social
 * @desc 
 * @member {string} type The string `"AppleSignIn_LoginOAuth"`
 * @member {string} nonce The nonce sent with the request
 * @member {string} client_id The client ID
 * @member {string} redirect_uri The redirect URI
 * @event_end
 * 
 * @example
 * ```gml
 * AppleSignIn_LoginOAuth(state);
 * ```
 * The above code starts the login process for logging in using Apple credentials. Since the optional `scopes` parameter isn't provided, the default scopes are requested.
 * The function call will bring up a browser window in which the user can grant your game access to the requested scopes on the user's behalf.
 * 
 * The function finally triggers a ${event.social}: 
 * ```gml
 * /// Async - Social Event
 * if (async_load[? "type"] == "apple_signin_login_oauth") {
 *     nonce = async_load[? "nonce"];
 *     client_id = async_load[? "client_id"];
 *     redirect_uri = async_load[? "redirect_uri"];
 *     
 *     // Start querying the token from the server
 *     alarm[0] = game_get_speed(gamespeed_fps);
 * }
 * ```
 * 
 * If the user confirms, an authorization code is sent to the URL that you've set under **OAuth Redirect URL** in the [Extension Options](https://manual.gamemaker.io/monthly/en/The_Asset_Editors/Extensions.htm#extension_options).
 * The Redirect URL is a URL on your own server to which the authorisation code is sent. Your server code needs to handle receiving the code and then send a POST request to the following endpoint to exchange the code for the access token: `https://appleid.apple.com/auth/token`. See the demo project for more information on what to include in the request to this endpoint.
 * 
 * If all went well, at one point your server will have received the access token. It is then up to your game to periodically (e.g., using an ${event.alarm}) send a POST request to the same server (to the search URL) to check if it has the token. The code to do this might look as follows:
 * 
 * ```gml
 * /// Alarm 0 Event
 * var _headers = ds_map_create();
 * ds_map_add(_headers, "Content-Type", "application/json");
 * 
 * var _body = json_stringify({ state: state })
 * 
 * search_request = http_request(search_url, "POST", _headers, _body);
 * ds_map_destroy(_headers);
 * ```
 * 
 * The HTTP request will either return a valid token or no token (e.g., when the server hasn't received the token yet) in the ${event.http}.
 * If no valid token was received, a new HTTP request can be made after a certain amount of time (e.g., after 1 second).
 * To limit the number of HTTP requests sent to your server this can be limited to a maximum number of tries.
 * @func_end
 */

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
 * > [Apple Developer: Sign In With Apple](https://developer.apple.com/sign-in-with-apple/get-started/)
 * 
 * [[Note: The Sign In functionality is available on macOS, iOS and tvOS using the SDK as well as on all other platforms using OAuth.]]
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
 * Some of the examples also show code from callbacks in the ${event.social}.
 *
 * @section_func
 * @desc These are the functions of the Apple Sign In extension:
 * @ref AppleSignIn_*
 * @section_end
 * 
 * @section_const
 * @desc These are the constants available in the Apple Sign In extension:
 * @ref applesignin_*
 * @section_end
 * 
 * @module_end
 */