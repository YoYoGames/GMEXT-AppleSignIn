//
// Copyright YoYo Games Ltd.
// For support please submit a ticket at help.yoyogames.com
//

#import "YY_AppleSignIn.h"
#include "YY_AppleSignInEnums.h"
#include "Callbacks.h"

@implementation YY_AppleSignIn
{
    NSMutableArray* requestedScopes;
    YY_AppleSignInDelegate* authDelegate;
    YY_AppleSignInControllerPresentationContextProviding* authPresentation;
    ASAuthorizationAppleIDProvider* appleIdProvider API_AVAILABLE(macos(10.15));
}

- (void)dealloc
{
    if (authDelegate != nil)
    {
        [authDelegate release];
    }
    
    if (requestedScopes != nil)
    {
        [requestedScopes release];
    }
    
    
    if (authPresentation != nil)
    {
        [authPresentation release];
    }
    
    if (appleIdProvider != nil)
    {
        [appleIdProvider release];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

- (double) AppleSignIn_Init
{
    requestedScopes = [[NSMutableArray alloc] init];
    authDelegate = [[YY_AppleSignInDelegate alloc] init];
    authPresentation = [[YY_AppleSignInControllerPresentationContextProviding alloc] init];
    if (@available(macOS 10.15, *))
    {
        appleIdProvider = [[ASAuthorizationAppleIDProvider alloc] init];
    }
    
    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
    if (notificationCenter != nil)
    {
        if (@available(macOS 10.15, *)) {
            
            SEL appleIdSelector = NSSelectorFromString(@"appleIdCredentialRevoked:");
            
            NSString* notificationName = ASAuthorizationAppleIDProviderCredentialRevokedNotification;
            [notificationCenter addObserver:self selector:appleIdSelector name:notificationName object:nil];
        } else {
            // Fallback on earlier versions
        }
    }
    
    return 0.0;
}

- (void) appleIdCredentialRevoked:(NSNotification*) notification
{
    if (@available(macOS 10.15, *)) {
        if ([[notification name] isEqualToString:ASAuthorizationAppleIDProviderCredentialRevokedNotification])
        {
            NSMutableDictionary* results = [[NSMutableDictionary alloc] init];
            results[@"state"] = [[NSNumber alloc] initWithInt:applesignin_state_revoked];
            
            NSError* pError = nil;
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:results options:0 error:&pError];
            NSString* jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            // Async
            char jId[3];
            sprintf(jId, "id");
            char jResponse[20];
            sprintf(jResponse, "response_json");
            
            int dsMapIndex = CreateDsMap(0);
            DsMapAddDouble(dsMapIndex, jId, applesignin_credential_response);
            DsMapAddString(dsMapIndex, jResponse, const_cast<char*>([jsonStr UTF8String]));
            CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);
            
            [results release];
            [jsonStr release];
        }
    } else {
        // Fallback on earlier versions
		NSLog(@"Only available on macOS10.15 or later");
    }
}

- (double) AppleSignIn_AuthoriseUser
{
    if (@available(macOS 10.15, *))
    {
        ASAuthorizationAppleIDRequest* request = [appleIdProvider createRequest];
        request.requestedScopes = requestedScopes;
  
        ASAuthorizationController* authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
        authDelegate = [[YY_AppleSignInDelegate alloc] init];
        
        authorizationController.delegate = authDelegate;
        authorizationController.presentationContextProvider = authPresentation;
        [authorizationController performRequests];
    
    } else {
        // Fallback on earlier versions
    }
    
    return 0.0;
}

- (double) AppleSignIn_AddScope: (NSString*)scope
{
    if (@available(macOS 10.15, *))
    {
        if ([scope isEqualToString:applesignin_scope_fullname])
        {
            if (![requestedScopes containsObject:ASAuthorizationScopeFullName])
            {
                [requestedScopes addObject:ASAuthorizationScopeFullName];
            }
        }
        else if ([scope isEqualToString:applesignin_scope_email])
        {
            if (![requestedScopes containsObject:ASAuthorizationScopeEmail])
            {
                [requestedScopes addObject:ASAuthorizationScopeEmail];
            }
        }
    }
    
    return 1.0;
}

- (double) AppleSignIn_ClearScopes
{
    [requestedScopes removeAllObjects];
    return 1.0;
}

- (double) AppleSignIn_GetCredentialState:(NSString*) userId
{
    if (@available(macOS 10.15, *))
    {
        [appleIdProvider getCredentialStateForUserID:userId completion:^(ASAuthorizationAppleIDProviderCredentialState credentialState, NSError * _Nullable error) {
            
            NSMutableDictionary* results = [[NSMutableDictionary alloc] init];
            
            switch (credentialState)
            {
                case ASAuthorizationAppleIDProviderCredentialAuthorized:
                    results[@"state"] = [[NSNumber alloc] initWithInt:applesignin_state_authorized];
                    break;
                case ASAuthorizationAppleIDProviderCredentialRevoked:
                    results[@"state"] = [[NSNumber alloc] initWithInt:applesignin_state_revoked];
                    break;
                case ASAuthorizationAppleIDProviderCredentialNotFound:
                    results[@"state"] = [[NSNumber alloc] initWithInt:applesignin_state_not_found];
                    break;
            }
            
            NSError* pError = nil;
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:results options:0 error:&pError];
            NSString* jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            // Async
            char jId[3];
            sprintf(jId, "id");
            char jResponse[20];
            sprintf(jResponse, "response_json");
            
            int dsMapIndex = CreateDsMap(0);
            DsMapAddDouble(dsMapIndex, jId, applesignin_credential_response);
            DsMapAddString(dsMapIndex, jResponse, const_cast<char*>([jsonStr UTF8String]));
            CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);
            
            [results release];
            [jsonStr release];
        }];
    }
    
    return 1.0;
}

@end
