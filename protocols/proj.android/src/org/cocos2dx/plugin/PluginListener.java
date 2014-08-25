package org.cocos2dx.plugin;

import android.content.Intent;

public interface PluginListener {
	public void onResume();
	public void onPause();
	public void onDestroy();
	public void onActivityResult(int requestCode, int resultCode, Intent data);
}
