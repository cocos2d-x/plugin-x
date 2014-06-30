package org.cocos2dx.plugin;

import java.io.File;
import java.util.Arrays;
import java.util.Hashtable;
import java.util.Iterator;

import org.cocos2dx.plugin.InterfaceShare;
import org.json.JSONException;
import org.json.JSONObject;

import com.facebook.FacebookException;
import com.facebook.Session;
import com.facebook.model.OpenGraphAction;
import com.facebook.model.OpenGraphObject;
import com.facebook.widget.FacebookDialog;
import com.facebook.widget.WebDialog;
import com.facebook.widget.FacebookDialog.MessageDialogFeature;
import com.facebook.widget.FacebookDialog.OpenGraphActionDialogFeature;
import com.facebook.widget.FacebookDialog.OpenGraphMessageDialogFeature;
import com.facebook.widget.FacebookDialog.ShareDialogFeature;
import com.facebook.widget.WebDialog.OnCompleteListener;

import android.app.Activity;
import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.util.Log;

public class ShareFacebook implements InterfaceShare{

	private static Activity mContext = null;
	private static InterfaceShare mAdapter = null;
	private static boolean bDebug = false;
	private final static String LOG_TAG = "ShareFacebook";
	private Session session = null;
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
    	session = Session.getActiveSession();
		mContext = (Activity)context;		
		mAdapter = this;
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
	

	public void dialog(final JSONObject cpInfo){
		PluginWrapper.runOnMainThread(new Runnable(){

			@Override
			public void run() {
				try {
					String dialogType = cpInfo.getString("dialog");
					if("share_link".equals(dialogType)){
						if(FacebookDialog.canPresentShareDialog(mContext, ShareDialogFeature.SHARE_DIALOG)){
							FBShareDialog(cpInfo);
						}else{
							WebFeedDialog(cpInfo);
						}
					}
					else if("share_open_graph".equals(dialogType)){
						if(FacebookDialog.canPresentOpenGraphActionDialog(mContext, OpenGraphActionDialogFeature.OG_ACTION_DIALOG)){
							FBShareOpenGraphDialog(cpInfo);
						}
					}
					else if("share_photo".equals(dialogType)){
						if(FacebookDialog.canPresentShareDialog(mContext, ShareDialogFeature.PHOTOS)){
							FBSharePhotoDialog(cpInfo);
						}
					}
					else if("apprequests".equals(dialogType)){
						WebRequestDialog(cpInfo);
					}
					else if("message_link".equals(dialogType)){
						if(FacebookDialog.canPresentMessageDialog(mContext, MessageDialogFeature.MESSAGE_DIALOG)){
							FBMessageDialog(cpInfo);
						}
					}
					else if("message_open_graph".equals(dialogType)){
						if(FacebookDialog.canPresentOpenGraphMessageDialog(mContext, OpenGraphMessageDialogFeature.OG_MESSAGE_DIALOG)){
							FBMessageOpenGraphDialog(cpInfo);
						}
					}
					else if("message_photo".equals(dialogType)){
						if(FacebookDialog.canPresentMessageDialog(mContext, MessageDialogFeature.PHOTOS)){
							FBMessagePhotoDialog(cpInfo);
						}
					}
				} catch (JSONException e) {
					e.printStackTrace();
				}
			}
			
		});
	}
	
	private void FBShareDialog(JSONObject info) throws JSONException{
		String caption = info.getString("title");
		String link = info.getString("siteUrl");
		String description = info.getString("text");
		String picture = info.getString("imageUrl");
		String name = info.getString("site");
		FacebookDialog dialog = new FacebookDialog.ShareDialogBuilder(mContext)
										.setCaption("".equals(caption) ? info.getString("caption") : caption)
										.setLink("".equals(link) ? info.getString("link") : link)
										.setName("".equals(name) ? info.getString("name") : name)
										.setDescription("".equals(description) ? info.getString("description") : description)
										.setPicture("".equals(picture) ? info.getString("picture") : picture)
										.build();
		dialog.present();
	}
	
	private void FBShareOpenGraphDialog(JSONObject info) throws JSONException{
		String action = info.getString("action_type");
		String previewProperty = info.getString("preview_property");
		
		OpenGraphAction ogaction = OpenGraphAction.Factory.createForPost();
		OpenGraphObject ogobject = OpenGraphObject.Factory.createForPost(action);


		Iterator<String> iter = info.keys();
		while(iter.hasNext())
		{
			String key = iter.next();
			if(!"dialog".equals(key) && !"action_type".equals(key))
				ogobject.setProperty(key, (String)info.get(key));
		}
		ogaction.setData(ogobject);
		
		FacebookDialog dialog = new FacebookDialog.OpenGraphActionDialogBuilder(mContext, ogaction, previewProperty)
									.build();
		dialog.present();
	}
	
