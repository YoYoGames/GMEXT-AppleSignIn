
/// Prevents the execution of this script as function and throws an error.
/// @ignore
function apple_signin_api(){
	throw _GMFUNCTION_ + " :: script cannnot be call as a function";
}

#region Internal

/// @desc Computes the SHA-256 hash of a given buffer using the SHA-256 algorithm.
/// This function implements the full SHA-256 algorithm, processes the input buffer, and returns the hash value either
/// as a hexadecimal string or as an array of 8 words (32-bit integers) depending on the `_return_string` parameter.
/// @param {Id.Buffer} _out_buffer The output buffer where the binary SHA-256 hash (32 bytes) will be written.
/// @param {Id.Buffer} _in_buffer The input buffer to be hashed.
/// @param {Real} _in_offset The offset in the buffer where the hash should begin (default is 0).
/// @param {Real} _size The number of bytes to read from the buffer (default is the remaining buffer size).
/// @ignore
function __apple_signin_buffer_sha256(_out_buffer, _in_buffer, _in_offset = 0, _size = (buffer_get_size(_in_buffer) - _in_offset))
{
	// Constants
	static __sha256_block_size = 64;
	static __sha256_word_datatype = buffer_u32;
	static __sha256_word_size = buffer_sizeof(__sha256_word_datatype);
	static __sha256_block_words = (__sha256_block_size / __sha256_word_size);
	static __sha256_round_count = 64;

	// Reusable arrays
	static __sha256_message_schedule = array_create(__sha256_round_count, 0x00);

	static __sha256_round_constants = [ 0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
	                                0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
	                                0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
	                                0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
	                                0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
	                                0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
	                                0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
	                                0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2 ];	
	
	var _state_array_0 = 0x6a09e667;
	var _state_array_1 = 0xbb67ae85;
	var _state_array_2 = 0x3c6ef372;
	var _state_array_3 = 0xa54ff53a;
	var _state_array_4 = 0x510e527f;
	var _state_array_5 = 0x9b05688c;
	var _state_array_6 = 0x1f83d9ab;
	var _state_array_7 = 0x5be0cd19;

	var _block_count = ceil(_size / __sha256_block_size);
    
	//If we don't have space after the final block to store the bit size of the input buffer, add on an extra block
	var _last_block_remaining = __sha256_block_size*_block_count - _size;
	if (_last_block_remaining < 9) _block_count++; //Ensure we have enough room to append a 0x80 byte and a 64-bit integer at the end
    
	var _buffer = _in_buffer, _offset = _in_offset;
	buffer_resize(_buffer, _offset + __sha256_block_size*_block_count);
    
	buffer_poke(_buffer, _offset + _size, buffer_u8, 0x80);
    
	//Store the number of bits right at the end of the buffer
	//This is stored as a big endian number
	var _bits = 8*_size;
	buffer_seek(_buffer, buffer_seek_start, _offset + __sha256_block_size*_block_count - 8);
	buffer_write(_buffer, buffer_u8, _bits >> 56);
	buffer_write(_buffer, buffer_u8, _bits >> 48);
	buffer_write(_buffer, buffer_u8, _bits >> 40);
	buffer_write(_buffer, buffer_u8, _bits >> 32);
	buffer_write(_buffer, buffer_u8, _bits >> 24);
	buffer_write(_buffer, buffer_u8, _bits >> 16);
	buffer_write(_buffer, buffer_u8, _bits >>  8);
	buffer_write(_buffer, buffer_u8, _bits      );
    
	//Jump back to where the data begins
	buffer_seek(_buffer, buffer_seek_start, _offset);
    
	//Perform round for each block
	repeat(_block_count)
	{
	    var _message_schedule = __sha256_message_schedule;
        
	    var _i = 0;
	    repeat(__sha256_block_words)
	    {
	        var _value = buffer_read(_buffer, __sha256_word_datatype);
	        //Reverse endianness
	        _message_schedule[@ _i] = ((_value & 0x000000ff) << 24)
	                                | ((_value & 0x0000ff00) <<  8)
	                                | ((_value & 0x00ff0000) >>  8)
	                                | ((_value & 0xff000000) >> 24);
	        ++_i;
	    }
        
	    _i = __sha256_block_words;
	    repeat(__sha256_round_count - __sha256_block_words)
	    {
	        var _p = _message_schedule[_i - 15];
	        var _q = _message_schedule[_i -  2];
            
	        _message_schedule[@ _i] = ((((_q >> 17) | (_q << 15)) ^ ((_q >> 19) | (_q << 13)) ^ (_q >> 10)) //sigma 1
	                                +  _message_schedule[_i - 7]
	                                + (((_p >> 7) | (_p << 25)) ^ ((_p >> 18) | (_p << 14)) ^ (_p >> 3)) //sigma 0
	                                +  _message_schedule[_i - 16])
	                                & 0xffffffff;
            
	        _i++;
	    }
        
	    var _a = _state_array_0;
	    var _b = _state_array_1;
	    var _c = _state_array_2;
	    var _d = _state_array_3;
	    var _e = _state_array_4;
	    var _f = _state_array_5;
	    var _g = _state_array_6;
	    var _h = _state_array_7;
        
	    _i = 0;
	    repeat(__sha256_round_count)
	    {
	        var _t1 = _h
	                + ((((_e >> 6) | (_e << 26))   ^   ((_e >> 11) | (_e << 21))   ^   ((_e >> 25) | (_e << 7))) & 0xffffffff) //sum 1
	                + ((_e & _f) ^ (~_e & _g))
	                + __sha256_round_constants[_i]
	                + _message_schedule[_i];
               
	        var _t2 = ((((_a >> 2) | (_a << 30))   ^   ((_a >> 13) | (_a << 19))   ^   ((_a >> 22) | (_a << 10))) & 0xffffffff) //sum 0
	                + ((_a & _b) ^ (_a & _c) ^ (_b & _c));
        
	        _h = _g;
	        _g = _f;
	        _f = _e;
	        _e = (_d + _t1) & 0xffffffff;
	        _d = _c;
	        _c = _b;
	        _b = _a;
	        _a = (_t1 + _t2) & 0xffffffff;
        
	        ++_i;
	    }
	
	    _state_array_0 = (_state_array_0 + _a) & 0xffffffff;
	    _state_array_1 = (_state_array_1 + _b) & 0xffffffff;
	    _state_array_2 = (_state_array_2 + _c) & 0xffffffff;
	    _state_array_3 = (_state_array_3 + _d) & 0xffffffff;
	    _state_array_4 = (_state_array_4 + _e) & 0xffffffff;
	    _state_array_5 = (_state_array_5 + _f) & 0xffffffff;
	    _state_array_6 = (_state_array_6 + _g) & 0xffffffff;
	    _state_array_7 = (_state_array_7 + _h) & 0xffffffff;
	}
	
	
	// Seek to the begining of the output buffer
	buffer_seek(_out_buffer, buffer_seek_start, 0);
	
	var _state_array = [
		_state_array_0,
		_state_array_1,
		_state_array_2,
		_state_array_3,
		_state_array_4,
		_state_array_5,
		_state_array_6,
		_state_array_7,
	];
	
	// Write each word into the buffer as 4 bytes (big-endian order)
	var _len = array_length(_state_array);
	for (var _i = 0; _i < _len; _i++) {
		var _word = _state_array[_i];
		_word = ((_word & 0x000000ff) << 24)
				| ((_word & 0x0000ff00) <<  8)
				| ((_word & 0x00ff0000) >>  8)
				| ((_word & 0xff000000) >> 24);
		buffer_write(_out_buffer, buffer_u32, _word);
	}

	// Seek to the begining of the output buffer
	buffer_seek(_out_buffer, buffer_seek_start, 0);	
}

