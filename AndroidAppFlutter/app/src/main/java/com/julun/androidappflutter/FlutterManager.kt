package com.julun.lingmeng.flutter_lib

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.fragment.app.Fragment
import com.julun.androidappflutter.CustomFlutterFragment
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

object FlutterManager {
    private lateinit var flutterEngine: FlutterEngine
    //默认的缓存引擎
    const val DEFAULT_ENGINE = "default_engine"

    fun init(context: Context) {
        flutterEngine = FlutterEngine(context);

        // Start executing Dart code to pre-warm the FlutterEngine.
//        flutterEngine.getNavigationChannel().setInitialRoute("springboard")
        flutterEngine.dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );

        // Cache the FlutterEngine to be used by FlutterActivity.
        FlutterEngineCache.getInstance().put(DEFAULT_ENGINE, flutterEngine)
        Log.i("FlutterManager", " flutterEngine=${flutterEngine})")
        flutterEngine.plugins.add(CommunityPlugin())
    }

    //    /***
//     * 返回当前的用户相关的信息
//     */
    fun getUserInfo(): MutableMap<String, Any> {

        val map = mutableMapOf<String, Any>()
//        map[SessionUtils.SESSION_ID] = SessionUtils.getSessionId()
//        map[SessionUtils.USER_ID] = SessionUtils.getUserId()
//        map[SessionUtils.NICK_NAME] = SessionUtils.getNickName()
//        map[SessionUtils.USERTYPE] = SessionUtils.getUserType()
//
//        map[SessionUtils.IS_REG_USER] = SessionUtils.getIsRegUser()
        return map
    }

    /***
     * 保存当前的用户相关的信息 方便后续使用
     */
    fun saveUserInfo() {

        val map = mutableMapOf<String, Any>()
//        map[SessionUtils.SESSION_ID] = SessionUtils.getSessionId()
//        map[SessionUtils.USER_ID] = SessionUtils.getUserId()
//        map[SessionUtils.NICK_NAME] = SessionUtils.getNickName()
//        map[SessionUtils.USERTYPE] = SessionUtils.getUserType()
//
//        map[SessionUtils.IS_REG_USER] = SessionUtils.getIsRegUser()
        map["SESSION_ID"] = "284ae7fb800f41ec9aa5a3b71e423dce"
        CommunityPlugin.sendMessage(CommunityPlugin.METHOD_SAVE_USER_INFO, map)
    }

    /**
     *
     * 使用新引擎模式打开指定页面 每次会创建新引擎
     * [activity]代表起始页面 [route]指要打开的flutter起始页面
     * [transparent]代表是否透明整个窗体背景 不指定默认不透明的背景 注意透明状态 内容会上移至状态栏需要专门处理
     *
     * "/"代表默认导航到首页
     *
     */
    fun navigateWithNewEngine(activity: Activity, route: String = "/", transparent: Boolean = false) {

        val intent = Intent(activity, CustomFlutterActivity::class.java)
        intent.putExtra("initial_route", route)
        if (transparent) {
            intent.putExtra("background_mode", "transparent")
        }

        activity.startActivity(intent)
    }

    /**
     *
     * 使用缓存引擎模式打开指定页面 这种是预热过的 理论上打开速度最快
     * [activity]代表起始页面 [route]指要打开的flutter页面 [cachedEngineId]代表使用哪个缓存的引擎打开
     * [transparent]代表是否透明整个窗体背景 不指定默认不透明的背景
     *
     *
     * CachedEngine模式 初始路由只在引擎创建时有效 后续改动无效
     * 可以使用engine.navigationChannel.pushRoute()启动指定路由
     * "/"代表默认导航到首页
     *
     */
    fun navigateWithCachedEngine(activity: Activity, route: String? = null, cachedEngineId: String = DEFAULT_ENGINE, transparent: Boolean = false) {

        val engine = FlutterEngineCache.getInstance().get(cachedEngineId) ?: return
        if (route != null && route.isNotEmpty()) {
            engine.navigationChannel.pushRoute(route)
        }
        val intent = Intent(activity, CustomFlutterActivity::class.java)

        intent.putExtra("cached_engine_id", DEFAULT_ENGINE)
        if (transparent) {
            intent.putExtra("background_mode", "transparent")
        }

        activity.startActivity(intent)
    }

    /**
     *
     * 使用缓存引擎创建FlutterFragment
     * 由于自定义的Fragment无法通过官方的构造创建或者无法自定义部分参数 这里全部手动自己组装参数
     * [route]指要打开的flutter页面
     * [cachedEngineId]代表使用哪个缓存的引擎打开
     * [destroyEngineWithFragment] True if the {@link FlutterEngine} in the created {@code FlutterFragment} should be destroyed
     * when the {@code FlutterFragment} is destroyed, false if the {@link FlutterEngine} should
     * outlive the {@code FlutterFragment}.
     *
     * [shouldAttachEngineToActivity]
     *
     * [renderMode]Render Flutter either as a {@link FlutterView.RenderMode#surface} or a
     * {@link FlutterView.RenderMode#texture}. You should use {@code surface} unless
     * you have a specific reason to use {@code texture}. {@code texture} comes with
     * a significant performance impact, but {@code texture} can be displayed
     * beneath other Android {@code View}s and animated, whereas {@code surface}
     * cannot.
     *
     *
     */
    fun createFragmentWithCachedEngine(route: String? = null, cachedEngineId: String = DEFAULT_ENGINE,
                                       destroyEngineWithFragment: Boolean = false,
                                       shouldAttachEngineToActivity: Boolean = true,
                                       renderMode: FlutterView.RenderMode = FlutterView.RenderMode.surface,
                                       transparencyMode: FlutterView.TransparencyMode = FlutterView.TransparencyMode.transparent): Fragment? {
        val engine = FlutterEngineCache.getInstance().get(cachedEngineId) ?: return null
        if (route != null && route.isNotEmpty()) {
            engine.navigationChannel.pushRoute(route)
        }
        val fFragment = CustomFlutterFragment() as Fragment
        fFragment.arguments?.putString("cached_engine_id", cachedEngineId)
        fFragment.arguments?.putString("flutterview_render_mode", renderMode.name)
        fFragment.arguments?.putString("flutterview_transparency_mode", transparencyMode.name)
        fFragment.arguments?.putBoolean("destroy_engine_with_fragment", destroyEngineWithFragment)
        fFragment.arguments?.putBoolean("should_attach_engine_to_activity", shouldAttachEngineToActivity)
        return fFragment
    }

    /**
     *
     * 使用new引擎创建FlutterFragment
     * 由于自定义的Fragment无法通过官方的构造创建或者无法自定义部分参数 这里全部手动自己组装参数
     * [route]指要打开的flutter页面
     *
     * [shouldAttachEngineToActivity]
     *
     * [renderMode]Render Flutter either as a {@link FlutterView.RenderMode#surface} or a
     * {@link FlutterView.RenderMode#texture}. You should use {@code surface} unless
     * you have a specific reason to use {@code texture}. {@code texture} comes with
     * a significant performance impact, but {@code texture} can be displayed
     * beneath other Android {@code View}s and animated, whereas {@code surface}
     * cannot.
     *
     *
     */
    fun createFragmentWithNewEngine(route: String = "/",
                                       shouldAttachEngineToActivity: Boolean = true,
                                       renderMode: FlutterView.RenderMode = FlutterView.RenderMode.surface,
                                       transparencyMode: FlutterView.TransparencyMode = FlutterView.TransparencyMode.transparent): Fragment? {

        val fFragment = CustomFlutterFragment() as Fragment
        fFragment.arguments?.putString("initial_route", route)
        fFragment.arguments?.putString("flutterview_render_mode", renderMode.name)
        fFragment.arguments?.putString("flutterview_transparency_mode", transparencyMode.name)
        fFragment.arguments?.putBoolean("destroy_engine_with_fragment", true)
        fFragment.arguments?.putBoolean("should_attach_engine_to_activity", shouldAttachEngineToActivity)
        return fFragment
    }
}