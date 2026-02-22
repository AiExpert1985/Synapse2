package com.example.odeen

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private var pendingResult: MethodChannel.Result? = null

    companion object {
        private const val DELETE_REQUEST_CODE = 42
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "media_utils")
            .setMethodCallHandler { call, result ->
                if (call.method == "deleteByUri") {
                    val uriString = call.arguments as? String
                    if (uriString == null) {
                        result.error("INVALID_ARG", "URI string is null", null)
                        return@setMethodCallHandler
                    }
                    deleteByUri(uriString, result)
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun deleteByUri(uriString: String, result: MethodChannel.Result) {
        val documentUri = Uri.parse(uriString)

        // file_picker returns a document provider URI; createDeleteRequest needs a MediaStore URI.
        val uri = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            MediaStore.getMediaUri(this, documentUri) ?: documentUri
        } else {
            documentUri
        }

        // Android 11+ (API 30+): createDeleteRequest shows a system confirmation dialog.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            try {
                val pendingIntent = MediaStore.createDeleteRequest(contentResolver, listOf(uri))
                pendingResult = result
                startIntentSenderForResult(
                    pendingIntent.intentSender,
                    DELETE_REQUEST_CODE,
                    null, 0, 0, 0, null
                )
            } catch (e: Exception) {
                result.error("DELETE_FAILED", e.message, null)
            }
            return
        }

        // Android 10 (API 29): direct delete; catch RecoverableSecurityException for user prompt.
        try {
            val deleted = contentResolver.delete(uri, null, null)
            result.success(deleted > 0)
        } catch (e: SecurityException) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                val recoverable = e as? android.app.RecoverableSecurityException
                if (recoverable != null) {
                    pendingResult = result
                    startIntentSenderForResult(
                        recoverable.userAction.actionIntent.intentSender,
                        DELETE_REQUEST_CODE,
                        null, 0, 0, 0, null
                    )
                    return
                }
            }
            result.error("DELETE_FAILED", e.message, null)
        } catch (e: Exception) {
            result.error("DELETE_FAILED", e.message, null)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == DELETE_REQUEST_CODE) {
            val approved = resultCode == Activity.RESULT_OK
            pendingResult?.success(approved)
            pendingResult = null
        }
    }
}
