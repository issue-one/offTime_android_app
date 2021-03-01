//package com.example.flutter_app;
//
//import android.content.BroadcastReceiver;
//import android.content.Context;
//import android.content.Intent;
//import android.content.IntentFilter;
//import android.util.Log;
//import android.widget.Toast;
//
//import androidx.annotation.NonNull;
//
//import io.flutter.plugin.common.MethodCall;
//import io.flutter.plugin.common.MethodChannel;
//
//enum Screen {ON,OFF};
//public class MyBroadCastReceiver extends BroadcastReceiver {
//    static String ScreenState = "Screen.ON";
//    @Override
//    public void onReceive(Context context, Intent intent) {
//        if (intent.getAction().equals(Intent.ACTION_SCREEN_OFF)) {
//            ScreenState = "Screen went OFF";
//            Log.i("Check",ScreenState);
////            System.out.println("--------- $ScreenState");
////            Toast.makeText(context, "screen OFF",Toast.LENGTH_LONG).show();
//        } else if (intent.getAction().equals(Intent.ACTION_SCREEN_ON)) {
//            ScreenState = "Screen went ON";
//            Log.i("Check",ScreenState);
////            System.out.println("--------- $ScreenState");
////            Toast.makeText(context, "screen ON",Toast.LENGTH_LONG).show();
//        }
//
//    }
//    public IntentFilter getFilter(){
//        final IntentFilter filter = new IntentFilter();
//        filter.addAction(Intent.ACTION_SCREEN_OFF);
//        filter.addAction(Intent.ACTION_SCREEN_ON);
//        return filter;
//    }
////    mReceiver = PowerButtonBroadcastReceiver()
////    registerReceiver(mReceiver, filter)
//}
//
