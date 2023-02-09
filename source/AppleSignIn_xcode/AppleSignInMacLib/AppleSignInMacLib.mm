//
//  AppleSignInMacLib.m
//  AppleSignInMacLib
//
//  Created by David Clarke on 19/08/2019.
//  Copyright © 2019 YoYoGames. All rights reserved.
//

#import "AppleSignInMacLib.h"
#import "YY_AppleSignIn.h"

static YY_AppleSignIn* s_SignIn = nil;
static bool isInitialised = false;

NSWindow* g_window = NULL;

extern "C"
{
double Mac_AppleSignIn_Init();
double Mac_AppleSignIn_Final();
double Mac_AppleSignIn_AuthoriseUser();
double Mac_AppleSignIn_AddScope(char* _scope);
double Mac_AppleSignIn_ClearScopes();
double Mac_AppleSignIn_GetCredentialState(char* _identityToken);
double Mac_AppleSignIn_RegisterWindow(char* _window);
}

double Mac_AppleSignIn_Init()
{
    if (s_SignIn == nil)
    {
        s_SignIn = [[YY_AppleSignIn alloc] init];
    }
    
    double val = [s_SignIn AppleSignIn_Init];
    isInitialised = true;
    return val;
}

double Mac_AppleSignIn_Final()
{
    if (s_SignIn != nil)
    {
        [s_SignIn release];
    }
    
    isInitialised = false;
    return 1.0;
}

double Mac_AppleSignIn_AuthoriseUser()
{
    return [s_SignIn AppleSignIn_AuthoriseUser];
}

double Mac_AppleSignIn_AddScope(char* _scope)
{
    NSString* nsScope = [[NSString alloc] initWithUTF8String:_scope];
    double val = [s_SignIn AppleSignIn_AddScope:nsScope];
    [nsScope release];
    return val;
}

double Mac_AppleSignIn_ClearScopes()
{
    return [s_SignIn AppleSignIn_ClearScopes];
}

double Mac_AppleSignIn_GetCredentialState(char* _identityToken)
{
    NSString* nsIdentity = [[NSString alloc] initWithUTF8String:_identityToken];
    double val = [s_SignIn AppleSignIn_GetCredentialState:nsIdentity];
    [nsIdentity release];
    return val;
}

double Mac_AppleSignIn_RegisterWindow(char* _window)
{
    g_window = reinterpret_cast<NSWindow*>(_window);
    return 1.0;
}
