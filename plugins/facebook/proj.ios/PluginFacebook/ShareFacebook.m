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

#import "ShareFacebook.h"
#import "ShareWrapper.h"
#import <FacebookSDK/FacebookSDK.h>

#define OUTPUT_LOG(...)     if (self.debug) NSLog(__VA_ARGS__);

@implementation ShareFacebook

@synthesize mShareInfo;
@synthesize debug = __debug;

- (void) configDeveloperInfo : (NSMutableDictionary*) cpInfo
{
}

- (void) share: (NSMutableDictionary*) shareInfo
{
    // Link type share info
    NSString *link = [shareInfo objectForKey:@"siteUrl"];
    NSString *name = [shareInfo objectForKey:@"site"];
    NSString *desc = [shareInfo objectForKey:@"text"];
    
    // Photo type share info
    NSString *photo = [shareInfo objectForKey:@"imageUrl"];
    if (!photo) {
        photo = [shareInfo objectForKey:@"imagePath"];
    }
    
    if (link) {
        // Check if the Facebook app is installed and we can present the share dialog
        FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
        params.link = [NSURL URLWithString:link];
        
        // If the Facebook app is installed and we can present the share dialog
        if ([FBDialogs canPresentShareDialogWithParams:params]) {
            // Present the share dialog
            [FBDialogs presentShareDialogWithLink:params.link
                                             name:name
                                          caption:nil
                                      description:desc
                                          picture:[NSURL URLWithString:photo]
                                      clientState:nil
                                          handler:nil];
        } else {
            // Present the feed dialog
            NSDictionary *params = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"app_id", @"href", nil]
                                                               forKeys:[NSArray arrayWithObjects:@"", link, nil]];
            [FBWebDialogs presentFeedDialogModallyWithSession:[FBSession activeSession]
                                                   parameters:params
                                                      handler:nil];
        }
    }
    else if (photo) {
        // If the Facebook app is installed and we can present the share dialog
        if ([FBDialogs canPresentShareDialogWithPhotos]) {
            NSArray *photos = [NSArray arrayWithObjects:[NSURL URLWithString:photo], nil];
            // Present the share dialog
            [FBDialogs presentShareDialogWithPhotos:photos
                                        clientState:nil
                                            handler:nil];
        } else {
            OUTPUT_LOG(@"PluginFacebook : Facebook sdk cannot present the photo sharing dialog");
        }
    }
    else {
        OUTPUT_LOG(@"PluginFacebook : Share target absent or not supported, please add 'siteUrl' or 'imageUrl' in parameters");
    }
}

- (void) setDebugMode: (BOOL) debug
{
    self.debug = debug;
}

- (NSString*) getSDKVersion
{
    return [FBSettings sdkVersion];
}

- (NSString*) getPluginVersion
{
    return @"0.2.0";
}

@end