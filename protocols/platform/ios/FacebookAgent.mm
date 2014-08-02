#include "AgentManager.h"
#include "FacebookAgent.h"
namespace cocos2d{namespace plugin{
    
    static FacebookAgent* s_sharedFacebookAgent = nullptr;
    
    FacebookAgent* FacebookAgent::getInstance()
    {
        if(nullptr == s_sharedFacebookAgent)
        {
            s_sharedFacebookAgent = new (std::nothrow)FacebookAgent();
        }
        return s_sharedFacebookAgent;
    }
    
    void FacebookAgent::destroyInstance()
    {
        if(s_sharedFacebookAgent)
        {
            delete s_sharedFacebookAgent;
            s_sharedFacebookAgent = nullptr;
        }
    }
    
    FacebookAgent::FacebookAgent()
    {
        agentManager = AgentManager::getInstance();
    }
    
    FacebookAgent::~FacebookAgent()
    {
        requestCallbacks.clear();
        AgentManager::destroyInstance();
    }
    
    void FacebookAgent::login(FBCallback cb)
    {
        agentManager->getUserPlugin()->login(cb);
    }
    
    void FacebookAgent::logout()
    {
        agentManager->getUserPlugin()->logout();
    }
    bool FacebookAgent::isLoggedIn()
    {
        return agentManager->getUserPlugin()->isLoggedIn();
    }
    
    void FacebookAgent::requestPermissions(std::string permissions, FBCallback cb)
    {
        auto userPlugin = agentManager->getUserPlugin();
        userPlugin->setCallback(cb);
        PluginParam _permissions(permissions.c_str());
        userPlugin->callFuncWithParam("requestPermissions", &_permissions, NULL);
    }
    std::string FacebookAgent::getAccessToken()
    {
        return agentManager->getUserPlugin()->callStringFuncWithParam("getAccessToken", NULL);
    }
    
    void FacebookAgent::share(FBInfo& info, FBCallback cb)
    {
        agentManager->getSharePlugin()->share(info, cb);
    }
    
    void FacebookAgent::dialog(FBInfo& info, FBCallback cb)
    {
        auto sharePlugin = agentManager->getSharePlugin();
        sharePlugin->setCallback(cb);
        PluginParam params(info);
        sharePlugin->callFuncWithParam("dialog", &params, NULL);
    }
    
    void FacebookAgent::request(std::string &path, int method, FBInfo &params, FBCallback cb)
    {
        requestCallbacks.push_back(cb);
        
        PluginParam _path(path.c_str());
        PluginParam _method(method);
        PluginParam _params(params);
        PluginParam _cbIndex((int)(requestCallbacks.size() - 1));
        
        agentManager->getUserPlugin()->callFuncWithParam("request", &_path, &_method, &_params, &_cbIndex, NULL);
    }
    
    FacebookAgent::FBCallback FacebookAgent::getRequestCallback(int index)
    {
        return requestCallbacks[index];
    }
}}
