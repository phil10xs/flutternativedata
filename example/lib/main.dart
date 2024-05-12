import 'dart:developer';

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
  String _platformVersion = 'Unknown';
  num _batteryLevel = 0;
  final _flutternativedataPlugin = Flutternativedata();
  Map<String, dynamic>? _deviceInfo;
  Map<String, dynamic>? _memoryInfo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    num batteryLevel;
    Map<String, dynamic>? deviceInfo;
    Map<String, dynamic>? memoryInfo;

    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutternativedataPlugin.getPlatformVersion() ??
          'Unknown platform version';
      batteryLevel = await _flutternativedataPlugin.getBatteryLevel() ?? 0;
      // _deviceInfo = await _flutternativedataPlugin.getDeviceInfo() ?? {};
      // _memoryInfo = await _flutternativedataPlugin.getMemoryInfo() ?? {};
    } on PlatformException catch (e) {
      log('error $e');
      platformVersion = 'Failed to get platform version.';
      batteryLevel = 0;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _batteryLevel = batteryLevel;
      _deviceInfo = deviceInfo;
      _memoryInfo = memoryInfo;
    });

    log('data $_deviceInfo $_memoryInfo $_batteryLevel $_platformVersion');
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
              Text('Running on: $_platformVersion\n'),
              Text('Battery level: $_batteryLevel\n'),
              if (_deviceInfo != null)
                ..._deviceInfo!.entries.map(
                  (entry) => Text('${entry.key}: ${entry.value}\n'),
                ),
              if (_memoryInfo != null)
                ..._memoryInfo!.entries.map(
                  (entry) => Text('${entry.key}: ${entry.value}\n'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
