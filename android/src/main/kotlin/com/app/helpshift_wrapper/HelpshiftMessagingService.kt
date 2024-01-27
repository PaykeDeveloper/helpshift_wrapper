package com.app.helpshift_wrapper

import android.util.Log
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.helpshift.Helpshift


class HelpshiftMessagingService : FirebaseMessagingService() {

    override fun onNewToken(token: String) {
        super.onNewToken(token)
        Helpshift.registerPushToken(token)
    }

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        super.onMessageReceived(remoteMessage)

        val data = remoteMessage.data

        // Handling push notification from Helpshift.
        // This handling is for notifications sent from Helpshift when agent replies to an issue from Helpshift dashboard.

        // Handling push notification from Helpshift.
        // This handling is for notifications sent from Helpshift when agent replies to an issue from Helpshift dashboard.
        val origin = data["origin"]
        if (origin != null && origin == "helpshift") {
            Helpshift.handlePush(data)
            return
        }

        // Handle notifications sent from client app's backend when sending proactive outbound notifications.
        // This notification does not originate from Helpshift's backend.
        // Example:
        // Payload from push notification, i.e data, contains proactive url (generated from Helpshift dashboard)
        // in the key "helpshift_proactive_link"

        // Handle notifications sent from client app's backend when sending proactive outbound notifications.
        // This notification does not originate from Helpshift's backend.
        // Example:
        // Payload from push notification, i.e data, contains proactive url (generated from Helpshift dashboard)
        // in the key "helpshift_proactive_link"
//        generateProactiveNotification(data)
    }

//    private fun generateProactiveNotification(data: Map<String, String>) {
//        val proactiveUrl = data["helpshift_proactive_link"]
//        if (Utils.isEmpty(proactiveUrl)) {
//            Log.i(TAG, "Push notification does not contain Proactive Outbound url")
//            return
//        }
//        val context = applicationContext
//        val intent = Intent(context, ProactiveNotificationActivity::class.java)
//        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
//        intent.putExtra("proactiveNotification", true)
//        intent.putExtra("proactiveLink", proactiveUrl)
//        val pendingIntentFlag = if (Build.VERSION.SDK_INT < 23) 0 else PendingIntent.FLAG_IMMUTABLE
//        val pendingIntent = PendingIntent.getActivity(context, Random().nextInt(), intent, pendingIntentFlag)
//        val builder: NotificationCompat.Builder = NotificationCompat.Builder(context).setContentTitle(data["title"]).setContentText(data["message"]).setSmallIcon(R.drawable.hs__chat_icon).setContentIntent(pendingIntent).setAutoCancel(true).setChannelId(SampleAppConfig.CHANNEL_ID)
//        if (builder != null) {
//            val notification: Notification = builder.build()
//            val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
//            notificationManager.notify(0, notification)
//        }
//    }
}