package com.julun.lingmeng.flutter_lib

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * 自定义的FlutterActivity页面 手动添加引擎插件 支持与flutter进行局部页面通信
 * 这里适合单个flutter页面的缓存引擎加载（缓存引擎模式必须有一个默认起始路由页 虽然指定了路由到指定页面 但是返回还是会触发打开起始栈页）
 */
class CustomFlutterActivity: FlutterActivity() {

    private val MYTAG="CustomFlutterActivity"
    var mMethodChannel: MethodChannel? = null
    private var isCached: Boolean = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        val cid = intent.getStringExtra("cached_engine_id")

        isCached = cid != null
        Log.i(MYTAG, " $cid isCached=$isCached")
        Log.i(MYTAG, " flutterEngine=${flutterEngine})")
        //不是缓存的页面 手动添加插件
        if (!isCached)
            flutterEngine.plugins.add(CommunityPlugin())

        mMethodChannel = MethodChannel(
                flutterEngine.dartExecutor,
                CommunityPlugin.CHANNEL_TO_NATIVE_LOCAL
        )
        mMethodChannel?.setMethodCallHandler { call, result ->
            Log.i(MYTAG, "method=${call.method} method.args=${call.arguments} type=${call.arguments?.javaClass}")
            when(call.method ) {
                CommunityPlugin.METHOD_LOCAL -> {
                    result.success("我是activity")
                    //                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
                CommunityPlugin.METHOD_FINISH-> {
                    result.success(null)
                    finish()
                }
                else -> result.notImplemented()
            }
        }

    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        Log.i(MYTAG, "cleanUpFlutterEngine")
        super.cleanUpFlutterEngine(flutterEngine)
        this.mMethodChannel?.setMethodCallHandler(null as MethodChannel.MethodCallHandler?)
        this.mMethodChannel = null
    }


    override fun onBackPressed() {
        finish()
    }
}