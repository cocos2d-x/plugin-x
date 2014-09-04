
--------------------------------
-- @module FacebookAgent
-- @parent_module plugin

--------------------------------
-- brief Notifies the events system that the app has launched & logs an activatedApp event. 
-- @function [parent=#FacebookAgent] publishInstall 
-- @param self
        
--------------------------------
-- @overload self, string, float         
-- @overload self, string         
-- @overload self, string, map_table         
-- @overload self, string, float, map_table         
-- @function [parent=#FacebookAgent] logEvent
-- @param self
-- @param #string eventName
-- @param #float valueToSum
-- @param #map_table parameters

--------------------------------
-- brief Check whether the user logined or not
-- @function [parent=#FacebookAgent] isLoggedIn 
-- @param self
-- @return bool#bool ret (return value: bool)
        
--------------------------------
-- brief log out
-- @function [parent=#FacebookAgent] logout 
-- @param self
        
--------------------------------
-- brief get permissoin list
-- @function [parent=#FacebookAgent] getPermissionList 
-- @param self
-- @return string#string ret (return value: string)
        
--------------------------------
-- brief get AccessToken
-- @function [parent=#FacebookAgent] getAccessToken 
-- @param self
-- @return string#string ret (return value: string)
        
--------------------------------
--  Destroy singleton of FacebookAgent 
-- @function [parent=#FacebookAgent] destroyInstance 
-- @param self
        
--------------------------------
--  Get singleton of FacebookAgent 
-- @function [parent=#FacebookAgent] getInstance 
-- @param self
-- @return plugin::FacebookAgent#plugin::FacebookAgent ret (return value: cc.plugin::FacebookAgent)
        
return nil
