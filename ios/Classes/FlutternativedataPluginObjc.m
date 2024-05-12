//
//  FlutternativedataPluginObjc.m
//  flutternativedata
//
//  Created by APPLE on 5/12/24.
//

#import "FlutternativedataPluginObjc.h"
#import <UIKit/UIKit.h>

@implementation FlutternativedataPluginObjc


+(void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutternativedata"
            binaryMessenger:[registrar messenger]];
  FlutternativedataPluginObjc* instance = [[FlutternativedataPluginObjc alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}


+ (NSDictionary *)getDeviceInfo {
    NSMutableDictionary *deviceInfo = [NSMutableDictionary dictionary];
    
    // Get device model
    [deviceInfo setObject:[UIDevice currentDevice].model forKey:@"deviceModel"];
    
    // Get device name
    [deviceInfo setObject:[UIDevice currentDevice].name forKey:@"deviceName"];
    
    // Get system version
    [deviceInfo setObject:[UIDevice currentDevice].systemVersion forKey:@"systemVersion"];
    
    // Get localized model
    [deviceInfo setObject:[UIDevice currentDevice].localizedModel forKey:@"localizedModel"];
    
    // Get identifier for vendor
    [deviceInfo setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"identifierForVendor"];
    
    return [deviceInfo copy];
}

@end
