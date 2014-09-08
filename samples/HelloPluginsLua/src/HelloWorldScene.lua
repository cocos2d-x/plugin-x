require "Cocos2d"
require "Cocos2dConstants"

local HelloWorldScene = class("HelloWorldScene",function()
    return cc.Scene:create()
end)

function HelloWorldScene.create()
    local scene = HelloWorldScene.new()
    scene:addChild(scene:createLayerMenu())
    return scene
end

function HelloWorldScene:createLayerMenu()
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local menu = cc.Menu:create()
    for i, plugin in ipairs({"IAP", "Ads", "Share", "Social", "User"}) do
        local item = cc.MenuItemFont:create(plugin)
        item:setPosition(0, visibleSize.height / 2 - i * 50)
        item:registerScriptTapHandler(function()
            local sceneName = string.format("Test%sScene", plugin)
            local scene = require(sceneName).create()
            cc.Director:getInstance():replaceScene(scene)
        end)
        menu:addChild(item)
    end
    return menu
end

return HelloWorldScene
