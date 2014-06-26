/****************************************************************************
 Copyright (c) 2014 Chukong Technologies Inc.
 
 http://www.cocos2d-x.org
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 ****************************************************************************/

#import "UserFacebook.h"
#import <FacebookSDK/FacebookSDK.h>
#import "UserWrapper.h"
#define OUTPUT_LOG(...)     if (self.debug) NSLog(__VA_ARGS__);

@implementation UserFacebook


@synthesize mUserInfo;
@synthesize debug = __debug;
bool _isLogin = false;
NSString *_userId = @"";
NSString *_accessToken = @"";

- (void) configDeveloperInfo : (NSMutableDictionary*) cpInfo{
}
- (void) login{
    if (FBSession.activeSession.state == FBSessionStateOpen || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                           allowLoginUI:NO
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             [self sessionStateChanged:session state:state error:error];
             // Retrieve the app delegate
         }];

    } else {
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             [self sessionStateChanged:session state:state error:error];
             // Retrieve the app delegate
         }];
    }
}
- (void) logout{
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    }
}
- (BOOL) isLogined{
    return _isLogin;
}
- (NSString *)getUserId{
    return _userId;
    
}
-(NSString *)getAccessToken{
    return _accessToken;
}
- (NSString*) getSessionID{
    return @"";
}
- (void) setDebugMode: (BOOL) debug{
    __debug = debug;
}
- (NSString*) getSDKVersion{
    return @"";
}
- (NSString*) getPluginVersion{
    return @"";
}
-(void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        OUTPUT_LOG(@"Session opened");
        _accessToken = session.accessTokenData.accessToken;
        [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                NSDictionary *dic = (NSDictionary *)result;
                _userId = [dic objectForKey:@"id"];
                _isLogin = true;
                [UserWrapper onActionResult:self withRet:kLoginSucceed withMsg:@"login Success"];
            } else {
                [UserWrapper onActionResult:self withRet:kLoginFailed withMsg:@"login Fail"];
            }
        }];

    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        _isLogin = false;
        OUTPUT_LOG(@"Session closed");
    }
    
    // Handle errors
    if (error){
        _isLogin = false;
        NSString *errorText = @"";
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            errorText = [FBErrorUtility userMessageForError:error];
        } else {
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                OUTPUT_LOG(@"User cancelled login");
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                errorText = @"Your current session is no longer valid. Please log in again.";
            } else {
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                errorText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
            }
        }
        [UserWrapper onActionResult:self withRet:kLoginFailed withMsg:errorText];
        OUTPUT_LOG(errorText);
        [FBSession.activeSession closeAndClearTokenInformation];
    }
}
@end