/// Encodes a string for use in a URL by replacing reserved characters with their percent-encoded equivalents.
///
/// This function performs URL encoding for a given input string (_orig), ensuring that reserved characters
/// are encoded using their hexadecimal representation, while unreserved characters remain unchanged.
/// 
/// 1. Creates a reusable output buffer for constructing the encoded string.
///
/// 2. Iterates through each character in the input string.
///
/// 3. Writes unreserved characters directly to the buffer.
///
/// 4. For reserved or special characters, calculates the percent-encoded representation using bitwise operations.
///
/// 5. Writes the encoded representation into the buffer.
///
/// 6. Appends a null terminator to the buffer and returns the constructed URL-encoded string.
///
/// This function uses a static buffer for performance optimization.
///
/// @param {string} _orig The input string to encode for URL usage (ASCII only)
/// @returns {string} The URL-encoded version of the input string.
/// @ignore
function __apple_signin_url_encode(_orig) {
    
	static _output_buffer = buffer_create(1, buffer_grow, 1);
	
    static _hex = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];

	buffer_seek(_output_buffer, buffer_seek_start, 0);
	
	var _i = 1;
    repeat (string_length(_orig)) {
        //var _code = buffer_read(_input_buffer, buffer_u8);
		var _char = string_char_at(_orig, _i++);
		var _code = ord(_char);

        // Check if character is unreserved (ALPHA / DIGIT / "-" / "." / "_" / "~")
        if ((_code >= 65 && _code <= 90) ||    // A-Z
            (_code >= 97 && _code <= 122) ||   // a-z
            (_code >= 48 && _code <= 57) ||    // 0-9
            _code == 45 ||                    // -
            _code == 46 ||                    // .
            _code == 95 ||                    // _
            _code == 126) {                   // ~
			// Write directly to the output buffer
            buffer_write(_output_buffer, buffer_u8, _code);
        } else {
            // Use bitwise operations to get high and low nibbles
            var _high = (_code & $F0) >> 4;
            var _low = _code & $0F;
			buffer_write(_output_buffer, buffer_text, "%" + _hex[_high] + _hex[_low]);
        }
    }
	buffer_write(_output_buffer, buffer_u8, 0);
	
    return buffer_peek(_output_buffer, 0, buffer_string);
}

