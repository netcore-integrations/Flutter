-keep class com.razorpay.** { *; }
-dontwarn com.google.protobuf.java_com_google_android_gmscore_sdk_target_granule__proguard_group_gtm_N1281923064GeneratedExtensionRegistryLite$Loader
 -ignorewarnings
 # Smartech Base SDK
 -dontwarn com.netcore.android.**
 -keep class com.netcore.android.**{*;}
 -keep class * implements com.netcore.android.**.* {*;}
 -keep class * extends com.netcore.android.**.* {*;}