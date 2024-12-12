package com.example.client

import io.flutter.embedding.android.FlutterActivity

import io.flutter.plugins.urllauncher.UrlLauncherPlugin

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        UrlLauncherPlugin.registerWith(registrarFor("io.flutter.plugins.urllauncher.UrlLauncherPlugin"))
    }
}
