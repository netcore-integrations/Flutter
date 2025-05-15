package com.keshavsapplication.app

import io.flutter.embedding.android.FlutterActivity
import io.hansel.hanselsdk.Hansel
import com.netcore.android.Smartech
import android.os.Bundle
import java.lang.ref.WeakReference

class MainActivity: FlutterActivity() {
     override fun onCreate(savedInstanceState: Bundle?) {
          super.onCreate(savedInstanceState)

          Hansel.pairTestDevice(getIntent().getDataString());
          val isSmartechHandledDeeplink = Smartech.getInstance(WeakReference(this)).isDeepLinkFromSmartech(intent)
          if (!isSmartechHandledDeeplink) {
               //Handle deeplink on app side
          }

     }
}
