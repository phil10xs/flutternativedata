import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutternativedata/entities/fn_device_info.dart';
import 'package:flutternativedata/entities/fn_memory_info.dart';
import 'package:flutternativedata/entities/fn_package_info.dart';
import 'package:flutternativedata/flutternativedata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String platformVersion = 'Unknown';
  num batteryLevel = 0;
  final _flutternativedataPlugin = Flutternativedata();
  FNDeviceInfo? fnDeviceInfo;
  FNMemoryInfo? fnMemoryInfo;
  FNPackageInfo? fnPackageInfo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutternativedataPlugin.getPlatformVersion() ??
          'Unknown platform version';
      batteryLevel = await _flutternativedataPlugin.getBatteryLevel() ?? 0;
      fnDeviceInfo = await _flutternativedataPlugin.getDeviceInfo();
      fnMemoryInfo = await _flutternativedataPlugin.getMemoryInfo();
      fnPackageInfo = await _flutternativedataPlugin.getPackageInfo();
    } on PlatformException catch (_) {
      platformVersion = 'Failed to get platform version.';
      batteryLevel = 0;
    }
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'FN Plugin example app',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('DeviceInfo',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    )),
                if (fnDeviceInfo != null)
                  ...fnDeviceInfo!.toMap().entries.map(
                        (entry) => Text('${entry.key}: ${entry.value}\n'),
                      ),
                const Text('PlatformInfo',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    )),
                Text('Running on: $platformVersion\n',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    )),
                const Text('PackageInfo',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    )),
                if (fnPackageInfo != null)
                  ...fnPackageInfo!.toMap().entries.map(
                        (entry) => Text('${entry.key}: ${entry.value}\n'),
                      ),
                const Text('BatteryInfo',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    )),
                Text('Battery level: $batteryLevel\n',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    )),
                const Text('MemoryInfo',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    )),
                if (fnMemoryInfo != null)
                  ...fnMemoryInfo!.toMap().entries.map(
                        (entry) => Text('${entry.key}: ${entry.value}\n'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
