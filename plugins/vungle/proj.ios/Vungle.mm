/****************************************************************************
 Copyright (c) 2013 cocos2d-x.org
 
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

#import "Vungle.h"
#import "VGBytesAssetLoader/VungleBytesAssetLoader.h"
#import "AdsWrapper.h"

#define OUTPUT_LOG(...)     if (self.debug) NSLog(__VA_ARGS__);

static NSString* kVERSION = @"0.1";

@interface AdsVungle ()
@property (strong) VungleBytesAssetLoader* assetLoader;
@property (strong) NSDictionary* viewInfo;

@end

@implementation AdsVungle

@synthesize debug = __debug;

- (void)dealloc {
	[_assetLoader release];
	[_viewInfo release];
	[super dealloc];
}

#pragma mark InterfaceAds impl

- (void)configDeveloperInfo:(NSMutableDictionary*)devInfo {
	static BOOL vungleInit = NO;
	if (!vungleInit) {
		vungleInit = YES;
		VungleSDK* sdk = [VungleSDK sharedSDK];
		_assetLoader = [[VungleBytesAssetLoader alloc] init];
		sdk.assetLoader = _assetLoader;
		[sdk performSelector:@selector(setPluginName:version:) withObject:@"cocos2dx" withObject:kVERSION];
		[sdk startWithAppId:[devInfo objectForKey:@"VungleID"]];
		[sdk setDelegate:self];
	}
}

- (void)showAds:(NSMutableDictionary*)info position:(int)pos {
	NSMutableDictionary* realOptions = [NSMutableDictionary dictionary];
	for (NSString* key in info) {
		if ([key isEqualToString:@"VungleIncentivized"]) {
			realOptions[VunglePlayAdOptionKeyIncentivized] = @([info[key] integerValue] == 1);
		} else if ([key isEqualToString:@"VunglePlacement"]) {
			realOptions[VunglePlayAdOptionKeyPlacement] = info[key];
		}
	}
	NSError* err;
	[[VungleSDK sharedSDK] playAd:[AdsWrapper getCurrentRootViewController] withOptions:realOptions error:&err];
}

- (void)hideAds:(NSMutableDictionary*)info {
	OUTPUT_LOG(@"Vungle does not support hideAds!");
}

- (void)queryPoints {
	OUTPUT_LOG(@"Vungle does not support query points!");
}

- (void)spendPoints:(int)points {
	OUTPUT_LOG(@"Vungle does not support spend points!");
}

- (void)setDebugMode:(BOOL)isDebugMode {
	[[VungleSDK sharedSDK] setLoggingEnabled:isDebugMode];
	self.debug = isDebugMode;
}

- (NSString*)getSDKVersion {
	return VungleSDKVersion;
}

- (NSString*)getPluginVersion {
	return kVERSION;
}

#pragma mark - Vungle Events

- (void)vungleSDKwillShowAd {
	[AdsWrapper onAdsResult:self withRet:kAdsShown withMsg:@"OK"];
}

- (void)vungleSDKwillCloseAdWithViewInfo:(NSDictionary *)viewInfo willPresentProductSheet:(BOOL)willPresentProductSheet {
	self.viewInfo = viewInfo;
	if (!willPresentProductSheet) {
		[self vungleSDKwillCloseProductSheet:nil];
	}
}

- (void)vungleSDKwillCloseProductSheet:(id)productSheet {
	NSString* msg = [NSString stringWithFormat:@"%d,%d",
					 [[_viewInfo objectForKey:@"completedView"] boolValue],
					 [[_viewInfo objectForKey:@"didDownload"] boolValue]];
	[AdsWrapper onAdsResult:self withRet:kAdsDismissed withMsg:msg];
}

- (void)vungleSDKhasCachedAdAvailable {
	[AdsWrapper onAdsResult:self withRet:kAdsReceived withMsg:@"OK"];
}

@end
