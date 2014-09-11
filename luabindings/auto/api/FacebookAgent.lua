
--------------------------------
-- @module FacebookAgent
-- @parent_module plugin

--------------------------------
-- brief open the app request dialog of Facebook app<br>
-- param info share information<br>
-- param cb callback of dialog
-- @function [parent=#FacebookAgent] appRequest 
-- @param self
-- @param #map_table info
-- @param #function cb
        
--------------------------------
-- brief use Facebook Open Graph api<br>
-- param path path of Open Graph api<br>
-- param method HttpMethod<br>
-- param params request parameters<br>
-- param cb callback of request
-- @function [parent=#FacebookAgent] api 
-- @param self
-- @param #string path
-- @param #int method
-- @param #map_table params
-- @param #function cb
        
--------------------------------
-- brief Notifies the events system that the app has launched & logs an activatedApp event. 
-- @function [parent=#FacebookAgent] activateApp 
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
-- 
-- @function [parent=#FacebookAgent] getSDKVersion 
-- @param self
-- @return string#string ret (return value: string)
        
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
