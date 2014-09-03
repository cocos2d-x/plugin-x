//
//  PluginFacebookAds.h
//  PluginFacebookAds
//
//  Created by Giuseppe Lapenta on 27/08/14.
//  Copyright (c) 2014 Balzo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBAudienceNetwork/FBAudienceNetwork.h>
#import "InterfaceAds.h"


typedef enum {
    
    kSizeDefault = 1,
    kSizeHeightFixed,
    kSizeInterstital,
} FBAdSizeEnum;

typedef enum {
    kTypeBanner = 1,
    kTypeInterstitial,
} FBAdType;

@interface AdsFacebook : NSObject <InterfaceAds, FBInterstitialAdDelegate, FBAdViewDelegate>

@property BOOL debug;
@property (copy, nonatomic) NSString* strPublishID;
@property (nonatomic, strong, readwrite) FBAdView *bannerView;
@property (nonatomic, strong, readwrite) FBInterstitialAd *interstitialView;
@property (nonatomic, nonatomic) NSMutableArray* testDeviceIDs;

/**
 interfaces from InterfaceAds
 */
- (void) configDeveloperInfo: (NSMutableDictionary*) devInfo;
- (void) showAds: (NSMutableDictionary*) info position:(int) pos;
- (void) hideAds: (NSMutableDictionary*) info;
- (void) queryPoints;
- (void) spendPoints: (int) points;
- (void) setDebugMode: (BOOL) isDebugMode;
- (NSString*) getSDKVersion;
- (NSString*) getPluginVersion;

@end
