//
//  ParseUtils.m
//  PluginProtocol
//
//  Created by wzm on 14-7-30.
//  Copyright (c) 2014年 zhangbin. All rights reserved.
//

#import "ParseUtils.h"

@implementation ParseUtils
+ (id)toArrayOrNSDictionary:(NSData *)jsonData{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}
+ (NSString *) NSDictionaryToNSString:(NSDictionary *)dic{
    NSString *result = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return result;
}
@end
