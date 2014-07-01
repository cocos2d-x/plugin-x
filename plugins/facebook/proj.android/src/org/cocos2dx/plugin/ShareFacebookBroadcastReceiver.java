package org.cocos2dx.plugin;

import android.os.Bundle;
import android.util.Log;

import com.facebook.FacebookBroadcastReceiver;

public class ShareFacebookBroadcastReceiver extends FacebookBroadcastReceiver {

    @Override
    protected void onSuccessfulAppCall(String appCallId, String action, Bundle extras) {
        ShareWrapper.onShareResult(ShareFacebook.mAdapter, ShareWrapper.SHARERESULT_SUCCESS, "facebook share success");
    }

    @Override
    protected void onFailedAppCall(String appCallId, String action, Bundle extras) {
    	ShareWrapper.onShareResult(ShareFacebook.mAdapter, ShareWrapper.SHARERESULT_FAIL, "facebook share failed");
    }
}