	private void FBSharePhotoDialog(JSONObject info) throws JSONException{
		String filepath = info.getString("photo");
		if("".equals(filepath)){
			LogD("Must specify one photo");
			return;
		}
		
		File file = new File(filepath);
		
		//Bitmap image = BitmapFactory.decodeFile(cpInfo.getString("photos"));
		FacebookDialog dialog = new FacebookDialog.PhotoShareDialogBuilder(mContext)
									.addPhotoFiles(Arrays.asList(file))	
									//.addPhotos(Arrays.asList(image))
									.build();
		dialog.present();
	}
	
	private void WebRequestDialog(JSONObject info) throws JSONException{
		WebDialog dialog = new WebDialog.RequestsDialogBuilder(mContext)
									
									.setMessage(info.getString("message"))
									.setTitle(info.getString("title"))
									.setTo(info.getString("to"))
									.setOnCompleteListener(new OnCompleteListener(){
	
										@Override
										public void onComplete(Bundle arg0,	FacebookException arg1) {
											ShareWrapper.onShareResult(mAdapter, ShareWrapper.SHARERESULT_SUCCESS, "share success");
										}
									})
									.build();
		dialog.show();
	}
	
	private void WebFeedDialog(JSONObject info) throws JSONException{
		
		String caption = info.getString("title");
		String link = info.getString("siteUrl");
		String description = info.getString("text");
		String picture = info.getString("imageUrl");
		String name = info.getString("site");
		
		WebDialog dialog = new WebDialog.FeedDialogBuilder(mContext)
								.setCaption("".equals(caption) ? info.getString("caption") : caption)
								.setLink("".equals(link) ? info.getString("link") : link)
								.setName("".equals(name) ? info.getString("name") : name)
								.setDescription("".equals(description) ? info.getString("description") : description)
								.setPicture("".equals(picture) ? info.getString("picture") : picture)
								.setTo(info.getString("to"))
								.setOnCompleteListener(new OnCompleteListener(){

									@Override
									public void onComplete(Bundle arg0,
											FacebookException arg1) {
										ShareWrapper.onShareResult(mAdapter, ShareWrapper.SHARERESULT_SUCCESS, "share success");
										
									}})
								.build();
		dialog.show();
	}
	
	private void FBMessageDialog(JSONObject info) throws JSONException{
		String caption = info.getString("title");
		String link = info.getString("siteUrl");
		String description = info.getString("text");
		String picture = info.getString("imageUrl");
		String name = info.getString("site");
		
		FacebookDialog dialog = new FacebookDialog.MessageDialogBuilder(mContext)
				.setCaption("".equals(caption) ? info.getString("caption") : caption)
				.setLink("".equals(link) ? info.getString("link") : link)
				.setName("".equals(name) ? info.getString("name") : name)
				.setDescription("".equals(description) ? info.getString("description") : description)
				.setPicture("".equals(picture) ? info.getString("picture") : picture)
		    	.build();
		dialog.present();
	}
	
	private void FBMessageOpenGraphDialog(JSONObject info) throws JSONException{
		String action = info.getString("action_type");
		String previewProperty = info.getString("preview_property");
		
		OpenGraphAction ogaction = OpenGraphAction.Factory.createForPost();
		OpenGraphObject ogobject = OpenGraphObject.Factory.createForPost(action);


		Iterator<String> iter = info.keys();
		while(iter.hasNext())
		{
			String key = iter.next();
			if(!"dialog".equals(key) && !"action_type".equals(key) && !"preview_property".equals(key))
				ogobject.setProperty(key, (String)info.get(key));
		}
		ogaction.setData(ogobject);
		
		FacebookDialog dialog = new FacebookDialog.OpenGraphMessageDialogBuilder(mContext, ogaction, previewProperty)
				.build();
		dialog.present();
	}
	
	private void FBMessagePhotoDialog(JSONObject info) throws JSONException{
		String filepath = info.getString("photo");
		if("".equals(filepath)){
			LogD("Must specify one photo");
			return;
		}
		
		File file = new File(filepath);
		
		FacebookDialog dialog = new FacebookDialog.PhotoMessageDialogBuilder(mContext)
									.addPhotoFiles(Arrays.asList(file))
									.build();
		dialog.present();
	}
}
