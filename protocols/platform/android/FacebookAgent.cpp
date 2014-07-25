#include "FacebookAgent.h"

namespace cocos2d{namespace plugin{

void FacebookAgent::login(FBCallback &cb)
{
	AgentManager::getInstance()->getUserPlugin()->login(cb);
}
}}
