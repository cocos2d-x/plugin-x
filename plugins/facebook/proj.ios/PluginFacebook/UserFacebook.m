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
#import "ParseUtils.h"
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
- (NSNumber *) isLoggedIn{
    return [NSNumber  numberWithBool:_isLogin];
}
- (NSString *)getUserId{
    return _userId;
    [FBRequestConnection startWithGraphPath:@"me/events?fields=cover,name,start_time"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  // Sucess! Include your code to handle the results here
                                  NSLog(@"user events: %@", result);
                              } else {
                                  // An error occurred, we need to handle the error
                                  // See: https://developers.facebook.com/docs/ios/errors   
                              }
                          }];
    
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
        _accessToken = session.accessTokenData.accessToken;
        _isLogin = true;
        OUTPUT_LOG(@"Session opened");
        NSString *msg = @"loginSuccess";
        [UserWrapper onActionResult:self withRet:kLoginSucceed withMsg:msg];
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        NSString *msg = @"loginFail Session closed";
        if(!_isLogin){
            [UserWrapper onActionResult:self withRet:kLoginFailed withMsg:msg];
        }
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
-(void)requestPermissions:(NSString *)permision{
    if(FBSession.activeSession.state != FBSessionStateOpen && FBSession.activeSession.state != FBSessionStateOpenTokenExtended){
        NSString *msg = @"Session closed please login first";
        [UserWrapper onPermissionsResult:self withRet:kPermissionFailed withMsg:msg];
        return;
    }
    NSArray *permission = [permision componentsSeparatedByString:@","];
    [FBSession.activeSession requestNewReadPermissions:permission
                                     completionHandler:^(FBSession *session, NSError *error) {
                                         if (!error) {
                                             // Permission granted
                                             OUTPUT_LOG(@"new permissions %@", [FBSession.activeSession permissions]);
                                             NSString *msg = [ParseUtils NSDictionaryToNSString:[FBSession.activeSession permissions]];
                                             if(msg!=nil){
                                                 [UserWrapper onPermissionsResult:self withRet:kPermissionSucceed withMsg:msg];
                                             }else{
                                                 msg = @"parse permission data fail";
                                                 [UserWrapper onPermissionsResult:self withRet:kPermissionFailed withMsg:msg];
                                             }
                                             // We can request the user information
                                         } else {
                                             // An error occurred, we need to handle the error
                                             // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
                                             NSString *msg = error.description;
                                             [UserWrapper onPermissionsResult:self withRet:kPermissionFailed withMsg:msg];
                                             OUTPUT_LOG(@"error %@", msg);
                                         }
                                     }];
}

-(void)request:(NSMutableDictionary *)params{
    NSString *graphPath = [params objectForKey:@"Param1"];
    int methodID = [[params objectForKey:@"Param2"] intValue];
    NSString * method = methodID == 0? @"GET":methodID == 1?@"POST":@"DELETE";
    NSDictionary *param = [params objectForKey:@"Param3"];
    int cbId = [[params objectForKey:@"Param4"] intValue];
    [FBRequestConnection startWithGraphPath:graphPath
                                 parameters:param HTTPMethod:method
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if(!error){
                                  OUTPUT_LOG(@"success");
                                  NSString *msg = [ParseUtils NSDictionaryToNSString:(NSDictionary *)result];
                                  if(nil == msg){
                                      msg = @"parse fail";
                                      [UserWrapper onGraphResult:self withRet:kGraphResultFail withMsg:msg withCallback:cbId];
                                  }else{
                                      [UserWrapper onGraphResult:self withRet:kGraphResultSuccess withMsg:msg withCallback:cbId];
                                  }
                              }else{
                                  NSString *msg = error.description;
                                  [UserWrapper onGraphResult:self withRet:kGraphResultFail withMsg:msg withCallback:cbId];
                                  OUTPUT_LOG(@"error %@", error.description);
                              }
                              
                          }];
}
@end
