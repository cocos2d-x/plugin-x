require "Cocos2d"
require "Cocos2dConstants"

local visibleSize = cc.Director:getInstance():getVisibleSize()
local origin = cc.Director:getInstance():getVisibleOrigin()
local posBR = cc.p(origin.x + visibleSize.width, origin.y)

local TestFBShareScene = class("TestFBShareScene",function()
    return cc.Scene:create()
end)

function TestFBShareScene.create()
    local scene = TestFBShareScene.new()
    return scene
end

function TestFBShareScene:ctor()
    local title = cc.Label:createWithSystemFont("Test Facebook share", "Arial", 32)
    title:setPosition(origin.x + visibleSize.width / 2, origin.y + visibleSize.height - 64)
    self:addChild(title)
    self:createLayerMenu()
end

function TestFBShareScene:sceenshot(filename)
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()
    local tex = cc.RenderTexture:create(visibleSize.width, visibleSize.height, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)
    tex:setPosition((origin.x + visibleSize.width) / 2, (origin.y + visibleSize.height) / 2)
    tex:begin()
    cc.Director:getInstance():getRunningScene():visit()
    tex:endToLua()
    
    local imgPath = cc.FileUtils:getInstance():getWritablePath()
    if imgPath == "" then 
        return ""
    end
    
    
    local ret = tex:saveToFile(filename, cc.IMAGE_FORMAT_JPEG)
    if ret then
        imgPath = imgPath .. filename
        print(string.format("save image to %s", imgPath))
        return imgPath
    end

    return ""
end

function TestFBShareScene:createLayerMenu()

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
        {"Share link", function(tag, sender)
            local params = {
                dialog = "share_link",
                description = "Cocos2d-x is a great game engine",
                title  = "Cocos2d-x",
                link   = "http://www.cocos2d-x.org",
                imageUrl = "http://files.cocos2d-x.org/images/orgsite/logo.png",
            }
            plugin.FacebookAgent:getInstance():share(params, function(ret, msg)
                print(msg)
            end)
        end},

        {"Share open graph", function(tag, sender)
            local params = {
            dialog = "share_open_graph",
            action_type = "pluginlua:share",
            preview_property =  "cocos_document",
            title = "Cocos2d-x Game Engine",
            image =  "http://files.cocos2d-x.org/images/orgsite/logo.png",
            url = "http://cocos2d-x.org/docs/catalog/en",
            description = "cocos document",
            }
            
            plugin.FacebookAgent:getInstance():dialog(params, function(ret, msg)
                print(msg)
            end)
        end},

        {"Share photo", function(tag, sender)
            local fileName = "facebookshare.jpg"
            local imgPath = self:sceenshot(fileName)
            
            local delay = cc.DelayTime:create(2.0)
            local share = cc.CallFunc:create(function( ... )
                    local params = {
                        dialog = "share_photo",
                        photo  = imgPath,
                    }
                    plugin.FacebookAgent:getInstance():dialog(params, function(ret, msg)
                        print(msg)
                    end)
                end)
            
            local seq = cc.Sequence:create(delay, share)
            self:runAction(seq)
        end},
        {"Link message", function(tag, sender)
            local params = {
                dialog = "message_link",
                description =  "Cocos2d-x is a great game engine",
                title = "Cocos2d-x",
                link = "http://www.cocos2d-x.org",
                imageUrl = "http://files.cocos2d-x.org/images/orgsite/logo.png",
            }
            plugin.FacebookAgent:getInstance():dialog(params, function(ret, msg )
                    print(msg)
                end)
        end},
        {"Open graph message", function(tag, sender)
            local params = {
                dialog = "message_open_graph",
                action_type = "pluginlua:share",
                preview_property = "cocos_document",
                title =  "Cocos2d-x Game Engine",
                image = "http://files.cocos2d-x.org/images/orgsite/logo.png",
                url =  "http://cocos2d-x.org/docs/catalog/en",
                description =  "cocos document",
            }
            plugin.FacebookAgent:getInstance():dialog(params, function(ret, msg)
                print(msg)
            end)
        end},

        {"Photo message", function(tag, sender)
            local fileName = "facebookshare.jpg"
            local imgPath = self:sceenshot(fileName)
            
            local delay = cc.DelayTime:create(2.0)
            local share = cc.CallFunc:create(function()
                local params = {
                    dialog = "message_photo",
                    photo  = imgPath,
                }
                plugin.FacebookAgent:getInstance():dialog(params, function(ret, msg)
                    print(msg)
                end)
            end)
            
            local seq = cc.Sequence:create(delay, share)
            self:runAction(seq)
        end},
        {"App request", function(tag, sender)
            local params = {
                message = "Cocos2d-x is a great game engine",
                title   = "Cocos2d-x",
            }
            plugin.FacebookAgent:getInstance():appRequest(params, function(ret, msg)
                print(msg)
            end)
        end},
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

return TestFBShareScene
