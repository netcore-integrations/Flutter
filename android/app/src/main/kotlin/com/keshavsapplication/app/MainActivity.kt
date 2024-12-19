package com.keshavsapplication.app

import io.flutter.embedding.android.FlutterActivity
import io.hansel.hanselsdk.Hansel

class MainActivity: FlutterActivity() {
     fun onCreate() {
          Hansel.pairTestDevice(getIntent().getDataString());
     }
}
