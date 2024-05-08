import Flutter
import UIKit

public class FlutternativedataPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutternativedata", binaryMessenger: registrar.messenger())
    let instance = FlutternativedataPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "getBatteryLevel":
        // il est nécessaire d'activer le suivi de la batterie avant
    UIDevice.current.isBatteryMonitoringEnabled = true
 // we return the battery level in percent
    result(UIDevice.current.batteryLevel * 100)
    default:
        result(FlutterError(code: "HANDLE_ERROR", message: "method not implemented", details: nil))
              break
    }
  }
    
    
}
