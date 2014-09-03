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
bool luaval_to_TIAPDeveloperInfo(lua_State *L, int lo, cocos2d::plugin::TIAPDeveloperInfo* outValue);
bool luaval_to_TProductInfo(lua_State *L, int lo, cocos2d::plugin::TProductInfo* outValue);
bool luaval_to_TAdsDeveloperInfo(lua_State *L, int lo, cocos2d::plugin::TAdsDeveloperInfo* outValue);
bool luaval_to_TAdsInfo(lua_State *L, int lo, cocos2d::plugin::TAdsInfo* outValue);
bool luaval_to_TShareDeveloperInfo(lua_State *L, int lo, cocos2d::plugin::TShareDeveloperInfo* outValue);
bool luaval_to_TShareInfo(lua_State *L, int lo, cocos2d::plugin::TShareInfo* outValue);
bool luaval_to_TSocialDeveloperInfo(lua_State *L, int lo, cocos2d::plugin::TSocialDeveloperInfo* outValue);
bool luaval_to_TAchievementInfo(lua_State *L, int lo, cocos2d::plugin::TAchievementInfo* outValue);

} // namespace pluginx {

#endif /* __LUA_BASIC_CONVERSIONS_H__ */
