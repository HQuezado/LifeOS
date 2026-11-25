package com.lifeos.lifeos

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.lifeos.lifeos/share"
        ).setMethodCallHandler { call, result ->
            if (call.method == "shareText") {
                val text = call.argument<String>("text") ?: ""
                val subject = call.argument<String>("subject") ?: "LifeOS — Selo de Gratidão"
                val intent = Intent(Intent.ACTION_SEND).apply {
                    type = "text/plain"
                    putExtra(Intent.EXTRA_SUBJECT, subject)
                    putExtra(Intent.EXTRA_TEXT, text)
                }
                startActivity(Intent.createChooser(intent, "Enviar Selo de Gratidão"))
                result.success(true)
            } else {
                result.notImplemented()
            }
        }
    }
}
