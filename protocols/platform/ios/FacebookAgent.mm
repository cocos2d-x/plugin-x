#include "FacebookAgent.h"

namespace cocos2d{namespace plugin{

static FacebookAgent* s_sharedFacebookAgent = nullptr;

FacebookAgent* FacebookAgent::getInstance()
{
	if(nullptr == s_sharedFacebookAgent)
	{
		s_sharedFacebookAgent = new FacebookAgent();
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
	AgentManager::destroyInstance();
}

void FacebookAgent::login(FBCallback cb)
{
	agentManager->getUserPlugin()->login(cb);
}

void FacebookAgent::logout(FBCallback &cb)
{
	agentManager->getUserPlugin()->logout(cb);
}

std::string FacebookAgent::getAccessToken()
{
	return agentManager->getUserPlugin()->callStringFuncWithParam("getAccessToken", NULL);
}
}}
