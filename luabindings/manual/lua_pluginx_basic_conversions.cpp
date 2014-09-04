#include "lua_pluginx_basic_conversions.h"

using namespace cocos2d::plugin;

namespace pluginx {

bool luaval_to_TIAPDeveloperInfo(lua_State* L, int lo, TIAPDeveloperInfo* outValue, const char* funcName)
{
    ValueMap ret;
    if (!luaval_to_ccvaluemap(L, lo, &ret, funcName)) return false;
    TIAPDeveloperInfo& dict = *outValue;
    for (auto e : ret) {
        dict[e.first] = e.second.asString();
    }
    return true;
}

bool luaval_to_TProductInfo(lua_State* L, int lo, cocos2d::plugin::TProductInfo* outValue, const char* funcName)
{
    return luaval_to_TIAPDeveloperInfo(L, lo, outValue, funcName);
}


bool luaval_to_FBInfo(lua_State* L, int lo, cocos2d::plugin::FBInfo* outValue, const char* funcName)
{
    return luaval_to_TIAPDeveloperInfo(L, lo, outValue, funcName);
}

}// namespace pluginx {
