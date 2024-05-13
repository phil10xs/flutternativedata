//
//  FlutternativedataPluginObjc.h
//  flutternativedata
//
//  Created by APPLE on 5/12/24.

#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlutternativedataPluginObjc : NSObject<FlutterPlugin>

+ (NSDictionary *)getDeviceInfo;

@end

NS_ASSUME_NONNULL_END

