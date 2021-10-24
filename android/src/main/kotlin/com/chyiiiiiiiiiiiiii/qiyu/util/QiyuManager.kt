package com.chyiiiiiiiiiiiiii.qiyu.util

import android.content.Context
import android.util.Log
import com.qiyukf.unicorn.api.*
import com.qiyukf.unicorn.api.msg.UnicornMessage
import java.util.*

class QiyuManager(private val context: Context) {
    
    companion object{
        val tag = "Qiyu"
    }

    var deviceId : String = ""

    // 七魚客服 - 初始化
    fun initQiyu(qiyuAppKey: String? = "", deviceIdentifier: String?, needLocalNotification: Boolean = false) {
        val options = getMyOptions(deviceIdentifier)
        if (needLocalNotification) {
            options.statusBarNotificationConfig = getMyStatusBarNotificationConfig()
        }
        Unicorn.init(context, qiyuAppKey, options, QiyuGlideImageLoader(context))
        Log.d(tag, "Android - initialize")
    }

    private fun getMyOptions(deviceIdentifier: String?): YSFOptions {
        val options = YSFOptions()
        if (deviceIdentifier!= null) {
            deviceId = deviceIdentifier
            // 設置省電資訊
            val savePowerConfig = SavePowerConfig()
            savePowerConfig.customPush = true
            savePowerConfig.deviceIdentifier = deviceIdentifier
            options.savePowerConfig = savePowerConfig
            // 取得漫遊訊息，合併同個用戶在不同裝置的聊天紀錄
            options.isPullMessageFromServer = true;
            Log.d(tag, "Android - deviceIdentifier - ${options.savePowerConfig.deviceIdentifier}")
        }
        return options
    }

    fun getMyStatusBarNotificationConfig(): StatusBarNotificationConfig {
        val statusBarNotificationConfig = StatusBarNotificationConfig()
//        statusBarNotificationConfig.contentTitle = ""
//        statusBarNotificationConfig.notificationSmallIconId = R.mipmap.ic_launcher
        return statusBarNotificationConfig
    }

    /**
     * 進入客服頁面
     *
     * @param context
     */
    fun showServiceActivity() {
        /**
         * 設置訪客來源，標識訪客是從哪個頁面發起諮詢的，用於客服了解用戶是從什麼頁面進入。
         * 三個參數分別為：來源頁面的url，來源頁面標題，來源頁面額外信息（保留字段，暫時無用）。
         * 設置來源後，在客服會話界面的"用戶資料"欄的頁面項，可以看到這裡設置的值。
         */
        val source = ConsultSource(null, null, null)
//        source.prompt = "連接客服成功的提示語";
//        source.VIPStaffAvatarUrl = "頭像的 url";
//        source.vipStaffName = "客服的的名字";
//        source.vipStaffWelcomeMsg = "客服的歡迎語";
        /**
         * 請注意： 調用該接口前，應先檢查Unicorn.isServiceAvailable()，
         * 如果返回為false，該接口不會有任何動作
         *
         * @param context 上下文
         * @param title   聊天窗口的標題
         * @param source  諮詢的發起來源，包括發起諮詢的url，title，描述信息等
         */
        val title = "七魚客服"
        Unicorn.openServiceActivity(context, title, source)
        Log.d(tag, "Android - showServiceActivity()")
    }

    /**
     * 設置設備的硬體ID，唯一
     */
    fun setDeviceIdentifier(deviceIdentifier: String?) {
        val options = getMyOptions(deviceIdentifier)
        Unicorn.updateOptions(options)
    }

    /**
     * 設置用戶資訊
     */
    fun setUserInfo(userId: String, userInfoDataList: String) {
        Log.d(tag, "Android - setUserInfo() - userId - $userId")
        Log.d(tag, "Android - setUserInfo() - dataList - $userInfoDataList")
        val userInfo = YSFUserInfo()
        // App 的用戶 ID
        userInfo.userId = userId
        // CRM 擴展字段
        userInfo.data = userInfoDataList
        if (Unicorn.setUserInfo(userInfo)) {
            Log.d(tag, "Android - setUserInfo() - success")
        } else {
            Log.d(tag, "Android - setUserInfo() - failure")
        }
    }

    /**
     * 監聽 - 客服未讀消息數
     *
     * @param listener
     */
    fun addUnreadCountChangeListener(listener: UnreadCountChangeListener?) {
        Unicorn.addUnreadCountChangeListener(listener, true)
    }

    /**
     * 取得最後一條消息
     */
    fun queryLastMessage(): UnicornMessage? {
        return Unicorn.queryLastMessage()
    }

    /**
     * 網易七魚客服
     * 清除文件緩存，將刪除SDK接收過的所有文件。
     * 建議在工作線程中執行該操作。
     * 該操作放到設置中 清除緩存操作下
     */
    fun clearCache() {
        Unicorn.clearCache()
    }

    /**
     * 登出使用者
     */
    fun logout() {
        Unicorn.logout()
        Log.d(tag, "Android - logout() - success")
    }
}