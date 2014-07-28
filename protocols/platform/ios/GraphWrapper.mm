//
//  GraphWrapper.m
//  PluginProtocol
//
//  Created by wzm on 14-7-25.
//  Copyright (c) 2014年 zhangbin. All rights reserved.
//

#import "GraphWrapper.h"
#include "PluginUtilsIOS.h"
#include "ProtocolUser.h"
using namespace cocos2d::plugin;
@implementation GraphWrapper

+ (void) onGraphResult:(id) result withRet:(GraphResult)ret withMsg:(NSString *)msg{
    PluginProtocol* pPlugin = PluginUtilsIOS::getPluginPtr(result);
    ProtocolUser* pUser = dynamic_cast<ProtocolUser*>(pPlugin);
    if (pUser) {
        UserActionListener* listener = pUser->getActionListener();
        ProtocolUser::ProtocolUserCallback callback = pUser->getListener();
        const char* chMsg = [msg UTF8String];
        if (NULL != listener)
        {
            listener->onActionResult(pUser, (UserActionResultCode) ret, chMsg);
        }else if(callback){
            std::string stdmsg(chMsg);
            callback(ret, stdmsg);
        }else
        {
            PluginUtilsIOS::outputLog("Can't find the listener of plugin %s", pPlugin->getPluginName());
        }
    } else {
        PluginUtilsIOS::outputLog("Can't find the C++ object of the User plugin");
    }
}
@end
