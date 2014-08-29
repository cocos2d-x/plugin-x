
--------------------------------
-- @module ProtocolUser
-- @extend PluginProtocol
-- @parent_module plugin

--------------------------------
-- @function [parent=#ProtocolUser] setCallback 
-- @param self
-- @param #function func
        
--------------------------------
-- @overload self, function         
-- @overload self         
-- @function [parent=#ProtocolUser] logout
-- @param self
-- @param #function func

--------------------------------
-- @function [parent=#ProtocolUser] getCallback 
-- @param self
-- @return function#function ret (return value: function)
        
--------------------------------
-- @function [parent=#ProtocolUser] isLoggedIn 
-- @param self
-- @return bool#bool ret (return value: bool)
        
--------------------------------
-- @overload self, function         
-- @overload self         
-- @function [parent=#ProtocolUser] login
-- @param self
-- @param #function func

--------------------------------
-- @function [parent=#ProtocolUser] getSessionID 
-- @param self
-- @return string#string ret (return value: string)
        
--------------------------------
-- @function [parent=#ProtocolUser] getAccessToken 
-- @param self
-- @return string#string ret (return value: string)
        
return nil
