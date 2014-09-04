
--------------------------------
-- @module ProtocolSocial
-- @extend PluginProtocol
-- @parent_module plugin

--------------------------------
-- 
-- @function [parent=#ProtocolSocial] showLeaderboard 
-- @param self
-- @param #char leaderboardID
        
--------------------------------
-- 
-- @function [parent=#ProtocolSocial] showAchievements 
-- @param self
        
--------------------------------
-- 
-- @function [parent=#ProtocolSocial] setCallback 
-- @param self
-- @param #function cb
        
--------------------------------
-- @overload self, char, long, function         
-- @overload self, char, long         
-- @function [parent=#ProtocolSocial] submitScore
-- @param self
-- @param #char leadboardID
-- @param #long score
-- @param #function cb

--------------------------------
-- 
-- @function [parent=#ProtocolSocial] getCallback 
-- @param self
-- @return function#function ret (return value: function)
        
return nil
