/**
 * @module pluginx_protocols
 */
var plugin = plugin || {};

/**
 * @class PluginProtocol
 */
plugin.PluginProtocol = {

/**
 * @method getPluginName
 * @return {char}
 */
getPluginName : function (
)
{
    return 0;
},

/**
 * @method getPluginVersion
 * @return {String}
 */
getPluginVersion : function (
)
{
    return ;
},

/**
 * @method getSDKVersion
 * @return {String}
 */
getSDKVersion : function (
)
{
    return ;
},

/**
 * @method setDebugMode
 * @param {bool} arg0
 */
setDebugMode : function (
bool 
)
{
},

};

/**
 * @class PluginManager
 */
plugin.PluginManager = {

/**
 * @method unloadPlugin
 * @param {char} arg0
 */
unloadPlugin : function (
char 
)
{
},

/**
 * @method loadPlugin
 * @param {char} arg0
 * @return {cc.plugin::PluginProtocol}
 */
loadPlugin : function (
char 
)
{
    return cc.plugin::PluginProtocol;
},

/**
 * @method end
 */
end : function (
)
{
},

/**
 * @method getInstance
 * @return {cc.plugin::PluginManager}
 */
getInstance : function (
)
{
    return cc.plugin::PluginManager;
},

};

/**
 * @class ProtocolAnalytics
 */
plugin.ProtocolAnalytics = {

/**
 * @method logTimedEventBegin
 * @param {char} arg0
 */
logTimedEventBegin : function (
char 
)
{
},

/**
 * @method logError
 * @param {char} arg0
 * @param {char} arg1
 */
logError : function (
char, 
char 
)
{
},

/**
 * @method setCaptureUncaughtException
 * @param {bool} arg0
 */
setCaptureUncaughtException : function (
bool 
)
{
},

/**
 * @method setSessionContinueMillis
 * @param {long} arg0
 */
setSessionContinueMillis : function (
long 
)
{
},

/**
 * @method logEvent
 * @param {char} arg0
 * @param {map_object} arg1
 */
logEvent : function (
char, 
map 
)
{
},

/**
 * @method startSession
 * @param {char} arg0
 */
startSession : function (
char 
)
{
},

/**
 * @method stopSession
 */
stopSession : function (
)
{
},

/**
 * @method logTimedEventEnd
 * @param {char} arg0
 */
logTimedEventEnd : function (
char 
)
{
},

};

/**
 * @class ProtocolIAP
 */
plugin.ProtocolIAP = {

/**
 * @method payForProduct
* @param {map_object|map_object} map
* @param {function} func
*/
payForProduct : function(
map,
func 
)
{
},

/**
 * @method setCallback
 * @param {function} arg0
 */
setCallback : function (
func 
)
{
},

/**
 * @method onPayResult
 * @param {cc.plugin::PayResultCode} arg0
 * @param {char} arg1
 */
onPayResult : function (
payresultcode, 
char 
)
{
},

/**
 * @method getCallback
 * @return {function}
 */
getCallback : function (
)
{
    return std::function<void (int, std::basic_string<char> &)>;
},

/**
 * @method configDeveloperInfo
 * @param {map_object} arg0
 */
configDeveloperInfo : function (
map 
)
{
},

};

/**
 * @class ProtocolAds
 */
plugin.ProtocolAds = {

/**
 * @method showAds
 * @param {map_object} arg0
 * @param {cc.plugin::ProtocolAds::AdsPos} arg1
 */
showAds : function (
map, 
adspos 
)
{
},

/**
 * @method hideAds
 * @param {map_object} arg0
 */
hideAds : function (
map 
)
{
},

/**
 * @method queryPoints
 */
queryPoints : function (
)
{
},

/**
 * @method getCallback
 * @return {function}
 */
getCallback : function (
)
{
    return std::function<void (int, std::basic_string<char> &)>;
},

/**
 * @method setCallback
 * @param {function} arg0
 */
setCallback : function (
func 
)
{
},

/**
 * @method spendPoints
 * @param {int} arg0
 */
spendPoints : function (
int 
)
{
},

/**
 * @method configDeveloperInfo
 * @param {map_object} arg0
 */
configDeveloperInfo : function (
map 
)
{
},

};

/**
 * @class ProtocolShare
 */
plugin.ProtocolShare = {

/**
 * @method setCallback
 * @param {function} arg0
 */
setCallback : function (
func 
)
{
},

/**
 * @method share
* @param {map_object|map_object} map
* @param {function} func
*/
share : function(
map,
func 
)
{
},

/**
 * @method onShareResult
 * @param {cc.plugin::ShareResultCode} arg0
 * @param {char} arg1
 */
onShareResult : function (
shareresultcode, 
char 
)
{
},

/**
 * @method getCallback
 * @return {function}
 */
getCallback : function (
)
{
    return std::function<void (int, std::basic_string<char> &)>;
},

/**
 * @method configDeveloperInfo
 * @param {map_object} arg0
 */
configDeveloperInfo : function (
map 
)
{
},

};

/**
 * @class ProtocolSocial
 */
plugin.ProtocolSocial = {

/**
 * @method showLeaderboard
 * @param {char} arg0
 */
showLeaderboard : function (
char 
)
{
},

/**
 * @method showAchievements
 */
showAchievements : function (
)
{
},

/**
 * @method setCallback
 * @param {function} arg0
 */
setCallback : function (
func 
)
{
},

/**
 * @method submitScore
* @param {char|char} char
* @param {long|long} long
* @param {function} func
*/
submitScore : function(
char,
long,
func 
)
{
},

/**
 * @method getCallback
 * @return {function}
 */
getCallback : function (
)
{
    return std::function<void (int, std::basic_string<char> &)>;
},

/**
 * @method configDeveloperInfo
 * @param {map_object} arg0
 */
configDeveloperInfo : function (
map 
)
{
},

/**
 * @method unlockAchievement
* @param {map_object|map_object} map
* @param {function} func
*/
unlockAchievement : function(
map,
func 
)
{
},

};

