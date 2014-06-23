package org.cocos2dx.plugin;

import java.util.Hashtable;

import org.cocos2dx.plugin.InterfaceShare;

import com.facebook.widget.FacebookDialog;

import android.app.Activity;
import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.util.Log;

public class ShareFacebook implements InterfaceShare{

	private static Activity mContext = null;
	private static boolean bDebug = false;
	private final static String LOG_TAG = "ShareFacebook";
	
	protected static void LogE(String msg, Exception e) {
        Log.e(LOG_TAG, msg, e);
        e.printStackTrace();
    }

    protected static void LogD(String msg) {
        if (bDebug) {
            Log.d(LOG_TAG, msg);
        }
    }
    
    public ShareFacebook(Context context) {

		mContext = (Activity)context;		
	}
    
	@Override
	public void configDeveloperInfo(Hashtable<String, String> cpInfo) {
		// TODO Auto-generated method stub
		LogD("not supported in Facebook pluign");
	}

	@Override
	public void share(final Hashtable<String, String> cpInfo) {
		LogD("share invoked " + cpInfo.toString());
		if (networkReachable()) {
			PluginWrapper.runOnMainThread(new Runnable() {
				@Override
				public void run() {
					String caption = cpInfo.get("title");
					String url = cpInfo.get("siteUrl");
					String text = cpInfo.get("text");
					String picture = cpInfo.get("imageUrl");
					FacebookDialog shareDialog = new FacebookDialog.ShareDialogBuilder(mContext)
						.setCaption(caption)
						.setPicture(picture)
						.setLink(url)
						.setDescription(text)
				        .build();
					shareDialog.present();
				}
			});
		}		
	}

	@Override
	public void setDebugMode(boolean debug) {
		bDebug = debug;		
	}

	@Override
	public String getSDKVersion() {
		return "3.14.1";
	}

	@Override
	public String getPluginVersion() {
		return "0.2.0";
	}

	private boolean networkReachable() {
		boolean bRet = false;
		try {
			ConnectivityManager conn = (ConnectivityManager)mContext.getSystemService(Context.CONNECTIVITY_SERVICE);
			NetworkInfo netInfo = conn.getActiveNetworkInfo();
			bRet = (null == netInfo) ? false : netInfo.isAvailable();
		} catch (Exception e) {
			LogE("Fail to check network status", e);
		}
		LogD("NetWork reachable : " + bRet);
		return bRet;
	}
}
