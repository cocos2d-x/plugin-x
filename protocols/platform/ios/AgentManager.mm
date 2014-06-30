/****************************************************************************
 Copyright (c) 2014 Chukong Technologies Inc.
 
 http://www.cocos2d-x.org
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 ****************************************************************************/

#include <vector>

#include "AgentManager.h"
#include "PluginManager.h"
#include "ProtocolUser.h"
#include "ProtocolAnalytics.h"
#include "PluginUtilsIOS.h"

namespace cocos2d{ namespace plugin{

static AgentManager* s_AgentManager = nullptr;

AgentManager::AgentManager():pUser(nullptr), pShare(nullptr), pSocial(nullptr), pAds(nullptr), pAnalytics(nullptr), pIAP(nullptr)
{

}

AgentManager::~AgentManager()
{
	this->purge();
}

void AgentManager::purge()
{
	delete pUser;
	delete pShare;
	delete pSocial;
	delete pAds;
	delete pAnalytics;
	delete pIAP;
}

AgentManager* AgentManager::getInstance()
{
	if(nullptr == s_AgentManager)
	{
		s_AgentManager = new (std::nothrow) AgentManager();
		s_AgentManager->init();
	}
	return s_AgentManager;
}

bool AgentManager::init()
{
	std::map<std::string, std::string> conf = getPluginConfigure();
	if(conf.empty())
		return false;

	for(std::map<std::string, std::string>::iterator iter = conf.begin(); iter != conf.end(); ++iter)
	{
		std::string pluginName = iter->first;
		if("PluginUser" == pluginName)
		{
			pUser = dynamic_cast<ProtocolUser *>(PluginManager::getInstance()->loadPlugin(iter->second.c_str()));
		}
		else if("PluginShare" == pluginName)
		{
			pShare = dynamic_cast<ProtocolShare *>(PluginManager::getInstance()->loadPlugin(iter->second.c_str()));
		}
		else if("PluginSocial" == pluginName)
		{
			pSocial = dynamic_cast<ProtocolSocial *>(PluginManager::getInstance()->loadPlugin(iter->second.c_str()));
		}
		else if("PluginAds" == pluginName)
		{
			pAds = dynamic_cast<ProtocolAds *>(PluginManager::getInstance()->loadPlugin(iter->second.c_str()));
		}
		else if("PluginAnalytics" == pluginName)
		{
			pAnalytics = dynamic_cast<ProtocolAnalytics *>(PluginManager::getInstance()->loadPlugin(iter->second.c_str()));
		}
		else if("PluginIAP" == pluginName)
		{
			pIAP = dynamic_cast<ProtocolIAP *>(PluginManager::getInstance()->loadPlugin(iter->second.c_str()));
		}
	}

	return true;
}

void AgentManager::login()
{
	pUser->login();
}

void AgentManager::login(std::function<void(int resultCode, std::string &msg)> &callback)
{
	pUser->setListener(callback);
	pUser->login();
}

void AgentManager::logout()
{
	pUser->logout();
}

bool AgentManager::isLogined()
{
	return pUser->isLogined();
}

std::string AgentManager::getSessionID()
{
	return pUser->getSessionID();
}

void AgentManager::share(TShareInfo &info)
{
	pShare->share(info);
}

void AgentManager::share(TShareInfo &info, std::function<void(int resultcode, std::string &msg)> &callback)
{
    pShare->setListener(callback);
    pShare->share(info);
}

void AgentManager::submitScore(std::string &leaderboardID, long score)
{
	pSocial->submitScore(leaderboardID.c_str(), score);
}

void AgentManager::showLeaderboard(std::string &leaderboardID)
{
	pSocial->showLeaderboard(leaderboardID.c_str());
}

void AgentManager::unlockAchievement(TAchievementInfo &achInfo)
{
	pSocial->unlockAchievement(achInfo);
}

void AgentManager::showAchievements()
{
	pSocial->showAchievements();
}

void AgentManager::showAds(TAdsInfo &info)
{
	pAds->showAds(info);
}

void AgentManager::hideAds(TAdsInfo &info)
{
	pAds->hideAds(info);
}

void AgentManager::queryPoints()
{
	pAds->queryPoints();
}

void AgentManager::spendPoints(int points)
{
	pAds->spendPoints(points);
}

void AgentManager::payForProduct(TProductInfo &info)
{
	pIAP->payForProduct(info);
}

void AgentManager::startSession(const char* appKey)
{
	pAnalytics->startSession(appKey);
}

void AgentManager::stopSession()
{
	pAnalytics->stopSession();
}

void AgentManager::setSessionContinueMillis(long millis)
{
	pAnalytics->setSessionContinueMillis(millis);
}

void AgentManager::logError(const char* errorId, const char* message)
{
	pAnalytics->logError(errorId, message);
}

void AgentManager::logEvent(const char* eventId)
{
	pAnalytics->logEvent(eventId);
}

void AgentManager::logTimedEventBegin(const char* eventId)
{
	pAnalytics->logTimedEventBegin(eventId);
}

void AgentManager::logTimedEventEnd(const char* eventId)
{
	pAnalytics->logTimedEventEnd(eventId);
}

void AgentManager::setCaptureUncaughtException(bool enabled)
{
	pAnalytics->setCaptureUncaughtException(enabled);
}

static std::vector<std::string> s_plugins = {"PluginUser", "PluginShare", "PluginSocial", "PluginAds", "PluginAnalytics", "PluginIAP"};

std::map<std::string, std::string> AgentManager::getPluginConfigure()
{
	std::map<std::string, std::string> configure;
    
    for(std::vector<std::string>::iterator iter = s_plugins.begin(); iter != s_plugins.end(); ++iter)
    {
        NSString *key = [NSString stringWithUTF8String:iter->c_str()];
        NSString *pluginName = [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
        if (pluginName) {
            std::string name = [pluginName UTF8String];
            configure.emplace(*iter, name);
        }
    }

	return configure;
}

}}
