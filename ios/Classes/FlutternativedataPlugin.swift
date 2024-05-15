import Flutter
import UIKit

public class FlutternativedataPlugin: NSObject, FlutterPlugin {
    
    enum CallMethod {
        case getPlatformVersion
        case getBatteryLevel
        case getDeviceInfo
        case getMemoryInfo
        case getPackageInfo
        
        public var rawValue: String {
            switch self {
            case .getPlatformVersion:
                "getPlatformVersion"
            case .getBatteryLevel:
                "getBatteryLevel"
            case .getDeviceInfo:
                "getDeviceInfo"
            case .getMemoryInfo:
                "getMemoryInfo"
            case .getPackageInfo:
                "getPackageInfo"
            }
        }
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutternativedata", binaryMessenger: registrar.messenger())
        let instance = FlutternativedataPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    /// Called if this plugin has been registered to receive `FlutterMethodCall`s.
    /// - Parameters:
    ///   - call: The method call command object.
    ///   - result: A callback for submitting the result of the call.
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let callMethod = CallMethod.self
        switch call.method {
        case callMethod.getPlatformVersion.rawValue:
            result("iOS " + UIDevice.current.systemVersion)
        case callMethod.getBatteryLevel.rawValue:
            UIDevice.current.isBatteryMonitoringEnabled = true
            let batteryLevel = UIDevice.current.batteryLevel
            let batteryLevelPercentage = Int(batteryLevel * 100)
            result(batteryLevelPercentage)
        case callMethod.getDeviceInfo.rawValue:
            result(getDeviceInfo())
        case callMethod.getMemoryInfo.rawValue:
            result(getMemoryInfo())
        case callMethod.getPackageInfo.rawValue:
            result(getPackageInfo())
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
  private func getDeviceInfo() -> [String: Any] {
    var deviceInfo = [String: Any]()
    deviceInfo["deviceModel"] = UIDevice.current.model
    deviceInfo["deviceName"] = UIDevice.current.name
    deviceInfo["systemVersion"] = UIDevice.current.systemVersion
    deviceInfo["localizedModel"] = UIDevice.current.localizedModel
    deviceInfo["identifierForVendor"] = UIDevice.current.identifierForVendor?.uuidString
    deviceInfo["deviceType"] = UIDevice.current.userInterfaceIdiom == .phone ? "Phone" : "Tablet"
    deviceInfo["deviceLanguage"] = Locale.preferredLanguages.first ?? "Unknown"
    deviceInfo["deviceCountry"] = Locale.current.regionCode ?? "Unknown"
    deviceInfo["deviceTimeZone"] = TimeZone.current.identifier
    deviceInfo["deviceManufacturer"] = "Apple" // Added
    deviceInfo["deviceBrand"] = "Apple" // Added
    deviceInfo["deviceProduct"] = "iOS Device" // Added
    deviceInfo["deviceHardware"] = "iOS Hardware" // Added
    deviceInfo["deviceOSVersion"] = UIDevice.current.systemVersion // Updated
    deviceInfo["deviceSDKVersion"] = UIDevice.current.systemVersion // Updated
    deviceInfo["deviceID"] = UIDevice.current.identifierForVendor?.uuidString ?? "Unknown" // Updated
    return deviceInfo
}


    
    private func getPackageInfo() -> [String: Any]? {
        guard let infoDictionary = Bundle.main.infoDictionary else {
            return nil
        }
        
        var packageInfo = [String: Any]()
        packageInfo["versionName"] = infoDictionary["CFBundleShortVersionString"] as? String ?? "N/A"
        packageInfo["versionCode"] = infoDictionary["CFBundleVersion"] as? String ?? "N/A"
        packageInfo["packageName"] = Bundle.main.bundleIdentifier ?? "N/A"
        
        return packageInfo
    }
    
    private func getMemoryInfo() -> [String: Any] {
        var memoryInfo = [String: Any]()
        
        // Get total memory
        // Get total memory
        let totalMemory = ProcessInfo.processInfo.physicalMemory
        memoryInfo["totalMemory"] = totalMemory
        
        // Get available memory
        var pageSize: vm_size_t = 0
        host_page_size(mach_host_self(), &pageSize)
        var vmStat: vm_statistics_data_t = vm_statistics_data_t()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.size / MemoryLayout<integer_t>.size)
        let status = withUnsafeMutablePointer(to: &vmStat) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics(mach_host_self(), HOST_VM_INFO, $0, &count)
            }
        }
        if status == KERN_SUCCESS {
            let freeMemory = UInt64(vmStat.free_count) * UInt64(pageSize)
            let usedMemory = UInt64(vmStat.active_count + vmStat.inactive_count + vmStat.wire_count) * UInt64(pageSize)
            memoryInfo["availableMemory"] = freeMemory
            memoryInfo["usedMemory"] = usedMemory
        } else {
            memoryInfo["availableMemory"] = "N/A"
            memoryInfo["usedMemory"] = "N/A"
        }
        return memoryInfo
    }
}
