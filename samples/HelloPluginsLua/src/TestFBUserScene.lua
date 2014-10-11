require "Cocos2d"
require "Cocos2dConstants"

local visibleSize = cc.Director:getInstance():getVisibleSize()
local origin = cc.Director:getInstance():getVisibleOrigin()
local posBR = cc.p(origin.x + visibleSize.width, origin.y)

local TestFBUserScene = class("TestFBUserScene",function()
    return cc.Scene:create()
end)

function TestFBUserScene.create()
    local scene = TestFBUserScene.new()
    return scene
end

function TestFBUserScene:ctor()
    local title = cc.Label:createWithSystemFont("Test Facebook user", "Arial", 32)
    title:setPosition(origin.x + visibleSize.width / 2, origin.y + visibleSize.height - 64)
    self:addChild(title)

    self:createLayerMenu()

    self.infoLabel = cc.Label:createWithSystemFont("You can see the result at this label", "Arial", 22)
    self.infoLabel:setPosition(origin.x + visibleSize.width / 2 , origin.y + visibleSize.height / 2)
    self:addChild(self.infoLabel)
end

function TestFBUserScene:createLayerMenu()

    local backItem = cc.MenuItemFont:create("Back")
    backItem:registerScriptTapHandler(function()
        cc.Director:getInstance():replaceScene(require("HelloWorldScene").create())
    end)
    local backSize = backItem:getContentSize()
    backItem:setPosition(posBR.x - backSize.width / 2, posBR.y + backSize.height / 2)
    local menu = cc.Menu:create(backItem)
    menu:setPosition(cc.p(0,0))
    self:addChild(menu, 1) 

    local menuItemNames =
    {
        {"login", function(tag, sender)
            if plugin.FacebookAgent:getInstance():isLoggedIn() then
                self.infoLabel:setString("already login in")
            else
                plugin.FacebookAgent:getInstance():login(function(ret, msg)
                    self.infoLabel:setString(string.format("type is %d, msg is %s", ret, msg))
                end
                )
            end
        end},

        {"loginWithPermission", function(tag, sender)
            local permissions = "create_event,create_note,manage_pages,publish_actions,user_about_me"
            plugin.FacebookAgent:getInstance():login(permissions, function(ret, msg)
                    self.infoLabel:setString(msg)
                end
            )
        end},

        {"logout", function(tag, sender)
            plugin.FacebookAgent:getInstance():logout()
            self.infoLabel:setString("FacebookAgent: User logout succeed")
        end},
        {"getUid", function(tag, sender)
            local path = "/me"
            --FacebookAgent::HttpMethod::Get
            plugin.FacebookAgent:getInstance():api(path, 0, {}, function(ret, msg)
                self.infoLabel:setString(msg)
            end)

        end},
        {"getToken", function(tag, sender)
            self.infoLabel:setString(plugin.FacebookAgent:getInstance():getAccessToken())
        end
        },
        {"getPermissions", function(tag, sender)
            self.infoLabel:setString(plugin.FacebookAgent:getInstance():getPermissionList())
        end
        },
        {"request API", function(tag, sender)
            local path = "/me/photos"
            local params = {url = "http://files.cocos2d-x.org/images/orgsite/logo.png"}
            plugin.FacebookAgent:getInstance():api(path, 1, params, function(ret, msg)
                if 0 == ret then
                    self.infoLabel:setString(msg)
                end
            end)
        end
        },
        {"publishInstall", function(tag, sender)
            plugin.FacebookAgent:getInstance():activateApp()
            self.infoLabel:setString("activateApp is invoked")
        end
        },
        {"logEvent", function(tag, sender)
            local appEventMsg = "fb_mobile_tutorial_completion"
            local floatVal = 888.888
            local fbInfo = { fb_success = "1" }
            plugin.FacebookAgent:getInstance():logEvent(appEventMsg)
            plugin.FacebookAgent:getInstance():logEvent(appEventMsg, floatVal)
            plugin.FacebookAgent:getInstance():logEvent(appEventMsg, fbInfo)
            plugin.FacebookAgent:getInstance():logEvent(appEventMsg, floatVal, fbInfo)
            self.infoLabel:setString("logEvent is invoked")
        end
        },

        {"logPurchase", function (tag, sender)
            local mount = 1.23
            local currency = "CNY"
            local fbInfo = {cocos2d = 1, lua = 2}
            plugin.FacebookAgent:getInstance():logPurchase(mount, currency, fbInfo)
        end
        },
    }
    local y_pos = 0
    for i = 1, table.getn(menuItemNames) do
        local label = cc.Label:createWithSystemFont(menuItemNames[i][1], "Arial", 24)
        local menuItem = cc.MenuItemLabel:create(label)
        menuItem:registerScriptTapHandler(menuItemNames[i][2])
        y_pos = visibleSize.height - 35 * (i - 1) - 100
        menuItem:setPosition(origin.x + 100, y_pos)
        menu:addChild(menuItem, 0, i -1 )
    end
end

return TestFBUserScene
