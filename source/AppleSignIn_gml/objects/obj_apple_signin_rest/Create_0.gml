/// @description Insert description here
// You can write your code in this editor

search_url = "";

private_key = @"";

function create_code(digits = 14, characters = "123456789") {
	var str = ""
	repeat(digits)
		str += string_char_at(characters,irandom(string_length(characters)))
	
	return str
}


client_id = "";
redirect_uri = "";
state = create_code();
scope = "name email";
response_type = "code";
response_mode = "form_post";
nonce = __apple_signin_generate_code_verifier(128);

var _auth_url = "https://appleid.apple.com/auth/authorize"
    + "?client_id=" + client_id
    + "&redirect_uri=" + __apple_signin_url_encode(redirect_uri)
    + "&response_type=" + __apple_signin_url_encode(response_type)
    + "&response_mode=" + __apple_signin_url_encode(response_mode)
    + "&scope=" + __apple_signin_url_encode(scope)
    + "&state=" + __apple_signin_url_encode(state)
    + "&nonce=" + __apple_signin_url_encode(nonce)
	
search_request = undefined;
	
url_open(_auth_url);

alarm[0] = room_speed;