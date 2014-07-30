//
//  ParseUtils.h
//  PluginProtocol
//
//  Created by wzm on 14-7-30.
//  Copyright (c) 2014年 zhangbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseUtils : NSObject
+ (id)toArrayOrNSDictionary:(NSData *)jsonData;
+ (NSString *) NSDictionaryToNSString:(NSDictionary *)dic;
@end