/// Generates a random nonce code with the specified number of digits using the provided allowed characters.
/// @param {Real} _length The number of characters to generate for the nonce string. Defaults to 32.
/// @returns {String} A randomly generated nonce to be used by apple oauth process.
/// @ignore
function __apple_signin_generate_code_verifier(_length = 32) {
	
	static _output_buffer = buffer_create(1, buffer_grow, 1);
	
	// The allowed characters are: [a-z], [A-Z], [0-9] and [-._~]
    static _chars = [45, 46, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 95, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 126];
	static _chars_count = array_length(_chars)

	buffer_seek(_output_buffer, buffer_seek_start, 0);
	
    for (var i = 0; i < _length; i++) {
        buffer_write(_output_buffer, buffer_u8, _chars[irandom_range(0, _chars_count - 1)]);
    }
	buffer_write(_output_buffer, buffer_u8, 0);
	
    return buffer_peek(_output_buffer, 0, buffer_string);
}

/// Generates a SHA256 hash of the input string.
/// @param {String} _verifier The string of characters to hash.
/// @returns {String} The SHA256 hash of the input string.
/// @ignore
function __apple_signin_generate_code_challenge(_verifier) {
    var _buffer = buffer_create(1, buffer_grow, 1);
	buffer_write(_buffer, buffer_string, _verifier);
	
	var _buffer_sha256 = buffer_create(1, buffer_grow, 1);
	__apple_signin_buffer_sha256(_buffer_sha256, _buffer, 0, string_length(_verifier));
	
    var _hex_string = __apple_signin_byte_buffer_to_hex_string(_buffer_sha256);
	
	buffer_delete(_buffer);
	buffer_delete(_buffer_sha256);
	
	return _hex_string;
}

/// @desc Encodes a given buffer into a Base64Url string.
/// This function converts a binary buffer into a standard Base64 string, and then converts it into Base64Url format
/// by replacing characters according to Base64Url rules.
/// @param {Id.Buffer} _buffer - The buffer to be encoded.
/// @returns {String} The Base64Url encoded string.
/// @ignore
function __apple_signin_buffer_base64_url_encode(_buffer, _offset = 0, _size = -1) {
	var _base64_url = buffer_base64_encode(_buffer, _offset, _size);
	_base64_url = string_replace_all(_base64_url, "+", "-");
	_base64_url = string_replace_all(_base64_url, "/", "_");
	_base64_url = string_trim_end(_base64_url, ["="]);
	return _base64_url;
}

function __apple_signin_byte_buffer_to_hex_string(_buffer, _offset = 0, _length = (buffer_get_size(_buffer) - _offset)) {

    static _nibble_to_hexa = [ ord("0"), ord("1"), ord("2"), ord("3"), ord("4"), ord("5"), ord("6"), ord("7"),
                              ord("8"), ord("9"), ord("a"), ord("b"), ord("c"), ord("d"), ord("e"), ord("f") ];

    // Store the tell of the input buffer so we can reset it at the end
    var _tell = buffer_tell(_buffer);

    // Seek to the offset where we want to start the conversion
    buffer_seek(_buffer, buffer_seek_start, _offset);

    // Create an output buffer that will be 2 times + 1 (terminate character)
    var _temp_buffer = buffer_create(_length * 2, buffer_fixed, 1);
    repeat (_length) {
        // Read the byte
        var _byte = buffer_read(_buffer, buffer_u8);
        // Split the byte into 2 nibbles (higher and lower)
        var _high = (_byte & $F0) >> 4;
        var _low = _byte & $0F;
        // Use the convertion table to get the currect character
        buffer_write(_temp_buffer, buffer_u8, _nibble_to_hexa[_high]);
        buffer_write(_temp_buffer, buffer_u8, _nibble_to_hexa[_low]);
    }
    // Write the end string character '\0'
    buffer_write(_temp_buffer, buffer_u8, 0);

    // Seek the original buffer to the original place
    buffer_seek(_buffer, buffer_seek_start, _tell);

    // Read the converted string and delete the temp buffer
    var _hexa_string = buffer_peek(_temp_buffer, 0, buffer_string);
    buffer_delete(_temp_buffer);

    return _hexa_string;
}

