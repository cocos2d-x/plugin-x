require "Cocos2d"
require "Cocos2dConstants"

local TestUserScene = class("TestUserScene",function()
    return cc.Scene:create()
end)

function TestUserScene.create()
    local scene = TestUserScene.new()
    scene:addChild(scene:createLayerMenu())
    return scene
end

function TestUserScene:createLayerMenu()
    local back = cc.MenuItemFont:create("back")
    back:registerScriptTapHandler(function()
        cc.Director:getInstance():replaceScene(require("HelloWorldScene").create())
    end)
    return cc.Menu:create(back)
end

return TestUserScene
