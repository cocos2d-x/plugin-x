
--------------------------------
-- @module ProtocolUser
-- @extend PluginProtocol
-- @parent_module plugin

--------------------------------
-- brief set login callback function
-- @function [parent=#ProtocolUser] setCallback 
-- @param self
-- @param #function cb
        
--------------------------------
-- @overload self, function         
-- @overload self         
-- @function [parent=#ProtocolUser] logout
-- @param self
-- @param #function cb

--------------------------------
-- brief get login callback function
-- @function [parent=#ProtocolUser] getCallback 
-- @param self
-- @return function#function ret (return value: function)
        
--------------------------------
-- 
-- @function [parent=#ProtocolUser] isLoggedIn 
-- @param self
-- @return bool#bool ret (return value: bool)
        
--------------------------------
-- @overload self, function         
-- @overload self         
-- @function [parent=#ProtocolUser] login
-- @param self
-- @param #function cb

--------------------------------
-- brief Get session ID<br>
-- return If user logined, return value is session ID;<br>
-- else return value is empty string.
-- @function [parent=#ProtocolUser] getSessionID 
-- @param self
-- @return string#string ret (return value: string)
        
--------------------------------
-- brief get Access Token
-- @function [parent=#ProtocolUser] getAccessToken 
-- @param self
-- @return string#string ret (return value: string)
        
return nil