/// Generates a random state string with the specified number of digits using the provided allowed characters.
/// 
/// This function creates a random string of a specified length (_digits) using characters from a given set
/// (_allowed_chars). The generated string is commonly used as a state parameter in OAuth processes for
/// additional security.
/// 
/// 1. Validates the allowed characters string for ASCII compatibility and non-empty value.
/// 
/// 2. Creates buffers for generating the random state string.
/// 
/// 3. Randomly selects characters from the allowed characters set to populate the state string.
/// 
/// 4. Returns the generated state string and cleans up buffers used during the process.
/// 
/// @param {Real} _digits The number of characters to generate for the state string. Defaults to 32.
/// @param {String} _allowed_chars The set of allowed characters to use for generating the state string. Defaults to numeric digits.
/// @returns {String} A randomly generated state string or an empty string if the input is invalid.
/// @ignore
function __apple_signin_state_create(_digits = 32, _allowed_chars = "0123456789")
{
	var _length = string_length(_allowed_chars);
	if (_length != string_byte_length(_allowed_chars)) {
		show_debug_message(_GMFUNCTION_ + " :: only ASCII characters are allowed.");
		return "";
	}
	
	if (_length == 0) {
		show_debug_message(_GMFUNCTION_ + " :: allowed characters is an empty string");
		return "";
	}
	
	var _out_buff = buffer_create(_digits, buffer_fixed, 1);
	var _input_buff = buffer_create(1, buffer_grow, 1);
	
	buffer_write(_input_buff, buffer_text, _allowed_chars); // don't write ending byte
	
	var _input_size = buffer_tell(_input_buff);
	repeat(_digits) {
		buffer_write(_out_buff, buffer_u8, buffer_peek(_input_buff, irandom(_input_size - 1), buffer_u8));
	}
	
	var _code = buffer_peek(_out_buff, 0, buffer_string);
	buffer_delete(_out_buff);
	buffer_delete(_input_buff);
	
	return _code;
}

#endregion

/// @desc Triggers the OAuth process for logging in with an Apple account.
/// 
/// This function constructs the Apple OAuth URL with the provided state parameter,
/// the client ID, and the redirect URI. It opens the URL to initiate the OAuth process
/// and triggers an asynchronous event to signal the start of the login flow.
/// 
/// 1. Retrieves the client ID and redirect URI from the extension's configuration options.
/// 
/// 2. Constructs the Apple OAuth URL using the client ID, redirect URI, and state parameter.
/// 
/// 3. Opens the constructed URL to start the OAuth process.
/// 
/// 4. Creates an asynchronous event payload with OAuth initialization details and triggers the event.
/// 
/// @param {String} _state A unique state string used for security and validation during the OAuth process.
/// @param {String} _scopes The scopes that will be requested when performing the OAuth authorization. Defaults to 'name email'.
function AppleSignIn_LoginOAuth(_state, _scopes = "name email") {
	#macro APPLESIGNIN_OAUTH_ENDPOINT "https://appleid.apple.com/auth/authorize"

	var _client_id = extension_get_option_value("AppleSignIn", "oauthClientId");
	var _redirect_uri = extension_get_option_value("AppleSignIn", "oauthRedirectUrl");

	var _response_type = "code";
	var _response_mode = "form_post";
	
	// Create nonce and get its SHA256
	var _nonce = __apple_signin_generate_code_verifier(128);
	var _nonce_sha256 = __apple_signin_generate_code_challenge(_nonce);

	var _auth_url = APPLESIGNIN_OAUTH_ENDPOINT
		    + "?client_id=" + string(_client_id)
		    + "&redirect_uri=" + __apple_signin_url_encode(_redirect_uri)
		    + "&response_type=" + __apple_signin_url_encode(_response_type)
		    + "&response_mode=" + __apple_signin_url_encode(_response_mode)
		    + "&scope=" + __apple_signin_url_encode(_scopes)
		    + "&state=" + __apple_signin_url_encode(_state)
		    + "&nonce=" + __apple_signin_url_encode(_nonce_sha256)

	// This will be the OAuth initialization
	url_open(_auth_url);

	// Trigger async event which marks the moment of oauth init
	var _async_load = ds_map_create();
	_async_load[? "type"] = "AppleSignIn_LoginOAuth";
	_async_load[? "redirect_uri"] = _redirect_uri;
	_async_load[? "client_id"] = _client_id;
	_async_load[? "nonce"] = _nonce;
	_async_load[? "state"] = _state;
	
	event_perform_async(ev_async_social, _async_load);
}

