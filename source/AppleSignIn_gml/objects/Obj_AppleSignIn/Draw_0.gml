
event_inherited()

var text = ""
switch(appleSignInState)
{
	case applesignin_state_authorized: text = "Authorized"; break
	case applesignin_state_not_found: text = "Not Found"; break
	case applesignin_state_revoked: text = "Revoked"; break
}

draw_set_font(Font_YoYo_20)
draw_set_valign(fa_left)
draw_set_halign(fa_left)
draw_text(50,100,text)
