package com.julun.androidappflutter

interface FlutterListener {
    fun call(action: FlutterAction)
}

class FlutterAction(
    var action: String? = null,
    var params: HashMap<String, Any>? = null
)