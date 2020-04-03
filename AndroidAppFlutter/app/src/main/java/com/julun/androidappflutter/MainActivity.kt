package com.example.appflutter

import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity
import com.julun.lingmeng.flutter_lib.CommunityPlugin
import com.julun.lingmeng.flutter_lib.FlutterManager
import io.flutter.embedding.android.FlutterActivity
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.content_main.*

class MainActivity : AppCompatActivity() {
    companion object {
        private const val TAG_FLUTTER_FRAGMENT = "flutter_fragment"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        FlutterManager.init(this)
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setSupportActionBar(toolbar)

        fab.setOnClickListener { view ->
            //            Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
//                .setAction("Action", null).show()
            startActivity(FlutterActivity.createDefaultIntent(this))
        }

        button01.setOnClickListener {
            FlutterManager.saveUserInfo()
        }
        button2.setOnClickListener {
            //            val intent= Intent(this, CustomFlutterActivity::class.java)
//            intent.putExtra("background_mode", "transparent")
////            intent.putExtra("initial_route", "testRouterNew")
////            MyApp.flutterEngine.navigationChannel.pushRoute("testRouterNew")
//            intent.putExtra("cached_engine_id", FlutterManager.DEFAULT_ENGINE)
//
//            this.startActivity(intent)
            FlutterManager.navigateWithCachedEngine(this, transparent = true)
        }
        button3.setOnClickListener {
            var fFragment = supportFragmentManager.findFragmentByTag(TAG_FLUTTER_FRAGMENT)

            // Create and attach a FlutterFragment if one does not exist.
            if (fFragment == null) {
                val newFlutterFragment = FlutterManager.createFragmentWithCachedEngine()
                fFragment = newFlutterFragment
            }
            if (fFragment?.isAdded == true) {
                return@setOnClickListener
            }
            supportFragmentManager.beginTransaction()
                    .add(R.id.frameLayout, fFragment!!,
                            TAG_FLUTTER_FRAGMENT
                    )
                    .commit()

        }

        button_send.setOnClickListener {
            CommunityPlugin.sendMessage("testFun", hashMapOf("aaa" to 1, "bbb" to "2b"))

            CommunityPlugin.sendEvent("我是发送消息给flutter的第二种")
        }
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        // Inflate the menu; this adds items to the action bar if it is present.
        menuInflater.inflate(R.menu.menu_main, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        return when (item.itemId) {
            R.id.action_settings -> true
            else -> super.onOptionsItemSelected(item)
        }
    }
}
