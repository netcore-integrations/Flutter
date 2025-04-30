package com.keshavsapplication.app

import io.flutter.embedding.android.FlutterActivity
import io.hansel.hanselsdk.Hansel
import com.netcore.android.Smartech
import java.lang.ref.WeakReference

class MainActivity: FlutterActivity() {
     fun onCreate() {
          Hansel.pairTestDevice(getIntent().getDataString());
          val isSmartechHandledDeeplink = Smartech.getInstance(WeakReference(this)).isDeepLinkFromSmartech(intent)
          if (!isSmartechHandledDeeplink) {
               //Handle deeplink on app side
          }
     }
}
