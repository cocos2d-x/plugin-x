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

int lua_pluginx_protocols_FacebookAgent_request(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::plugin::FacebookAgent* cobj = nullptr;
    bool ok  = true;
    
#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif
    
    
#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"plugin.FacebookAgent",0,&tolua_err)) goto tolua_lerror;
#endif
    
    cobj = (cocos2d::plugin::FacebookAgent*)tolua_tousertype(tolua_S,1,0);
    
#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_pluginx_protocols_FacebookAgent_request'", nullptr);
        return 0;
    }
#endif
    
    argc = lua_gettop(tolua_S)-1;
    if (argc == 4)
    {
        std::string arg0;
        int arg1;
        cocos2d::plugin::FBInfo arg2;
        
        ok &= luaval_to_std_string(tolua_S, 2,&arg0, "plugin.FacebookAgent:request");
        
        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1, "plugin.FacebookAgent:request");

        ok &= luaval_to_FBInfo(tolua_S, 4, &arg2, "plugin.FacebookAgent:request");

        if(!ok)
            return 0;

#if COCOS2D_DEBUG >= 1
        if (!toluafix_isfunction(L,5,"LUA_FUNCTION",0,&tolua_err))
        {
            goto tolua_lerror;
        }
#endif
        LUA_FUNCTION handler = toluafix_ref_function(tolua_S, 5, 0);

        cobj->request(arg0, arg1, arg2, [=](int ret, std::string& msg){
            tolua_pushnumber(tolua_S, ret);
            tolua_pushstring(tolua_S, msg.c_str());
            LuaEngine::getInstance()->getLuaStack()->executeFunctionByHandler(handler, 2);
            LuaEngine::getInstance()->removeScriptHandler(handler);
        });

        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "plugin.FacebookAgent:request",argc, 4);
    return 0;
    
#if COCOS2D_DEBUG >= 1
tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_pluginx_protocols_FacebookAgent_request'.",&tolua_err);
#endif
    return 0;
}

int lua_pluginx_protocols_FacebookAgent_share(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::plugin::FacebookAgent* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"plugin.FacebookAgent",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::plugin::FacebookAgent*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_pluginx_protocols_FacebookAgent_share'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        cocos2d::plugin::FBInfo arg0;

        ok &= luaval_to_FBInfo(tolua_S, 2, &arg0, "plugin.FacebookAgent:share");
        if(!ok)
            return 0;

#if COCOS2D_DEBUG >= 1
        if (!toluafix_isfunction(L,3,"LUA_FUNCTION",0,&tolua_err))
        {
            goto tolua_lerror;
        }
#endif
        LUA_FUNCTION handler = toluafix_ref_function(tolua_S, 3, 0);

        cobj->share(arg0, [=](int ret, std::string& msg){
            tolua_pushnumber(tolua_S, ret);
            tolua_pushstring(tolua_S, msg.c_str());
            LuaEngine::getInstance()->getLuaStack()->executeFunctionByHandler(handler, 2);
            LuaEngine::getInstance()->removeScriptHandler(handler);
        });
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "plugin.FacebookAgent:share",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_pluginx_protocols_FacebookAgent_share'.",&tolua_err);
#endif
    return 0;
}

int lua_pluginx_protocols_FacebookAgent_requestPermissions(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::plugin::FacebookAgent* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"plugin.FacebookAgent",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::plugin::FacebookAgent*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_pluginx_protocols_FacebookAgent_requestPermissions'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0, "plugin.FacebookAgent:requestPermissions");
        if(!ok)
            return 0;

#if COCOS2D_DEBUG >= 1
        if (!toluafix_isfunction(L,3,"LUA_FUNCTION",0,&tolua_err))
        {
            goto tolua_lerror;
        }
#endif
        LUA_FUNCTION handler = toluafix_ref_function(tolua_S, 3, 0);

        cobj->requestPermissions(arg0, [=](int ret, std::string& msg){
            tolua_pushnumber(tolua_S, ret);
            tolua_pushstring(tolua_S, msg.c_str());
            LuaEngine::getInstance()->getLuaStack()->executeFunctionByHandler(handler, 2);
            LuaEngine::getInstance()->removeScriptHandler(handler);
        });
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "plugin.FacebookAgent:requestPermissions",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_pluginx_protocols_FacebookAgent_requestPermissions'.",&tolua_err);
#endif
    return 0;
}


