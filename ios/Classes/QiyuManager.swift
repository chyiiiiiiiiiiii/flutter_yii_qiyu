//
//  QiyuManager.swift
//  ObjectMapper
//
//  Created by Yii on 2021/10/21.
//

import Foundation
import QYSDK

public class QiyuManager: NSObject, QYConversationManagerDelegate {
    
    let TAG = "[QiyuManager]"
    
    private var arguments: Dictionary<String, Any>? = nil


    init(arguments: Dictionary<String, Any>?) {
        self.arguments = arguments
    }

    func initQiYu() {
        let appKey: String = (arguments?["appKey"] ?? "") as! String
        let appName: String = (arguments?["appName"] ?? "") as! String
//        let deviceIdentifier: String = (arguments?["deviceIdentifier"] ?? "") as! String
        //
        let qyOption: QYSDKOption = QYSDKOption(appKey: appKey)
        qyOption.appName = appName
        QYSDK.shared().register(with: qyOption)
        print("Qiyu - iOS - initialize")
        // 對話
        QYSDK.shared().conversationManager().setDelegate(self)
    }
    
    func setApnsToken() {
        let apnsToken: String = (arguments?["apnsToken"] ?? "") as! String
        QYSDK.shared().updateApnsToken(Data(base64Encoded: apnsToken))
        print("Qiyu - iOS - Apns Token - \(apnsToken)")
    }
    
    func setUserInfo() {
        print("Qiyu - iOS - setUserInfo()")
        let userId: String = (arguments?["userId"] ?? "") as! String
        let dataString: String = (arguments?["userInfoDataList"] ?? "") as! String
        print("Qiyu - iOS - userId - \(userId)")
        print("Qiyu - iOS - dataList - \(dataString)")
        // 設置用戶資訊
        let userInfo = QYUserInfo()
        userInfo.userId = userId
        userInfo.data = dataString
        //
        QYSDK.shared().setUserInfo(userInfo) { b, e in
            if let error = e {
                print("Qiyu - iOS - setUserInfo() - failure - \(error.localizedDescription)")
                return
            }
            print("Qiyu - iOS - setUserInfo() - success")
        }
    }
    
    func showCustomerService() {
        let sessionViewController: QYSessionViewController = QYSDK.shared().sessionViewController()
        sessionViewController.hidesBottomBarWhenPushed = true
        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
            rootViewController.present(sessionViewController, animated: true, completion: nil)
        }
    }
    
    func logout() {
        QYSDK.shared().logout { b in
            print("Qiyu - iOS - Log out - \(b)")
        }
    }
    
    // 未讀數量
    public func onUnreadCountChanged(_ count: Int) {
        print("Qiyu - iOS - Unread count: \(count)")
    }
    
}
