require "Cocos2d"
require "Cocos2dConstants"

local TestIAPScene = class("TestIAPScene",function()
    return cc.Scene:create()
end)

function TestIAPScene.create()
    local scene = TestIAPScene.new()
    scene:addChild(scene:createLayerMenu())
    return scene
end

function TestIAPScene:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
    self.schedulerID = nil
end

function TestIAPScene:createLayerMenu()
    local back = cc.MenuItemFont:create("back")
    back:registerScriptTapHandler(function()
        cc.Director:getInstance():replaceScene(require("HelloWorldScene").create())
    end)
    local pay = cc.MenuItemFont:create("pay")
    pay:setPositionY(100)
    pay:registerScriptTapHandler(function()
        local iap = plugin.PluginManager:getInstance():loadPlugin("IOSIAP")
        iap:setDebugMode(true)
        iap:configDeveloperInfo({hoge = "foo"})
        iap:payForProduct({productId = "hoge"}, function(ret, products) print(string.format("%d, %s", ret, products)) end)
    end)
    return cc.Menu:create(back, pay)
end

return TestIAPScene
