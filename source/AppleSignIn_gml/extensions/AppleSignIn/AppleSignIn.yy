{
  "$GMExtension":"",
  "%Name":"AppleSignIn",
  "androidactivityinject":"",
  "androidclassname":"",
  "androidcodeinjection":"",
  "androidinject":"",
  "androidmanifestinject":"",
  "androidPermissions":[],
  "androidProps":false,
  "androidsourcedir":"",
  "author":"",
  "classname":"YY_AppleSignIn",
  "copyToTargets":9007199254740998,
  "description":"",
  "exportToGame":true,
  "extensionVersion":"1.2.0",
  "files":[
    {"$GMExtensionFile":"","%Name":"","constants":[
        {"$GMExtensionConstant":"","%Name":"applesignin_scope_fullname","hidden":false,"name":"applesignin_scope_fullname","resourceType":"GMExtensionConstant","resourceVersion":"2.0","value":"\"fullname\"",},
        {"$GMExtensionConstant":"","%Name":"applesignin_scope_email","hidden":false,"name":"applesignin_scope_email","resourceType":"GMExtensionConstant","resourceVersion":"2.0","value":"\"email\"",},
        {"$GMExtensionConstant":"","%Name":"applesignin_signin_response","hidden":false,"name":"applesignin_signin_response","resourceType":"GMExtensionConstant","resourceVersion":"2.0","value":"1",},
        {"$GMExtensionConstant":"","%Name":"applesignin_state_authorized","hidden":false,"name":"applesignin_state_authorized","resourceType":"GMExtensionConstant","resourceVersion":"2.0","value":"100",},
        {"$GMExtensionConstant":"","%Name":"applesignin_state_revoked","hidden":false,"name":"applesignin_state_revoked","resourceType":"GMExtensionConstant","resourceVersion":"2.0","value":"101",},
        {"$GMExtensionConstant":"","%Name":"applesignin_state_not_found","hidden":false,"name":"applesignin_state_not_found","resourceType":"GMExtensionConstant","resourceVersion":"2.0","value":"102",},
        {"$GMExtensionConstant":"","%Name":"applesignin_credential_response","hidden":false,"name":"applesignin_credential_response","resourceType":"GMExtensionConstant","resourceVersion":"2.0","value":"2",},
        {"$GMExtensionConstant":"","%Name":"applesignin_realuserstatus_likelyreal","hidden":false,"name":"applesignin_realuserstatus_likelyreal","resourceType":"GMExtensionConstant","resourceVersion":"2.0","value":"5002",},
        {"$GMExtensionConstant":"","%Name":"applesignin_realuserstatus_unknown","hidden":false,"name":"applesignin_realuserstatus_unknown","resourceType":"GMExtensionConstant","resourceVersion":"2.0","value":"5001",},
        {"$GMExtensionConstant":"","%Name":"applesignin_realuserstatus_unsupported","hidden":false,"name":"applesignin_realuserstatus_unsupported","resourceType":"GMExtensionConstant","resourceVersion":"2.0","value":"5000",},
      ],"copyToTargets":9007199254740998,"filename":"AppleSignIn.ext","final":"","functions":[
        {"$GMExtensionFunction":"","%Name":"AppleSignIn_Init","argCount":0,"args":[],"documentation":"","externalName":"AppleSignIn_Init","help":"AppleSignIn_Init()","hidden":true,"kind":4,"name":"AppleSignIn_Init","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":2,},
        {"$GMExtensionFunction":"","%Name":"AppleSignIn_AuthoriseUser","argCount":0,"args":[],"documentation":"","externalName":"AppleSignIn_AuthoriseUser","help":"AppleSignIn_AuthoriseUser()","hidden":false,"kind":4,"name":"AppleSignIn_AuthoriseUser","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":2,},
        {"$GMExtensionFunction":"","%Name":"AppleSignIn_AddScope","argCount":0,"args":[1,],"documentation":"","externalName":"AppleSignIn_AddScope","help":"AppleSignIn_AddScope(scope)","hidden":false,"kind":4,"name":"AppleSignIn_AddScope","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":2,},
        {"$GMExtensionFunction":"","%Name":"AppleSignIn_ClearScopes","argCount":0,"args":[],"documentation":"","externalName":"AppleSignIn_ClearScopes","help":"AppleSignIn_ClearScopes()","hidden":false,"kind":4,"name":"AppleSignIn_ClearScopes","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":2,},
        {"$GMExtensionFunction":"","%Name":"AppleSignIn_GetCredentialState","argCount":0,"args":[1,],"documentation":"","externalName":"AppleSignIn_GetCredentialState","help":"AppleSignIn_GetCredentialState(identitiy_token)","hidden":false,"kind":4,"name":"AppleSignIn_GetCredentialState","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":2,},
      ],"init":"AppleSignIn_Init","kind":4,"name":"","order":[
        {"name":"AppleSignIn_Init","path":"extensions/AppleSignIn/AppleSignIn.yy",},
        {"name":"AppleSignIn_AuthoriseUser","path":"extensions/AppleSignIn/AppleSignIn.yy",},
        {"name":"AppleSignIn_AddScope","path":"extensions/AppleSignIn/AppleSignIn.yy",},
        {"name":"AppleSignIn_ClearScopes","path":"extensions/AppleSignIn/AppleSignIn.yy",},
        {"name":"AppleSignIn_GetCredentialState","path":"extensions/AppleSignIn/AppleSignIn.yy",},
      ],"origname":"","ProxyFiles":[
        {"$GMProxyFile":"","%Name":"libAppleSignInMacLib.dylib","name":"libAppleSignInMacLib.dylib","resourceType":"GMProxyFile","resourceVersion":"2.0","TargetMask":1,},
        {"$GMProxyFile":"","%Name":"AppleSignIn.js","name":"AppleSignIn.js","resourceType":"GMProxyFile","resourceVersion":"2.0","TargetMask":5,},
      ],"resourceType":"GMExtensionFile","resourceVersion":"2.0","uncompress":false,"usesRunnerInterface":false,},
  ],
  "gradleinject":"",
  "hasConvertedCodeInjection":true,
  "helpfile":"",
  "HTML5CodeInjection":"<GM_HTML5_PreBody>\r\n<script type=\"text/javascript\" src=\"https://appleid.cdn-apple.com/appleauth/static/jsapi/appleid/1/en_US/appleid.auth.js\"></script>\r\n</GM_HTML5_PreBody>",
  "html5Props":true,
  "IncludedResources":[],
  "installdir":"",
  "iosCocoaPodDependencies":"",
  "iosCocoaPods":"",
  "ioscodeinjection":"<YYIosEntitlements>\r\n<key>com.apple.developer.applesignin</key>\r\n<array>\r\n<string>Default</string>\r\n</array>\r\n</YYIosEntitlements>\r\n",
  "iosdelegatename":"",
  "iosplistinject":"",
  "iosProps":true,
  "iosSystemFrameworkEntries":[
    {"$GMExtensionFrameworkEntry":"","%Name":"AuthenticationServices.framework","embed":0,"name":"AuthenticationServices.framework","resourceType":"GMExtensionFrameworkEntry","resourceVersion":"2.0","weakReference":true,},
  ],
  "iosThirdPartyFrameworkEntries":[],
  "license":"",
  "maccompilerflags":"",
  "maclinkerflags":"",
  "macsourcedir":"",
  "name":"AppleSignIn",
  "options":[
    {"$GMExtensionOption":"","%Name":"__extOptLabel","defaultValue":"WEB","description":"","displayName":"","exportToINI":false,"extensionId":null,"guid":"99b9019d-cafe-4b28-86f2-399fd93b7517","hidden":false,"listItems":[],"name":"__extOptLabel","optType":5,"resourceType":"GMExtensionOption","resourceVersion":"2.0",},
    {"$GMExtensionOption":"","%Name":"ClientID","defaultValue":"","description":"","displayName":"","exportToINI":false,"extensionId":null,"guid":"a22531ad-835f-4864-a309-7981f666efb8","hidden":false,"listItems":[],"name":"ClientID","optType":2,"resourceType":"GMExtensionOption","resourceVersion":"2.0",},
    {"$GMExtensionOption":"","%Name":"OAuth","defaultValue":"","description":"","displayName":"","exportToINI":false,"extensionId":null,"guid":"37dc7ee7-660b-4b1a-991a-07848dd3ae64","hidden":false,"listItems":[],"name":"OAuth","optType":2,"resourceType":"GMExtensionOption","resourceVersion":"2.0",},
    {"$GMExtensionOption":"","%Name":"REDIRECTION CONFIG:1","defaultValue":"OAuth","description":"","displayName":"","exportToINI":false,"extensionId":null,"guid":"5ade8bcb-6617-47b0-810b-00a7375511a2","hidden":false,"listItems":[],"name":"REDIRECTION CONFIG:1","optType":5,"resourceType":"GMExtensionOption","resourceVersion":"2.0",},
    {"$GMExtensionOption":"","%Name":"OAuth ClientID","defaultValue":"","description":"","displayName":"","exportToINI":false,"extensionId":null,"guid":"385eea29-e862-4cf8-8c33-797e68e94421","hidden":false,"listItems":[],"name":"OAuth ClientID","optType":2,"resourceType":"GMExtensionOption","resourceVersion":"2.0",},
    {"$GMExtensionOption":"","%Name":"OAuth Url","defaultValue":"","description":"","displayName":"","exportToINI":false,"extensionId":null,"guid":"b6bf3ac2-c653-4d2a-b0a8-19bea39b7502","hidden":false,"listItems":[],"name":"OAuth Url","optType":2,"resourceType":"GMExtensionOption","resourceVersion":"2.0",},
    {"$GMExtensionOption":"","%Name":"OAuth Search Url","defaultValue":"","description":"","displayName":"","exportToINI":false,"extensionId":null,"guid":"1b24176a-b84a-4da3-a254-bc7da1296c0e","hidden":false,"listItems":[],"name":"OAuth Search Url","optType":2,"resourceType":"GMExtensionOption","resourceVersion":"2.0",},
  ],
  "optionsFile":"options.json",
  "packageId":"",
  "parent":{
    "name":"Apple SignIn",
    "path":"folders/Apple SignIn.yy",
  },
  "productId":"",
  "resourceType":"GMExtension",
  "resourceVersion":"2.0",
  "sourcedir":"",
  "supportedTargets":9007199254740996,
  "tvosclassname":"YY_AppleSignIn",
  "tvosCocoaPodDependencies":"",
  "tvosCocoaPods":"",
  "tvoscodeinjection":"<YYIosEntitlements>\r\n<key>com.apple.developer.applesignin</key>\r\n<array>\r\n<string>Default</string>\r\n</array>\r\n</YYIosEntitlements>\r\n",
  "tvosdelegatename":"",
  "tvosmaccompilerflags":"",
  "tvosmaclinkerflags":"",
  "tvosplistinject":"",
  "tvosProps":true,
  "tvosSystemFrameworkEntries":[
    {"$GMExtensionFrameworkEntry":"","%Name":"AuthenticationServices.framework","embed":0,"name":"AuthenticationServices.framework","resourceType":"GMExtensionFrameworkEntry","resourceVersion":"2.0","weakReference":true,},
  ],
  "tvosThirdPartyFrameworkEntries":[],
}