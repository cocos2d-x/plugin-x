#ifndef __FACEBOOK_AGENT_H__
#define __FACEBOOK_AGENT_H__

#include "AgentManager.h"

namespace cocos2d{namespace plugin{

class FacebookAgent{

public:

	typedef std::map<std::string, std::string> FBInfo;
	typedef std::function<void(int, std::string&, FBInfo&)> FBCallback;

	static void login(FBCallback &cb);
	static void logout(FBCallback &cb);
	static void getLoignStatus(FBCallback &cb);
	static std::string getAccessToken();
	static void share(FBInfo &info, FBCallback &cb);
	static void dialog(FBInfo &info, FBCallback &cb);
	static void request(FBInfo &info, FBCallback &cb);

};

}}
#endif
