var plugin = plugin || {PluginParam: {}, ProtocolAds: {}, ProtocolIAP: {}, ProtocolShare: {}, ProtocolSocial: {}, ProtocolUser: {}};
plugin.PluginParam = plugin.PluginParam || {};

plugin.PluginParam.ParamType = {};
plugin.PluginParam.ParamType.TypeInt = 1;
plugin.PluginParam.ParamType.TypeFloat = 2;
plugin.PluginParam.ParamType.TypeBool = 3;
plugin.PluginParam.ParamType.TypeString = 4;
plugin.PluginParam.ParamType.TypeStringMap = 5;

plugin.ProtocolAds.AdsResultCode = {};
plugin.ProtocolAds.AdsResultCode.AdsReceived = 0;
plugin.ProtocolAds.AdsResultCode.FullScreenViewShown = 1;
plugin.ProtocolAds.AdsResultCode.FullScreenViewDismissed = 2;
plugin.ProtocolAds.AdsResultCode.PointsSpendSucceed = 3;
plugin.ProtocolAds.AdsResultCode.PointsSpendFailed = 4;
plugin.ProtocolAds.AdsResultCode.NetworkError = 5;
plugin.ProtocolAds.AdsResultCode.UnknownError = 6;

plugin.ProtocolAds.AdsPos = {};
plugin.ProtocolAds.AdsPos.PosCenter = 0;
plugin.ProtocolAds.AdsPos.PosTop = 1;
plugin.ProtocolAds.AdsPos.PosTopLeft = 2;
plugin.ProtocolAds.AdsPos.PosTopRight = 3;
plugin.ProtocolAds.AdsPos.PosBottom = 4;
plugin.ProtocolAds.AdsPos.PosBottomLeft = 5;
plugin.ProtocolAds.AdsPos.PosBottomRight = 6;

plugin.ProtocolIAP.PayResultCode = {};
plugin.ProtocolIAP.PayResultCode.PaySuccess = 0;
plugin.ProtocolIAP.PayResultCode.PayFail = 1;
plugin.ProtocolIAP.PayResultCode.PayCancel = 2;
plugin.ProtocolIAP.PayResultCode.PayTimeOut = 3;

plugin.ProtocolIAP.RequestProductCode = {};
plugin.ProtocolIAP.RequestProductCode.RequestSuccess = 0;
plugin.ProtocolIAP.RequestProductCode.RequestFail = 1;
plugin.ProtocolIAP.RequestProductCode.Requestimeout = 2;

plugin.ProtocolShare.ShareResultCode = {};
plugin.ProtocolShare.ShareResultCode.ShareSuccess = 0;
plugin.ProtocolShare.ShareResultCode.ShareFail = 1;
plugin.ProtocolShare.ShareResultCode.ShareCancel = 2;
plugin.ProtocolShare.ShareResultCode.ShareTimeOut = 3;

plugin.ProtocolSocial.SocialRetCode = {};
plugin.ProtocolSocial.SocialRetCode.ScoreSubmitSuccess = 1;
plugin.ProtocolSocial.SocialRetCode.ScoreSubmitFailed = 2;
plugin.ProtocolSocial.SocialRetCode.AchUnlockSuccess = 3;
plugin.ProtocolSocial.SocialRetCode.AchUnlockFailed = 4;

plugin.ProtocolUser.UserActionResultCode = {};
plugin.ProtocolUser.UserActionResultCode.LoginSucceed = 0;
plugin.ProtocolUser.UserActionResultCode.LoginFailed = 1;
plugin.ProtocolUser.UserActionResultCode.LogoutSucceed = 2;

plugin.FacebookAgent.HttpMethod = {};
plugin.FacebookAgent.HttpMethod.Get = 0;
plugin.FacebookAgent.HttpMethod.Post = 1;
plugin.FacebookAgent.HttpMethod.Delete = 2;

plugin.FacebookAgent.CodeSucceed = 0;

plugin.FacebookAgent.prototype.logout = function(callback){
    this._logout();
    callback(2, "FacebookAgent: User logout succeed");
};

plugin.FacebookAgent.prototype.isLoggedIn = function(callback){
    if(this._isLoggedIn())
        callback(0, "FacebookAgent: User logged in");
    else
        callback(1, "FacebookAgent: User logged out")
};

plugin.FacebookAgent.prototype.requestAccessToken = function(callback){
    var at = this.getAccessToken();
    callback( at ? plugin.FacebookAgent.CodeSucceed : -1, at);
};

plugin.FacebookAgent.prototype.getSDKVersion = function(){
    return "Facebook SDK for Cocos2d-JS 1.0 alpha";
}
