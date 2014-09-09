/****************************************************************************
Copyright (c) 2012-2013 cocos2d-x.org

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
#include "TestFacebookUserScene.h"
#include "PluginManager.h"
#include "HelloWorldScene.h"
#include "Configs.h"

using namespace cocos2d;
using namespace cocos2d::plugin;

enum {
    TAG_FB_LOGIN = 0,
    TAG_FB_LOGOUT,
    TAG_FB_GETUID,
    TAG_FB_GETTOKEN,
    TAG_FB_NEW_PERMISSIONS,
    TAG_FB_GETPERMISSIONS,
    TAG_FB_REQUEST_API,
    TAG_FB_PUBLISH_INSTALL,
    TAG_FB_LOG_EVENT
};

struct FBEventMenuItem {
    std::string name;
    int tag;
};

static FBEventMenuItem s_FBMenuItem[] =
{
    {"login",  TAG_FB_LOGIN},
    {"logout", TAG_FB_LOGOUT},
    {"getUid", TAG_FB_GETUID},
    {"getToken", TAG_FB_GETTOKEN},
    {"new permissions", TAG_FB_NEW_PERMISSIONS},
    {"getPermissions", TAG_FB_GETPERMISSIONS},
    {"request API", TAG_FB_REQUEST_API},
    {"publishInstall",TAG_FB_PUBLISH_INSTALL},
    {"logEvent",TAG_FB_LOG_EVENT}
};

Scene* TestFacebookUser::scene()
{
    // 'scene' is an autorelease object
    Scene *scene = Scene::create();
    
    // 'layer' is an autorelease object
    TestFacebookUser *layer = TestFacebookUser::create();

    // add layer as a child to scene
    scene->addChild(layer);

    // return the scene
    return scene;
}

// on "init" you need to initialize your instance
bool TestFacebookUser::init()
{
    //////////////////////////////
    // 1. super init first
    if (!Layer::init())
        return false;
    
    isLogin = false;
    callbackInfo = nullptr;

    Size visibleSize = Director::getInstance()->getVisibleSize();
    Point origin = Director::getInstance()->getVisibleOrigin();
    Point posBR = Point(origin.x + visibleSize.width, origin.y);
    
    
    //2.Add Title
    auto title = Label::createWithSystemFont("Test Facebook user", "Arial", 32);
    title->setPosition(origin.x + visibleSize.width / 2, origin.y + visibleSize.height - 64);
    addChild(title);
    

    /////////////////////////////
    // 3. add a menu item with "X" image, which is clicked to quit the program
    //    you may modify it.

    // add a "close" icon to exit the progress. it's an autorelease object
    MenuItemFont *backItem = MenuItemFont::create("Back", CC_CALLBACK_1(TestFacebookUser::menuBackCallback, this));
    Size backSize = backItem->getContentSize();
    backItem->setPosition(posBR + Point(- backSize.width / 2, backSize.height / 2));

    // create menu, it's an autorelease object
    Menu* menu = Menu::create(backItem, NULL);
    menu->setPosition( Point::ZERO );
    this->addChild(menu, 1);

    float yPos = 0;
    for (int i = 0; i < sizeof(s_FBMenuItem)/sizeof(s_FBMenuItem[0]); i++) {
        Label* label = Label::createWithSystemFont(s_FBMenuItem[i].name.c_str(), "Arial", 24);
        MenuItemLabel* pMenuItem = MenuItemLabel::create(label, CC_CALLBACK_1(TestFacebookUser::eventMenuCallback, this));
        menu->addChild(pMenuItem, 0, s_FBMenuItem[i].tag);
        yPos = visibleSize.height - 35*i - 100;
        pMenuItem->setPosition( Point(origin.x + 100, yPos));
    }

    //4. create result label
    callbackInfo = Label::createWithSystemFont("You can see the result at this label", "Arial", 22);
    callbackInfo->setPosition(origin.x + visibleSize.width / 2 , origin.y + visibleSize.height / 2);
    addChild(callbackInfo);

    return true;
}

void TestFacebookUser::onExit()
{
    Layer::onExit();
}

void TestFacebookUser::eventMenuCallback(Ref* sender)
{
    MenuItemLabel* menuItem = (MenuItemLabel*)sender;

    switch (menuItem->getTag())
    {
    case TAG_FB_LOGIN:
        {
            if(FacebookAgent::getInstance()->isLoggedIn())
            {
                callbackInfo->setString("already login in");
            }
            else
            {
                FacebookAgent::getInstance()->login([=](int ret, std::string& msg){
                    callbackInfo->setString(StringUtils::format("type is %d, msg is %s", ret, msg.c_str()));
                });
            }
        }
        break;
    case TAG_FB_LOGOUT:
        {
            FacebookAgent::getInstance()->logout();
            callbackInfo->setString("FacebookAgent: User logout succeed");
        }
        break;
    case TAG_FB_GETUID:
        {
            FacebookAgent::FBInfo params;
            std::string path = "/me";
            FacebookAgent::getInstance()->api(path, FacebookAgent::HttpMethod::Get, params, [=](int ret, std::string& msg){
                    callbackInfo->setString(msg.c_str());
            });
        }
        break;
    case TAG_FB_GETTOKEN:
        {
            std::string token = FacebookAgent::getInstance()->getAccessToken();
            callbackInfo->setString(token.c_str());
        }
        break;
    case TAG_FB_NEW_PERMISSIONS:
        {
//            std::string permissins =  "create_event,create_note,manage_pages,publish_actions";
//            FacebookAgent::getInstance()->requestPermissions(permissins, [=](int ret, std::string& msg){
//                callbackInfo->setString(msg.c_str());
//            });
        }
        break;
    case TAG_FB_GETPERMISSIONS:
        {
            std::string permissionList = FacebookAgent::getInstance()->getPermissionList();
            callbackInfo->setString(permissionList.c_str());
        }
        break;
    case TAG_FB_REQUEST_API:
        {
            std::string path = "/me/photos";
            FacebookAgent::FBInfo params;
            params["url"] = "http://files.cocos2d-x.org/images/orgsite/logo.png";
            FacebookAgent::getInstance()->api(path, FacebookAgent::HttpMethod::Post, params, [=](int ret, std::string& msg){
                if (0 == ret) {
                    callbackInfo->setString(msg.c_str());
                }
            });
        }
        break;
    case TAG_FB_PUBLISH_INSTALL:
        {
            FacebookAgent::getInstance()->activateApp();
            callbackInfo->setString("activateApp is invoked");
        }
        break;
    case TAG_FB_LOG_EVENT:
        {
            std::string appEventMsg = "fb_mobile_tutorial_completion";
            float floatVal = 888.888;
            FacebookAgent::FBInfo fbInfo;
            fbInfo["fb_success"] = "1";
            FacebookAgent::getInstance()->logEvent(appEventMsg);
            FacebookAgent::getInstance()->logEvent(appEventMsg, floatVal);
            FacebookAgent::getInstance()->logEvent(appEventMsg, fbInfo);
            FacebookAgent::getInstance()->logEvent(appEventMsg, floatVal, fbInfo);
            callbackInfo->setString("logEvent is invoked");
        }
        break;
    default:
        break;
    }
}

void TestFacebookUser::menuBackCallback(Ref* sender)
{
    Scene* newScene = HelloWorld::scene();
    Director::getInstance()->replaceScene(newScene);
}
