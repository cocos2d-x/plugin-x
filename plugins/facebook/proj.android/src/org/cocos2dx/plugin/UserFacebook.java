package org.cocos2dx.plugin;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;

import java.util.Hashtable;

import org.json.JSONException;
import org.json.JSONObject;

import com.facebook.LoggingBehavior;
import com.facebook.Session;
import com.facebook.Session.OpenRequest;
import com.facebook.SessionState;
import com.facebook.Settings;
import com.facebook.model.OpenGraphAction;
import com.facebook.widget.FacebookDialog;
import com.facebook.widget.FacebookDialog.MessageDialogFeature;
import com.facebook.widget.FacebookDialog.OpenGraphActionDialogFeature;
import com.facebook.widget.FacebookDialog.OpenGraphMessageDialogFeature;
import com.facebook.widget.FacebookDialog.ShareDialogFeature;
import com.facebook.widget.WebDialog;
import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;

public class UserFacebook implements InterfaceUser{

	private Session.StatusCallback statusCallback = new SessionStatusCallback();
	private static Activity mContext = null;
	private static InterfaceUser mAdapter = null;
	public static Session session = null;
	private static boolean bDebug = true;
	private boolean isLogined = false;
	private final static String LOG_TAG = "UserFacebook";
	
	protected static void LogE(String msg, Exception e) {
        Log.e(LOG_TAG, msg, e);
        e.printStackTrace();
    }

    protected static void LogD(String msg) {
        if (bDebug) {
            Log.d(LOG_TAG, msg);
        }
    }
	
	public UserFacebook(Context context) {

		mContext = (Activity)context;
		mAdapter = this;
		Settings.addLoggingBehavior(LoggingBehavior.INCLUDE_ACCESS_TOKENS);

		session = Session.getActiveSession();
        if (session == null) {
            session = new Session(context);
        
            Session.setActiveSession(session);
            if (session.getState().equals(SessionState.CREATED_TOKEN_LOADED)) {
                session.openForRead(new Session.OpenRequest((Activity) context).setCallback(statusCallback));
            }
        }
		
	}

	@Override
	public void configDeveloperInfo(Hashtable<String, String> cpInfo) {
		// TODO Auto-generated method stub
		LogD("not supported in Facebook pluign");
	}

	@Override
	public void login() {
		PluginWrapper.runOnMainThread(new Runnable() {
            @Override
            public void run() {
            	Session session = Session.getActiveSession();
            	
                if (!session.isOpened() && !session.isClosed()) {
                	OpenRequest request = new Session.OpenRequest(mContext);
                	request.setCallback(statusCallback);
                	request.setPermissions(Arrays.asList("publish_actions"));
                	session.openForPublish(request);
                    //session.openForPublish(new Session.OpenRequest(mContext).setCallback(statusCallback));
                } else {
                    Session.openActiveSession(mContext, true, statusCallback);
                }
            } 
		});
	}

	@Override
	public void logout() {
		Session session = Session.getActiveSession();
        if (!session.isClosed()) {
            session.closeAndClearTokenInformation();
            isLogined = false;
        }
		
	}

	@Override
	public boolean isLogined() {
		return isLogined;
	}

	@Override
	public String getSessionID() {
		return null;
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
	
	public static String getAccessToken(){
		return session.getAccessToken();
	}
	
	public void Dialog(final JSONObject cpInfo){
		PluginWrapper.runOnMainThread(new Runnable(){

			@Override
			public void run() {
				try {
					String dialogType = cpInfo.getString("dialog");
					if("share".equals(dialogType)){
						if(FacebookDialog.canPresentShareDialog(mContext, ShareDialogFeature.SHARE_DIALOG)){
							FBShareDialog(cpInfo);
						}else{
							WebShareDialog(cpInfo);
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
					else if("feed".equals(dialogType)){
						WebFeedDialog(cpInfo);
					}
					else if("message".equals(dialogType)){
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
		FacebookDialog dialog = new FacebookDialog.ShareDialogBuilder(mContext)
										.setCaption(info.getString("title"))
										.setLink(info.getString("siteUrl"))
										.setDescription(info.getString("text"))
										.setPicture(info.getString("imageUrl"))
										.build();
		dialog.present();
	}
	
	private void WebShareDialog(JSONObject info) throws JSONException{
		Bundle params = new Bundle();
		params.putString("caption", info.getString("title"));
		WebDialog dialog = new WebDialog.Builder(mContext, session, "share", params).build();
		dialog.show();
	}
	
	private void FBShareOpenGraphDialog(JSONObject info) throws JSONException{
		String action = info.getString("action_type");
		String previewProperty = info.getString("previewProperty");
		FacebookDialog dialog = new FacebookDialog.OpenGraphActionDialogBuilder(mContext, OpenGraphAction.Factory.createForPost(action), previewProperty)
									.build();
		dialog.present();
	}
	
	private void FBSharePhotoDialog(JSONObject info) throws JSONException{
		String filepath = info.getString("photo");
		if(filepath.isEmpty()){
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
									.build();
		dialog.show();
	}
	
	private void WebFeedDialog(JSONObject info) throws JSONException{
		WebDialog dialog = new WebDialog.FeedDialogBuilder(mContext)
								.setCaption(info.getString("title"))
								.setLink(info.getString("siteUrl"))
								.setDescription(info.getString("text"))
								.setPicture(info.getString("imageUrl"))
								.setTo(info.getString("to"))
								.build();
		dialog.show();
	}
	
	private void FBMessageDialog(JSONObject info) throws JSONException{
		FacebookDialog dialog = new FacebookDialog.MessageDialogBuilder(mContext)
				.setLink(info.getString("siteUrl"))
			    .setCaption(info.getString("title"))
			    .setPicture(info.getString("imageUrl"))
			    .setDescription(info.getString("text"))
		    	.build();
		dialog.present();
	}
	
	private void FBMessageOpenGraphDialog(JSONObject info) throws JSONException{
		String action = info.getString("action_type");
		String previewProperty = info.getString("previewProperty");
		FacebookDialog dialog = new FacebookDialog.OpenGraphMessageDialogBuilder(mContext, OpenGraphAction.Factory.createForPost(action), previewProperty)
				.build();
		dialog.present();
	}
	
	private void FBMessagePhotoDialog(JSONObject info) throws JSONException{
		String filepath = info.getString("photo");
		if(filepath.isEmpty()){
			LogD("Must specify one photo");
			return;
		}
		
		File file = new File(filepath);
		
		FacebookDialog dialog = new FacebookDialog.PhotoMessageDialogBuilder(mContext)
									.addPhotoFiles(Arrays.asList(file))
									.build();
		dialog.present();
	}
	
	private class SessionStatusCallback implements Session.StatusCallback {
        @Override
        public void call(Session session, SessionState state, Exception exception) {
            if(false == isLogined && com.facebook.SessionState.OPENED == state)
            {
            	isLogined = true;            	
            	UserWrapper.onActionResult(mAdapter, UserWrapper.ACTION_RET_LOGIN_SUCCEED, "facebook logined");
            }
        }
    }
	
	
	
}
