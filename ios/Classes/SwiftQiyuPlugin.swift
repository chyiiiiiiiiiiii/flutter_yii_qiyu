import Flutter
import UIKit

public class SwiftQiyuPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "qiyu", binaryMessenger: registrar.messenger())
    let instance = SwiftQiyuPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let method = call.method
        let arguments = call.arguments as? Dictionary<String, Any>
        //
        let qiyuManager = QiyuManager(arguments: arguments, result: result)
        //
        switch(method){
        case "initialize":
            qiyuManager.initQiYu()
            break;
        case "setUserInfo":
            qiyuManager.setUserInfo()
            break;
        case "showCustomerService":
            qiyuManager.showCustomerService()
            break;
        case "logoutUser":
            qiyuManager.logout()
            break
        default:
            break
        }
        result(nil)
  }}
