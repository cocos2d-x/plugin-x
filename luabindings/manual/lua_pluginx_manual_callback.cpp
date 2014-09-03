#include "lua_pluginx_manual_callback.h"
#include "PluginManager.h"
#include "ProtocolAnalytics.h"
#include "ProtocolIAP.h"
#include "ProtocolAds.h"
#include "ProtocolShare.h"
#include "ProtocolSocial.h"
#include "ProtocolUser.h"
#include "tolua_fix.h"
#include "LuaBasicConversions.h"
#include "CCLuaValue.h"
#include "CCLuaEngine.h"
#include "lua_pluginx_basic_conversions.h"

using namespace std;
using namespace cocos2d::plugin;

int lua_pluginx_protocols_ProtocolIAP_payForProduct(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::plugin::ProtocolIAP* cobj = nullptr;
    bool ok  = true;
#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif
    
#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"plugin.ProtocolIAP",0,&tolua_err)) goto tolua_lerror;
#endif
    cobj = (cocos2d::plugin::ProtocolIAP*)tolua_tousertype(tolua_S,1,0);
#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_pluginx_protocols_ProtocolIAP_payForProduct'", nullptr);
        return 0;
    }
#endif
    argc = lua_gettop(tolua_S)-1;
    do{
        if (argc == 2) {
            TProductInfo arg0;
            ok &= pluginx::luaval_to_TProductInfo(tolua_S, 2, &arg0);
            
            if (!ok) { break; }
            LUA_FUNCTION callback = toluafix_ref_function(tolua_S, 3, 0);
            cobj->payForProduct(arg0, [=](int ret, std::string& productInfo) {
                tolua_pushnumber(tolua_S, ret);
                tolua_pushstring(tolua_S, productInfo.c_str());
                LuaEngine::getInstance()->getLuaStack()->executeFunctionByHandler(callback, 2);
                LuaEngine::getInstance()->removeScriptHandler(callback);
            });
            return 0;
        }
    }while(0);
    ok  = true;
    do{
        if (argc == 1) {
            TProductInfo arg0;
            ok &= pluginx::luaval_to_TProductInfo(tolua_S, 2, &arg0);
            
            if (!ok) { break; }
            cobj->payForProduct(arg0);
            return 0;
        }
    }while(0);
    ok  = true;
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "payForProduct",argc, 1);
    return 0;
    
#if COCOS2D_DEBUG >= 1
tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_pluginx_protocols_ProtocolIAP_payForProduct'.",&tolua_err);
#endif
    
    return 0;
}

static void extendProtocolIAP(lua_State* tolua_S)
{
    lua_pushstring(tolua_S, "plugin.ProtocolIAP");
    lua_rawget(tolua_S, LUA_REGISTRYINDEX);
    if (lua_istable(tolua_S,-1))
    {
        lua_pushstring(tolua_S,"payForProduct");
        lua_pushcfunction(tolua_S,lua_pluginx_protocols_ProtocolIAP_payForProduct);
        lua_rawset(tolua_S,-3);
    }
    lua_pop(tolua_S, 1);
}

int lua_pluginx_protocols_ProtocolShare_share(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::plugin::ProtocolShare* cobj = nullptr;
    bool ok  = true;
#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif
    
#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"plugin.ProtocolShare",0,&tolua_err)) goto tolua_lerror;
#endif
    cobj = (cocos2d::plugin::ProtocolShare*)tolua_tousertype(tolua_S,1,0);
#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_pluginx_protocols_ProtocolShare_share'", nullptr);
        return 0;
    }
#endif
    argc = lua_gettop(tolua_S)-1;
    do{
        if (argc == 2) {
            TShareInfo arg0;
            ok &= pluginx::luaval_to_TShareInfo(tolua_S, 2, &arg0);
            
            if (!ok) { break; }
            LUA_FUNCTION callback = toluafix_ref_function(tolua_S, 3, 0);
            function<void(int, string&)> arg1 = [=](int ret, string& shareInfo) {
                tolua_pushnumber(tolua_S, ret);
                tolua_pushstring(tolua_S, shareInfo.c_str());
                LuaEngine::getInstance()->getLuaStack()->executeFunctionByHandler(callback, 2);
                LuaEngine::getInstance()->removeScriptHandler(callback);
            };
            cobj->share(arg0, arg1);
            return 0;
        }
    }while(0);
    ok  = true;
    do{
        if (argc == 1) {
            TShareInfo arg0;
            ok &= pluginx::luaval_to_TShareInfo(tolua_S, 2, &arg0);
            
            if (!ok) { break; }
            cobj->share(arg0);
            return 0;
        }
    }while(0);
    ok  = true;
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "share",argc, 1);
    return 0;
    
#if COCOS2D_DEBUG >= 1
tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_pluginx_protocols_ProtocolShare_share'.",&tolua_err);
#endif
    
    return 0;
}

static void extendProtocolShare(lua_State* tolua_S)
{
    lua_pushstring(tolua_S, "plugin.ProtocolShare");
    lua_rawget(tolua_S, LUA_REGISTRYINDEX);
    if (lua_istable(tolua_S,-1))
    {
        lua_pushstring(tolua_S,"share");
        lua_pushcfunction(tolua_S,lua_pluginx_protocols_ProtocolShare_share);
        lua_rawset(tolua_S,-3);
    }
    lua_pop(tolua_S, 1);
}

