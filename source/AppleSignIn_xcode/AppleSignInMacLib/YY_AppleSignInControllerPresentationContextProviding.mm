//
//  YY_AppleSignInControllerPresentationContextProviding.m
//  AppleSignIn
//
//  Created by David Clarke on 16/08/2019.
//  Copyright © 2019 YoYo Games Ltd. All rights reserved.
//

#import "YY_AppleSignInControllerPresentationContextProviding.h"

extern NSWindow* g_window;

@implementation YY_AppleSignInControllerPresentationContextProviding

- (nonnull ASPresentationAnchor)presentationAnchorForAuthorizationController:(nonnull ASAuthorizationController *)controller  API_AVAILABLE(macos(10.15))
{
    return g_window;
}

@end
