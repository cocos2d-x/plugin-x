#include <vector>

#include "AgentManager.h"
#include "PluginManager.h"
#include "ProtocolUser.h"
#include "ProtocolAnalytics.h"
#include "PluginUtils.h"

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

	PluginJniMethodInfo t;
	JNIEnv* env = PluginUtils::getEnv();

	if(PluginJniHelper::getStaticMethodInfo(t, "org/cocos2dx/plugin/PluginWrapper", "getPluginConfigure", "()Ljava/util/Hashtable;"))
	{
		jobject jhashtable = t.env->CallStaticObjectMethod(t.classID, t.methodID);
		PluginJniMethodInfo tGetMethod;
		if(PluginJniHelper::getMethodInfo(tGetMethod, "java/util/Hashtable", "get", "(Ljava/lang/Object;)Ljava/lang/Object;"))
		{
			jstring jKey;
			jstring jValue;
			std::string stdValue;

			for(std::vector<std::string>::iterator iter = s_plugins.begin(); iter != s_plugins.end(); ++iter)
			{
				jKey = env->NewStringUTF((*iter).c_str());
				jValue = (jstring) (env->CallObjectMethod(jhashtable,tGetMethod.methodID,jKey));
				stdValue = PluginJniHelper::jstring2string(jValue);
				if(!stdValue.empty())
					configure.insert(std::make_pair(*iter, stdValue));
			}

			tGetMethod.env->DeleteLocalRef(jKey);
			tGetMethod.env->DeleteLocalRef(jValue);

		}
		env->DeleteLocalRef(jhashtable);
		env->DeleteLocalRef(tGetMethod.classID);
	}
	env->DeleteLocalRef(t.classID);
	return configure;
}

}}
