
--------------------------------
-- @module ProtocolSocial
-- @extend PluginProtocol
-- @parent_module plugin

--------------------------------
-- @function [parent=#ProtocolSocial] showLeaderboard 
-- @param self
-- @param #char char
        
--------------------------------
-- @function [parent=#ProtocolSocial] showAchievements 
-- @param self
        
--------------------------------
-- @function [parent=#ProtocolSocial] setCallback 
-- @param self
-- @param #function func
        
--------------------------------
-- @overload self, char, long, function         
-- @overload self, char, long         
-- @function [parent=#ProtocolSocial] submitScore
-- @param self
-- @param #char char
-- @param #long long
-- @param #function func

--------------------------------
-- @function [parent=#ProtocolSocial] getCallback 
-- @param self
-- @return function#function ret (return value: function)
        
return nil
