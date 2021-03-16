package com.example.offtime_flutter_java;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

enum Screen {ON,OFF};
public class MyBroadCastReceiver extends BroadcastReceiver {
    static boolean ScreenState = true;
    @Override
    public void onReceive(Context context, Intent intent) {
        if (Intent.ACTION_SCREEN_OFF.equals(intent.getAction())) {
            ScreenState = false;
            Log.i("Check","false");
            System.out.println("Screen went "+ ScreenState);
//            Toast.makeText(context, "screen OFF",Toast.LENGTH_LONG).show();
        } else if (Intent.ACTION_SCREEN_ON.equals(intent.getAction())) {
            ScreenState = true;
            Log.i("Check","true");
            System.out.println("Screen went "+ ScreenState);
//            Toast.makeText(context, "screen ON",Toast.LENGTH_LONG).show();
        }

    }
    public IntentFilter getFilter(){
        final IntentFilter filter = new IntentFilter();
        filter.addAction(Intent.ACTION_SCREEN_OFF);
        filter.addAction(Intent.ACTION_SCREEN_ON);
        return filter;
    }
//    mReceiver = PowerButtonBroadcastReceiver()
//    registerReceiver(mReceiver, filter)
}

