package com.yulii.yulii_mobile

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.GeneratedPluginRegistrant
// import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin
// import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService

class YuliiApplication: FlutterApplication(), PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        // FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry?) {
        // FirebaseMessagingPlugin.registerWith(registry?.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
    }
}