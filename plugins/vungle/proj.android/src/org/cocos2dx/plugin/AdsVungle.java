package org.cocos2dx.plugin;

import java.util.Hashtable;

import com.vungle.publisher.VunglePub;
import com.vungle.publisher.EventListener;
import com.vungle.publisher.AdConfig;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class AdsVungle implements InterfaceAds, EventListener, PluginListener {
	private static final String LOG_TAG = "AdsVungle";
	private static final String VERSION = "0.1";
	private static Activity mContext = null;
	private static boolean bDebug = false;

	private boolean videoViewed = false;
	private String mPublishID = "";

	final VunglePub vunglePub = VunglePub.getInstance();

	protected static void LogE(String msg, Exception e) {
		Log.e(LOG_TAG, msg, e);
		e.printStackTrace();
	}

	protected static void LogD(String msg) {
		if (bDebug) {
			Log.d(LOG_TAG, msg);
		}
	}

	public AdsVungle(Context context) {
		mContext = (Activity) context;
		PluginWrapper.addListener(this);
	}

	@Override
	public void setDebugMode(boolean debug) {
		bDebug = debug;
	}

	@Override
	public String getSDKVersion() {
		return vunglePub.VERSION;
	}

	@Override
	public void configDeveloperInfo(Hashtable<String, String> devInfo) {
		try {
			mPublishID = devInfo.get("VungleID");
			vunglePub.init(mContext, mPublishID);
			LogD("init AppInfo : " + mPublishID);
		} catch (Exception e) {
			LogE("initAppInfo, The format of appInfo is wrong", e);
		}
	}

	@Override
	public void showAds(Hashtable<String, String> info, int pos) {
	    try
	    {
			AdConfig cfg = new AdConfig();
			if (info.contains("VungleIncentivized")) {
				cfg.setIncentivized(info.get("VungleIncentivized") == "1");
			}
			if (info.contains("VunglePlacement")) {
				cfg.setPlacement(info.get("VunglePlacement"));
			}
			if (info.contains("VungleSoundEnabled")) {
				cfg.setSoundEnabled(info.get("VungleSoundEnabled") == "1");
			}
			// ADD THE REST OF THE CONFIG HERE
			vunglePub.playAd(cfg);
	    } catch (Exception e) {
	        LogE("Error when show Ads ( " + info.toString() + " )", e);
	    }
	}

	@Override
	public void spendPoints(int points) {
		LogD("Vungle does not support spend points!");
	}

	@Override
	public void hideAds(Hashtable<String, String> info) {
		LogD("Vungle does not support hide ads!");
	}

	@Override
	public String getPluginVersion() {
		return VERSION;
	}

    @Override
    public void queryPoints() {
        LogD("Vungle does not support query points!");
    }

	@Override
	public void onAdEnd(boolean arg0) {
		AdsWrapper.onAdsResult(this, AdsWrapper.RESULT_CODE_AdsDismissed, (videoViewed ? "1" : "0") + "," + (arg0 ? "1" : "0"));
	}

	@Override
	public void onAdStart() {
		AdsWrapper.onAdsResult(this, AdsWrapper.RESULT_CODE_AdsShown, "OK");
	}

	@Override
	public void onAdUnavailable(String arg0) {
		AdsWrapper.onAdsResult(this, AdsWrapper.RESULT_CODE_UnknownError, "Ads Unavailable");
	}

	public void onCachedAdAvailable() {
		AdsWrapper.onAdsResult(this, AdsWrapper.RESULT_CODE_AdsReceived, "OK");
	}

	@Override
	public void onVideoView(boolean arg0, int arg1, int arg2) {
		videoViewed = arg0;
	}

	@Override
	public void onResume() {
		vunglePub.onResume();
	}

	@Override
	public void onPause() {
		vunglePub.onPause();
	}

	@Override
	public void onDestroy() {
		PluginWrapper.removeListener(this);
	}

	@Override
	public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
		return false;
	}

	@Override
	public void onAdPlayableChanged(boolean arg0) {
		// TODO Auto-generated method stub
		
	}

}
