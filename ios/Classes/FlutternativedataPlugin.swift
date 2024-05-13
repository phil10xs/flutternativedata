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
            UIDevice.current.isBatteryMonitoringEnabled = true
            let batteryLevel = UIDevice.current.batteryLevel
            let batteryLevelPercentage = Int(batteryLevel * 100)
            result(batteryLevelPercentage)
        case "getDeviceInfo":
            result(getDeviceInfo())
        case "getMemoryInfo":
            result(getMemoryInfo())
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
        return deviceInfo
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
