/****************************************************************************
 Copyright (c) 2014 Chukong Technologies Inc.

 http://www.cocos2d-x.org

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 ****************************************************************************/
 
package org.cocos2dx.plugin;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import java.util.Hashtable;

import org.json.JSONException;
import org.json.JSONObject;

import com.facebook.FacebookRequestError;
import com.facebook.HttpMethod;
import com.facebook.LoggingBehavior;
import com.facebook.Request;
import com.facebook.Response;
import com.facebook.Session;
import com.facebook.Session.NewPermissionsRequest;
import com.facebook.Session.OpenRequest;
import com.facebook.SessionState;
import com.facebook.Settings;
import com.facebook.model.GraphObject;
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
    private static boolean isLogined = false;
    private final static String LOG_TAG = "UserFacebook";
    private static final List<String> allPublishPermissions = Arrays.asList(
            "publish_actions", "ads_management", "create_event", "rsvp_event",
            "manage_friendlists", "manage_notifications", "manage_pages");
    
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
                    //request.setPermissions(Arrays.asList("publish_actions"));
                    session.openForRead(request);
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
    
    public String getAccessToken(){
        return Session.getActiveSession().getAccessToken();
    }
    
    public void requestPermissions(String permissions){
        
        String[] permissonArray = permissions.split(",");
        boolean publishPermission = false;
        for (int i = 0; i < permissonArray.length; i++) {
            if (allPublishPermissions.contains(permissonArray[i])) {
                publishPermission = true;
                break;
            }
        }
        

        NewPermissionsRequest newPermissionsRequest = new NewPermissionsRequest(mContext, Arrays.asList(permissonArray));
        newPermissionsRequest.setCallback(statusCallback);
        if(publishPermission){
            session.requestNewPublishPermissions(newPermissionsRequest);    
        }else{
            session.requestNewReadPermissions(newPermissionsRequest);
        }
        
    }
    
    public void request(final JSONObject info /*String path, int method, JSONObject params, int nativeCallback*/ ){
        System.out.println(info);
        PluginWrapper.runOnMainThread(new Runnable(){

            @Override
            public void run() {
                try {
                    String path = info.getString("Param1");
                    
                    int method = info.getInt("Param2");
                    HttpMethod httpmethod = HttpMethod.values()[method];
                    
                    JSONObject jsonParameters = info.getJSONObject("Param3");
                    Bundle parameter = new Bundle();
                    Iterator it = jsonParameters.keys();
                    while(it.hasNext()){
                        String key = it.next().toString();
                        String value = jsonParameters.getString(key);
                        parameter.putString(key, value);
                    }
                    
                    final int nativeCallback = info.getInt("Param4");
                    
                    Request request = new Request(Session.getActiveSession(), path, parameter, httpmethod, new Request.Callback() {
                        
                        @Override
                        public void onCompleted(Response response) {
                            LogD(response.toString());
                            
                            FacebookRequestError error = response.getError();
                            int resultCode = error == null? 0 : error.getErrorCode();
                            
                            GraphObject graphObject = response.getGraphObject();
                            JSONObject json = graphObject == null ? new JSONObject() : graphObject.getInnerJSONObject();
                            
                            nativeRequestCallback(resultCode, json.toString(), nativeCallback);
                        }
                    });
                    request.executeAsync();
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
            
        });
                
    }
        
    private class SessionStatusCallback implements Session.StatusCallback {
        @Override
        public void call(Session session, SessionState state, Exception exception) {
            if(false == isLogined){
                if(SessionState.OPENED == state){
                    isLogined = true;
                    UserWrapper.onActionResult(mAdapter, UserWrapper.ACTION_RET_LOGIN_SUCCEED, "login success");  
                }else if(SessionState.CLOSED_LOGIN_FAILED == state /*|| SessionState.CLOSED == state*/){
                    UserWrapper.onActionResult(mAdapter, UserWrapper.ACTION_RET_LOGIN_FAILED, "login failed");
                }
                              
            }
            else{
                if(SessionState.OPENED_TOKEN_UPDATED == state){
                    UserWrapper.onActionResult(mAdapter, UserWrapper.ACTION_RET_LOGIN_SUCCEED, "request success");
                }                   
                else if(SessionState.CLOSED == state || SessionState.CLOSED_LOGIN_FAILED == state){
                    isLogined = false;
                    UserWrapper.onActionResult(mAdapter, UserWrapper.ACTION_RET_LOGIN_FAILED, "request failed");
                }                   
            }
        }
    }
        
    private native void nativeRequestCallback(int ret, String msg,int cbIndex);
}
