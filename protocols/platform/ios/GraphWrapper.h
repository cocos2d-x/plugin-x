//
//  GraphWrapper.h
//  PluginProtocol
//
//  Created by wzm on 14-7-25.
//  Copyright (c) 2014年 zhangbin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kGraphResultSuccess = 0,
    kGraphResultFail,
    kGraphResultCancel,
    kGraphResultTimeout,
} GraphResult;

@interface GraphWrapper : NSObject
+ (void) onGraphResult:(id) result withRet:(GraphResult)ret withMsg:(NSString *)msg;
@end
