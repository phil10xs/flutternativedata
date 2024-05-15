import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
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
  Map<Object?, Object?>? deviceInfo;
  Map<Object?, Object?>? memoryInfo;
  Map<Object?, Object?>? packageInfo;

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
      deviceInfo = await _flutternativedataPlugin.getDeviceInfo() ?? {};
      memoryInfo = await _flutternativedataPlugin.getMemoryInfo() ?? {};
      packageInfo = await _flutternativedataPlugin.getPackageInfo() ?? {};
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
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $platformVersion\n'),
              Text('Battery level: $batteryLevel\n'),
              if (deviceInfo != null)
                ...deviceInfo!.entries.map(
                  (entry) => Text('${entry.key}: ${entry.value}\n'),
                ),
              if (memoryInfo != null)
                ...memoryInfo!.entries.map(
                  (entry) => Text('${entry.key}: ${entry.value}\n'),
                ),
              if (packageInfo != null)
                ...packageInfo!.entries.map(
                  (entry) => Text('${entry.key}: ${entry.value}\n'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
