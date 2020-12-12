package com.example.befikr_app;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    @Override
    public void configureFlutterEngine(FlutterEngine engine) {
     
      // register plugins
      GeneratedPluginRegistrant.registerWith(engine);
    }
  
  }