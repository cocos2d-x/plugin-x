#ifndef __FACEBOOK_AGENT_H__
#define __FACEBOOK_AGENT_H__

#include "AgentManager.h"

namespace cocos2d{namespace plugin{

class FacebookAgent{

public:

	static FacebookAgent* getInstance();
	static void destroyInstance();

	typedef std::map<std::string, std::string> FBInfo;
	typedef std::function<void(int, std::string&, FBInfo&)> FBCallback;

	void login(FBCallback cb);
	void logout(FBCallback &cb);
	void getLoignStatus(FBCallback &cb);
	std::string getAccessToken();
	void share(FBInfo &info, FBCallback &cb);
	void dialog(FBInfo &info, FBCallback &cb);
	void request(FBInfo &info, FBCallback &cb);

private:
	FacebookAgent();
	~FacebookAgent();

	AgentManager* agentManager;
};

}}
#endif
