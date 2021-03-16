package com.example.offtime_flutter_java;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        final MyBroadCastReceiver myBroadCastReceiver = new MyBroadCastReceiver();
        Intent intent = registerReceiver(myBroadCastReceiver, myBroadCastReceiver.getFilter());
//        System.out.println(intent);
        new MethodChannel(this.getFlutterEngine().getDartExecutor().getBinaryMessenger(),"com.example.flutter_app").setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                        if(call.method.equals("giveState")){

                            result.success(MyBroadCastReceiver.ScreenState);
                        }
                    }
                }
        );

    }
    
    

}
