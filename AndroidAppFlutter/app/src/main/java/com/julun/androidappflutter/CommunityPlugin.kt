package com.julun.lingmeng.flutter_lib

import android.content.Context
import android.content.pm.PackageManager
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.*
import io.flutter.plugin.common.EventChannel

/***
 * 通信的统一插件
 *
 * 注意：通信传参的类型是有限制的 所有[Any]类型其实都是上述限制内类型 并不是随意类型 不然会报错
 * 参考[https://flutter.cn/docs/development/platform-integration/platform-channels]
 */
open class CommunityPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

    companion object {
        const val CHANNEL_TO_FLUTTER = "plugins/channel_to_flutter"
        const val CHANNEL_TO_FLUTTER_EVENT = "plugins/channel_to_flutter_event"
        const val CHANNEL_TO_NATIVE_GLOBAL = "plugins/channel_to_native_global"
        const val CHANNEL_TO_NATIVE_LOCAL = "plugins/channel_to_native_local"

        const val METHOD_GLOBAL = "globalFun"
        const val METHOD_LOCAL = "localFun"
        const val METHOD_FINISH = "finish"
        @Deprecated("随时取不如直接存来的方便")
        const val METHOD_GET_USER_INFO = "getUserInfo"

        const val METHOD_SAVE_USER_INFO = "saveUserInfo"

       const val NATIVE_METHOD_KEY = "method"
        var messageSender: BasicMessageChannel<Any>? = null

        var mEventSink: EventChannel.EventSink? = null
        fun registerWith(registrar: PluginRegistry.Registrar) {
            val plugin = CommunityPlugin()
            plugin.setupMethodChannel(registrar.messenger(), registrar.context())
        }

        /**
         * 向flutter发送通知 flutter会去执行相应方法
         * [method]方法名
         * [params]相关方法参数
         */
        fun sendMessage(method: String ,params :MutableMap<String,Any>) {
            params[NATIVE_METHOD_KEY] = method
            messageSender?.send(params)
        }

        fun sendEvent(event: Any) {
            mEventSink?.success(event)
        }

    }

    private var mMethodChannel: MethodChannel? = null

    private var mEventChannel: EventChannel? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.i("CommunityPlugin", "onAttachedToEngine")
        this.setupMethodChannel(binding.binaryMessenger, binding.applicationContext)

    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.i("CommunityPlugin", "onDetachedFromEngine")
        this.tearDownChannel()
    }

    private fun setupMethodChannel(messenger: BinaryMessenger, context: Context) {
        this.mMethodChannel = MethodChannel(messenger, CHANNEL_TO_NATIVE_GLOBAL)
        this.mMethodChannel!!.setMethodCallHandler(this)
        //原生发送给flutter消息的方式1
        messageSender = BasicMessageChannel<Any>(messenger, CHANNEL_TO_FLUTTER, StandardMessageCodec())

        //原生发送给flutter消息的方式2
        mEventChannel = EventChannel(messenger, CHANNEL_TO_FLUTTER_EVENT)
        mEventChannel?.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(o: Any?, eventSink: EventChannel.EventSink?) {
                mEventSink = eventSink
            }

            override fun onCancel(o: Any?) {
                mEventSink = null
            }
        })

    }

    private fun tearDownChannel() {
        this.mMethodChannel!!.setMethodCallHandler(null as MethodChannel.MethodCallHandler?)
        this.mMethodChannel = null
        this.mEventChannel?.setStreamHandler(null)
        this.mEventChannel = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.i("","method=${call.method} arguments=${call.arguments}")
        try {
            when (call.method) {
                METHOD_GET_USER_INFO -> {
                    result.success(FlutterManager.getUserInfo())
                }
                else -> {
                    result.notImplemented()
                }
            }
        } catch (ex: PackageManager.NameNotFoundException) {
            result.error("Name not found", ex.message, null)
        }


    }

}
