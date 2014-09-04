#ifndef __LUA_BASIC_CONVERSIONS_H__
#define __LUA_BASIC_CONVERSIONS_H__

#include "LuaBasicConversions.h"
#include "ProtocolIAP.h"
#include "ProtocolAnalytics.h"
#include "ProtocolAds.h"
#include "ProtocolShare.h"
#include "ProtocolSocial.h"
#include "ProtocolUser.h"

namespace pluginx {

// to native
bool luaval_to_TIAPDeveloperInfo(lua_State* L, int lo, cocos2d::plugin::TIAPDeveloperInfo* outValue, const char* funcName = "");
bool luaval_to_TProductInfo(lua_State* L, int lo, cocos2d::plugin::TProductInfo* outValue, const char* funcName = "");
bool luaval_to_FBInfo(lua_State* L, int lo, cocos2d::plugin::FBInfo* outValue, const char* funcName = "");

} // namespace pluginx {

#endif /* __LUA_BASIC_CONVERSIONS_H__ */
