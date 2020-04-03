package com.julun.androidappflutter;

import android.graphics.drawable.Drawable;
import android.util.Log;

import androidx.fragment.app.Fragment;

import com.example.appflutter.R;
import com.julun.lingmeng.flutter_lib.CommunityPlugin;

import org.jetbrains.annotations.NotNull;

import io.flutter.embedding.android.DrawableSplashScreen;
import io.flutter.embedding.android.FlutterFragment;
import io.flutter.embedding.android.SplashScreen;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * 自定义等待页的flutterFragment
 */

public class CustomFlutterFragment extends FlutterFragment {
    private boolean isCached;
    private MethodChannel mMethodChannel;

    @Override
    public void configureFlutterEngine(@NotNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        Log.i("flutterFragment", " flutterEngine=" + flutterEngine);

        Fragment current = (Fragment) this;


        String cid = current.getArguments() != null ? current.getArguments().getString("cached_engine_id") : null;

        isCached = cid != null;
        Log.i("MyFlutterActivity", " cid="+cid +"isCached="+isCached);
        Log.i("MyFlutterActivity", " flutterEngine="+flutterEngine);
        //不是缓存的页面 手动添加插件
        if (!isCached)
            flutterEngine.getPlugins().add(new CommunityPlugin());

        mMethodChannel = new MethodChannel(
                flutterEngine.getDartExecutor(),
                CommunityPlugin.CHANNEL_TO_NATIVE_LOCAL
        );
        mMethodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                if (call.method.equals(CommunityPlugin.METHOD_LOCAL)) {
                    //todo
                } else if (call.method.equals(CommunityPlugin.METHOD_FINISH)) {
                    result.success(null);
                    getActivity().finish();

                } else {
                    result.notImplemented();
                }
            }
        });
    }

    @Override
    public void cleanUpFlutterEngine(FlutterEngine flutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine);
        this.mMethodChannel.setMethodCallHandler((MethodChannel.MethodCallHandler) null);
        this.mMethodChannel = null;
    }

    @Override
    public SplashScreen provideSplashScreen() {
        Drawable splash = getContext().getResources().getDrawable(R.drawable.ic_launcher_foreground);

        // Construct a DrawableSplashScreen with the loaded splash Drawable and
        // return it.
        return new DrawableSplashScreen(splash);
    }
}
