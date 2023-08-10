package com.appswave.pif.pif_flutter

import android.os.Environment
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import penguin.waseela.com.PenguinAPI

class PenguinPlugin {

    companion object {
        private const val METHOD_CHANNEL = "com.appswave.pif/penguin"
        private var activity: MainActivity? = null;
        fun configure(flutterEngine: FlutterEngine, activity: MainActivity) {
            this.activity = activity;
            val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL)
            channel.setMethodCallHandler { call, result -> onMethodCall(call, result) }
        }

        private fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
            if (call.method.equals("getCurrentLocation")) {
                result.success(getCurrentLocation())
            } else if (call.method.equals("initializePenguin")) {
                result.success(initializePenguin())
            } else {
                result.notImplemented()
            }
        }

        private fun initializePenguin() : Boolean {
            PenguinAPI.setDataService("PIF_API");
            PenguinAPI.setPositionService("PIF_PE");
            PenguinAPI.SetBLEPositioningEnable(true);
            PenguinAPI.SetWiFiPositioningEnable(true);
            PenguinAPI.setSimulationModeEnabled(false, false);
            PenguinAPI.SetMode(2, 100);

            val username = "Multifloor";
            val ips: List<String> =
                listOf("https://Penguinin.pif.gov.sa", "https://Penguinin.pif.gov.sa")
            val result = PenguinAPI.initialize(username, ips, this.activity, this.activity, false).split('_').toTypedArray();

            if (result[0] != "1") {
                if (result[1] != "0") {
                    println("Error......" + PenguinAPI.GetErrorMessage(result[1].toInt()));
                } else {
                    println("initialize Error..... !");
                }
            }

            if (result[2] != "0") {
                println("Warning Code : -----" + result[2]);
                return  false;
            }
            return  true;
        }

        private fun getCurrentLocation(): String? {
            println("Location ---------" + PenguinAPI.GetMyPosition());
            return PenguinAPI.GetMyPosition();
        }
    }
}