int lua_pluginx_protocols_FacebookAgent_dialog(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::plugin::FacebookAgent* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"plugin.FacebookAgent",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::plugin::FacebookAgent*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_pluginx_protocols_FacebookAgent_dialog'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        cocos2d::plugin::FBInfo arg0;

        ok &= luaval_to_FBInfo(tolua_S, 2, &arg0, "plugin.FacebookAgent:dialog");
        if(!ok)
            return 0;

#if COCOS2D_DEBUG >= 1
        if (!toluafix_isfunction(L,3,"LUA_FUNCTION",0,&tolua_err))
        {
            goto tolua_lerror;
        }
#endif
        LUA_FUNCTION handler = toluafix_ref_function(tolua_S, 3, 0);

        cobj->dialog(arg0, [=](int ret, std::string& msg){
            tolua_pushnumber(tolua_S, ret);
            tolua_pushstring(tolua_S, msg.c_str());
            LuaEngine::getInstance()->getLuaStack()->executeFunctionByHandler(handler, 2);
            LuaEngine::getInstance()->removeScriptHandler(handler);
        });
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "plugin.FacebookAgent:dialog",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_pluginx_protocols_FacebookAgent_dialog'.",&tolua_err);
#endif

    return 0;
}

int lua_pluginx_protocols_FacebookAgent_login(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::plugin::FacebookAgent* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"plugin.FacebookAgent",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::plugin::FacebookAgent*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_pluginx_protocols_FacebookAgent_login'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
#if COCOS2D_DEBUG >= 1
        if (!toluafix_isfunction(L,2,"LUA_FUNCTION",0,&tolua_err))
        {
            goto tolua_lerror;
        }
#endif
        LUA_FUNCTION handler = toluafix_ref_function(tolua_S, 2, 0);

        cobj->login(arg0, [=](int ret, std::string& msg){
            tolua_pushnumber(tolua_S, ret);
            tolua_pushstring(tolua_S, msg.c_str());
            LuaEngine::getInstance()->getLuaStack()->executeFunctionByHandler(handler, 2);
            LuaEngine::getInstance()->removeScriptHandler(handler);
        });
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "plugin.FacebookAgent:login",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_pluginx_protocols_FacebookAgent_login'.",&tolua_err);
#endif

    return 0;
}

static void extendFacebookAgent(lua_State* tolua_S)
{
    lua_pushstring(tolua_S, "plugin.FacebookAgent");
    lua_rawget(tolua_S, LUA_REGISTRYINDEX);
    if (lua_istable(tolua_S,-1))
    {
        tolua_function(tolua_S, "request", lua_pluginx_protocols_FacebookAgent_request);
        tolua_function(tolua_S, "share", lua_pluginx_protocols_FacebookAgent_share);
        tolua_function(tolua_S, "requestPermissions", lua_pluginx_protocols_FacebookAgent_requestPermissions);
        tolua_function(tolua_S, "dialog", lua_pluginx_protocols_FacebookAgent_dialog);
        tolua_function(tolua_S, "login", lua_pluginx_protocols_FacebookAgent_login);
    }
    lua_pop(tolua_S, 1);
}


int register_all_pluginx_manual_callback(lua_State* tolua_S)
{
    if (nullptr == tolua_S)
        return 0;
    extendProtocolIAP(tolua_S);
    extendFacebookAgent(tolua_S);
    return 0;
}
