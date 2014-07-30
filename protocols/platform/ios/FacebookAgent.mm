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
        FacebookAgent::destroyInstance();
    }
    
    void FacebookAgent::login(FBCallback cb)
    {
        agentManager->getUserPlugin()->login(cb);
    }
    
    void FacebookAgent::logout(FBCallback cb)
    {
        agentManager->getUserPlugin()->logout(cb);
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
