//
//  VungleBytesAssetLoader.m
//  vungletest
//
//  Created by Rolando Abarca on 7/24/13.
//  (c) 2013, Vungle Inc
//
//

#import <UIKit/UIKit.h>
#import "VungleBytesAssetLoader.h"
#include "vg_close.png.h"
#include "vg_mute_on.png.h"
#include "vg_mute_off.png.h"
#include "vg_timer.png.h"
#include "vg_cta.png.h"
#include "__vungle.db.h"

@implementation VungleBytesAssetLoader
- (NSData*)vungleLoadAsset:(NSString*)path {
	if ([path isEqualToString:@"vg_close.png"]) {
		return [NSData dataWithBytes:vg_close_png length:sizeof(vg_close_png)];
	} else if ([path isEqualToString:@"vg_mute_off.png"]) {
		return [NSData dataWithBytes:vg_mute_off_png length:sizeof(vg_mute_off_png)];
	} else if ([path isEqualToString:@"vg_mute_on.png"]) {
		return [NSData dataWithBytes:vg_mute_on_png length:sizeof(vg_mute_on_png)];
	} else if ([path isEqualToString:@"vg_cta.png"]) {
		return [NSData dataWithBytes:vg_cta_png length:sizeof(vg_cta_png)];
	} else if ([path isEqualToString:@"vg_timer.png"]) {
		return [NSData dataWithBytes:vg_timer_png length:sizeof(vg_timer_png)];
	} else if ([path isEqualToString:@"__vungle.db"]) {
		return [NSData dataWithBytes:__vungle_db length:sizeof(__vungle_db)];
	}
	return nil;
}

- (UIImage*)vungleLoadImage:(NSString*)path {
	NSData* data = [self vungleLoadAsset:path];
	if (data) {
		return [UIImage imageWithData:data];
	}
	return nil;
}

@end
