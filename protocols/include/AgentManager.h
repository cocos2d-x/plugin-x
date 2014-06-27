#ifndef __AGENTMANAGER_H__
#define __AGENTMANAGER_H__

#include <functional>
#include <string>
#include <map>

#include "ProtocolShare.h"
#include "ProtocolSocial.h"
#include "ProtocolIAP.h"
#include "ProtocolAds.h"
#include "ProtocolUser.h"

namespace cocos2d{namespace plugin{

class ProtocolUser;
class ProtocolAnalytics;

class AgentManager{
public:
	virtual ~AgentManager();
	static AgentManager* getInstance();
	virtual bool init();
	virtual void purge();
	void setDebugMode(bool);
	void configDeveloperInfo(std::map<std::string, std::string &> &devInfo);
	//void getSDKVersion();
	void getPluginVersion();

	//Protocol User
	void login();
	void login(std::function<void(int, std::string &)> &);
	void logout();
	bool isLogined();
	std::string getSessionID();

	//Protocol Share
	void share(TShareInfo &info);
	void share(TShareInfo &info, std::function<void(int, std::string &)> &);

	//Protocol Social
	void submitScore(std::string &leaderboardID, long score);
	void showLeaderboard(std::string &leaderboardID);
	void unlockAchievement(TAchievementInfo &achInfo);
	void showAchievements();

	//Protocol Ads
	void showAds(TAdsInfo &info);
	void hideAds(TAdsInfo &info);
	void queryPoints();
	void spendPoints(int points);

	//Protocol IAP
	void payForProduct(TProductInfo &info);

	//Protocol Analytics
	void startSession(const char* appKey);
	void stopSession();
	void setSessionContinueMillis(long millis);
	void logError(const char* errorId, const char* message);
	void logEvent(const char* eventId);
	void logTimedEventBegin(const char* eventId);
	void logTimedEventEnd(const char* eventId);
	void setCaptureUncaughtException(bool enabled);

	inline ProtocolUser* getUserPlugin()
	{
		return pUser;
	}

	inline ProtocolShare* getSharePlugin()
	{
		return pShare;
	}

	inline ProtocolSocial* getSocialPlugin()
	{
		return pSocial;
	}

	inline ProtocolAds* getAdsPlugin()
	{
		return pAds;
	}

	inline ProtocolAnalytics* getAnalyticsPlugin()
	{
		return pAnalytics;
	}

	inline ProtocolIAP* getIAPPlugin()
	{
		return pIAP;
	}

protected:
	AgentManager();
	std::map<std::string, std::string> getPluginConfigure();

	ProtocolUser *pUser;
	ProtocolShare *pShare;
	ProtocolSocial *pSocial;
	ProtocolAds *pAds;
	ProtocolAnalytics *pAnalytics;
	ProtocolIAP *pIAP;
};
}}
#endif