int lua_pluginx_protocols_ProtocolSocial_submitScore(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::plugin::ProtocolSocial* cobj = nullptr;
    bool ok  = true;
#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif
    
#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"plugin.ProtocolSocial",0,&tolua_err)) goto tolua_lerror;
#endif
    cobj = (cocos2d::plugin::ProtocolSocial*)tolua_tousertype(tolua_S,1,0);
#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_pluginx_protocols_ProtocolSocial_submitScore'", nullptr);
        return 0;
    }
#endif
    argc = lua_gettop(tolua_S)-1;
    do{
        if (argc == 3) {
            const char* arg0;
            std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp); arg0 = arg0_tmp.c_str();
            
            if (!ok) { break; }
            long arg1;
            ok &= luaval_to_long(tolua_S, 3, &arg1);
            
            if (!ok) { break; }
            std::function<void (int, std::basic_string<char> &)> arg2;
            LUA_FUNCTION callback = toluafix_ref_function(tolua_S, 4, 0);
            arg2 = [=](int ret, string& scoreInfo) {
                tolua_pushnumber(tolua_S, ret);
                tolua_pushstring(tolua_S, scoreInfo.c_str());
                LuaEngine::getInstance()->getLuaStack()->executeFunctionByHandler(callback, 2);
                LuaEngine::getInstance()->removeScriptHandler(callback);
            };
            
            if (!ok) { break; }
            cobj->submitScore(arg0, arg1, arg2);
            return 0;
        }
    }while(0);
    ok  = true;
    do{
        if (argc == 2) {
            const char* arg0;
            std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp); arg0 = arg0_tmp.c_str();
            
            if (!ok) { break; }
            long arg1;
            ok &= luaval_to_long(tolua_S, 3, &arg1);
            
            if (!ok) { break; }
            cobj->submitScore(arg0, arg1);
            return 0;
        }
    }while(0);
    ok  = true;
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "submitScore",argc, 2);
    return 0;
    
#if COCOS2D_DEBUG >= 1
tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_pluginx_protocols_ProtocolSocial_submitScore'.",&tolua_err);
#endif
    
    return 0;
}

int lua_pluginx_protocols_ProtocolSocial_unlockAchievement(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::plugin::ProtocolSocial* cobj = nullptr;
    bool ok  = true;
#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif
    
#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"plugin.ProtocolSocial",0,&tolua_err)) goto tolua_lerror;
#endif
    cobj = (cocos2d::plugin::ProtocolSocial*)tolua_tousertype(tolua_S,1,0);
#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_pluginx_protocols_ProtocolSocial_unlockAchievement'", nullptr);
        return 0;
    }
#endif
    argc = lua_gettop(tolua_S)-1;
    do{
        if (argc == 2) {
            cocos2d::plugin::TAchievementInfo arg0;
            ok &= pluginx::luaval_to_TAchievementInfo(tolua_S, 2, &arg0);
            
            if (!ok) { break; }
            std::function<void (int, std::basic_string<char> &)> arg1;
            LUA_FUNCTION callback = toluafix_ref_function(tolua_S, 3, 0);
            arg1 = [=](int ret, string& unlockInfo) {
                tolua_pushnumber(tolua_S, ret);
                tolua_pushstring(tolua_S, unlockInfo.c_str());
                LuaEngine::getInstance()->getLuaStack()->executeFunctionByHandler(callback, 2);
                LuaEngine::getInstance()->removeScriptHandler(callback);
            };
            
            if (!ok) { break; }
            cobj->unlockAchievement(arg0, arg1);
            return 0;
        }
    }while(0);
    ok  = true;
    do{
        if (argc == 1) {
            cocos2d::plugin::TAchievementInfo arg0;
            ok &= pluginx::luaval_to_TAchievementInfo(tolua_S, 2, &arg0);
            
            if (!ok) { break; }
            cobj->unlockAchievement(arg0);
            return 0;
        }
    }while(0);
    ok  = true;
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "unlockAchievement",argc, 1);
    return 0;
    
#if COCOS2D_DEBUG >= 1
tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_pluginx_protocols_ProtocolSocial_unlockAchievement'.",&tolua_err);
#endif
    
    return 0;
}

static void extendProtocolSocial(lua_State* tolua_S)
{
    lua_pushstring(tolua_S, "plugin.ProtocolSocial");
    lua_rawget(tolua_S, LUA_REGISTRYINDEX);
    if (lua_istable(tolua_S,-1))
    {
        lua_pushstring(tolua_S,"submitScore");
        lua_pushcfunction(tolua_S,lua_pluginx_protocols_ProtocolSocial_submitScore);
        lua_rawset(tolua_S,-3);
        lua_pushstring(tolua_S,"unlockAchievement");
        lua_pushcfunction(tolua_S,lua_pluginx_protocols_ProtocolSocial_unlockAchievement);
        lua_rawset(tolua_S,-3);
    }
    lua_pop(tolua_S, 1);
}

int register_all_pluginx_manual_callback(lua_State* tolua_S)
{
    if (NULL == tolua_S)
        return 0;
    extendProtocolIAP(tolua_S);
    extendProtocolShare(tolua_S);
    extendProtocolSocial(tolua_S);
    return 0;
}
