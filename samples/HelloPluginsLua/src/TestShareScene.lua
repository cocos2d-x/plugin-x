require "Cocos2d"
require "Cocos2dConstants"

local TestShareScene = class("TestShareScene",function()
    return cc.Scene:create()
end)

function TestShareScene.create()
    local scene = TestShareScene.new()
    scene:addChild(scene:createLayerMenu())
    return scene
end

function TestShareScene:createLayerMenu()
    local back = cc.MenuItemFont:create("back")
    back:registerScriptTapHandler(function()
        cc.Director:getInstance():replaceScene(require("HelloWorldScene").create())
    end)
    return cc.Menu:create(back)
end

return TestShareScene
