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

#import "GraphFacebook.h"
#import <FacebookSDK/FacebookSDK.h>
#import "GraphWrapper.h"
#define OUTPUT_LOG(...)     if (self.debug) NSLog(__VA_ARGS__);
@implementation GraphFacebook
@synthesize debug = __degug;
-(void)request:(NSDictionary *)params{
    NSString *graphPath = [params objectForKey:@"path"];
    NSString *method = [params objectForKey:@"method"] == nil?@"GET":[params objectForKey:@"method"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    for(NSString* key in params){
        if(![key isEqualToString:@"path"] &&![key isEqualToString:@"method"]){
            [param setObject:[params objectForKey:key] forKey:key];
        }
    }
    [FBRequestConnection startWithGraphPath:graphPath
                                 parameters:param HTTPMethod:method
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if(!error){
                                  OUTPUT_LOG(@"success");
                                  [GraphWrapper onGraphResult:self withRet:kGraphResultSuccess withMsg:@"Graph call Success"];
                              }else{
                                  [GraphWrapper onGraphResult:self withRet:kGraphResultFail withMsg:@"Graph call Fail"];
                                  OUTPUT_LOG(@"error %@", error.description);
                              }
                              
                          }];
}
@end
