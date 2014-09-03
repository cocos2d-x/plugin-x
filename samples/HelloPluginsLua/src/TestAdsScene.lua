require "Cocos2d"
require "Cocos2dConstants"

local TestAdsScene = class("TestAdsScene",function()
    return cc.Scene:create()
end)

function TestAdsScene.create()
    local scene = TestAdsScene.new()
    scene:addChild(scene:createLayerMenu())
    return scene
end

function TestAdsScene:createLayerMenu()
    local back = cc.MenuItemFont:create("back")
    back:registerScriptTapHandler(function()
        cc.Director:getInstance():replaceScene(require("HelloWorldScene").create())
    end)
    return cc.Menu:create(back)
end

return TestAdsScene
