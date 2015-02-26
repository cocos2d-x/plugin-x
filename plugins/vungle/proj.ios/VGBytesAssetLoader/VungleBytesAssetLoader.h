//
//  VungleBytesAssetLoader.h
//  vungletest
//
//  Created by Rolando Abarca on 7/24/13.
//  (c) 2013, Vungle Inc
//
//

#import <Foundation/Foundation.h>
#import "VungleSDK.h"

@interface VungleBytesAssetLoader : NSObject <VungleAssetLoader>
- (NSData*)vungleLoadAsset:(NSString*)path;
- (UIImage*)vungleLoadImage:(NSString*)path;
@end