/**
 * @class ProtocolUser
 */
plugin.ProtocolUser = {

/**
 * @method setCallback
 * @param {function} arg0
 */
setCallback : function (
func 
)
{
},

/**
 * @method logout
* @param {function} func
*/
logout : function(
func 
)
{
},

/**
 * @method getCallback
 * @return {function}
 */
getCallback : function (
)
{
    return std::function<void (int, std::basic_string<char> &)>;
},

/**
 * @method configDeveloperInfo
 * @param {map_object} arg0
 */
configDeveloperInfo : function (
map 
)
{
},

/**
 * @method isLoggedIn
 * @return {bool}
 */
isLoggedIn : function (
)
{
    return false;
},

/**
 * @method login
* @param {function} func
*/
login : function(
func 
)
{
},

/**
 * @method getSessionID
 * @return {String}
 */
getSessionID : function (
)
{
    return ;
},

/**
 * @method getAccessToken
 * @return {String}
 */
getAccessToken : function (
)
{
    return ;
},

};

/**
 * @class AgentManager
 */
plugin.AgentManager = {

/**
 * @method getSocialPlugin
 * @return {cc.plugin::ProtocolSocial}
 */
getSocialPlugin : function (
)
{
    return cc.plugin::ProtocolSocial;
},

/**
 * @method getAdsPlugin
 * @return {cc.plugin::ProtocolAds}
 */
getAdsPlugin : function (
)
{
    return cc.plugin::ProtocolAds;
},

/**
 * @method purge
 */
purge : function (
)
{
},

/**
 * @method getUserPlugin
 * @return {cc.plugin::ProtocolUser}
 */
getUserPlugin : function (
)
{
    return cc.plugin::ProtocolUser;
},

/**
 * @method init
 * @param {map_object} arg0
 * @return {bool}
 */
init : function (
map 
)
{
    return false;
},

/**
 * @method getIAPPlugin
 * @return {cc.plugin::ProtocolIAP}
 */
getIAPPlugin : function (
)
{
    return cc.plugin::ProtocolIAP;
},

/**
 * @method getSharePlugin
 * @return {cc.plugin::ProtocolShare}
 */
getSharePlugin : function (
)
{
    return cc.plugin::ProtocolShare;
},

/**
 * @method getAnalyticsPlugin
 * @return {cc.plugin::ProtocolAnalytics}
 */
getAnalyticsPlugin : function (
)
{
    return cc.plugin::ProtocolAnalytics;
},

/**
 * @method initWithConfigureFile
 * @return {bool}
 */
initWithConfigureFile : function (
)
{
    return false;
},

/**
 * @method destroyInstance
 */
destroyInstance : function (
)
{
},

/**
 * @method getInstance
 * @return {cc.plugin::AgentManager}
 */
getInstance : function (
)
{
    return cc.plugin::AgentManager;
},

};

/**
 * @class FacebookAgent
 */
plugin.FacebookAgent = {

/**
 * @method api
 * @param {String} arg0
 * @param {int} arg1
 * @param {map_object} arg2
 * @param {function} arg3
 */
api : function (
str, 
int, 
map, 
func 
)
{
},

/**
 * @method activateApp
 */
activateApp : function (
)
{
},

/**
 * @method dialog
 * @param {map_object} arg0
 * @param {function} arg1
 */
dialog : function (
map, 
func 
)
{
},

/**
 * @method appRequest
 * @param {map_object} arg0
 * @param {function} arg1
 */
appRequest : function (
map, 
func 
)
{
},

/**
 * @method getUserID
 * @return {String}
 */
getUserID : function (
)
{
    return ;
},

/**
 * @method getRequestCallback
 * @param {int} arg0
 * @return {function}
 */
getRequestCallback : function (
int 
)
{
    return std::function<void (int, std::basic_string<char> &)>;
},

/**
 * @method logEvent
* @param {String|String|String|String} str
* @param {float|map_object|float} float
* @param {map_object} map
*/
logEvent : function(
str,
float,
map 
)
{
},

/**
 * @method logout
 */
logout : function (
)
{
},

/**
 * @method getSDKVersion
 * @return {String}
 */
getSDKVersion : function (
)
{
    return ;
},

/**
 * @method logPurchase
* @param {float|float} float
* @param {String|String} str
* @param {map_object} map
*/
logPurchase : function(
float,
str,
map 
)
{
},

/**
 * @method isLoggedIn
 * @return {bool}
 */
isLoggedIn : function (
)
{
    return false;
},

/**
 * @method login
* @param {String|function} str
* @param {function} func
*/
login : function(
str,
func 
)
{
},

/**
 * @method canPresentDialogWithParams
 * @param {map_object} arg0
 * @return {bool}
 */
canPresentDialogWithParams : function (
map 
)
{
    return false;
},

/**
 * @method getAccessToken
 * @return {String}
 */
getAccessToken : function (
)
{
    return ;
},

/**
 * @method destroyInstance
 */
destroyInstance : function (
)
{
},

/**
 * @method getInstance
 * @return {cc.plugin::FacebookAgent}
 */
getInstance : function (
)
{
    return cc.plugin::FacebookAgent;
},

};
