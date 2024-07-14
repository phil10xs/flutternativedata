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

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController tabController;
  String? platformVersion = 'Unknown';
  num? batteryLevel = 0;
  final _flutternativedataPlugin = Flutternativedata(showLogs: true);
  FNDeviceInfo? fnDeviceInfo;
  FNMemoryInfo? fnMemoryInfo;
  FNPackageInfo? fnPackageInfo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initTabController();
  }

  initTabController() {
    tabController = TabController(length: 5, vsync: this);
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
          centerTitle: true,
          //tabcontroller.index can be used to get the name of current index value of the tabview.
          title: Text(tabController.index == 0 ? "Device" : "Others"),
          bottom: TabBar(controller: tabController, tabs: [
            Tab(
              text: "Device",
              icon: Icon(
                Icons.home,
                color: Colors.indigo.shade500,
              ),
            ),
            Tab(
              text: "Package Info",
              icon: Icon(
                Icons.person,
                color: Colors.indigo.shade500,
              ),
            ),
            Tab(
              text: "Memory Info",
              icon: Icon(
                Icons.memory,
                color: Colors.indigo.shade500,
              ),
            ),
            Tab(
              text: "Battery Level",
              icon: Icon(
                Icons.battery_0_bar_outlined,
                color: Colors.indigo.shade500,
              ),
            ),
            Tab(
              text: "Platform Version",
              icon: Icon(
                Icons.place,
                color: Colors.indigo.shade500,
              ),
            ),
          ]),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'DeviceInfo',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  if (fnDeviceInfo != null)
                    ...fnDeviceInfo!.toMap().entries.map(
                          (entry) => Text('${entry.key}: ${entry.value}\n'),
                        ),
                ],
              ),
            ),
            Column(
              children: [
                const Text('Package Info',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    )),
                if (fnPackageInfo != null)
                  ...fnPackageInfo!.toMap().entries.map(
                        (entry) => Text('${entry.key}: ${entry.value}\n'),
                      ),
              ],
            ),
            if (fnMemoryInfo != null)
              Column(
                children: [
                  const Text(
                    'Memory Info',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  ...fnMemoryInfo!.toMap().entries.map(
                        (entry) => Text('${entry.key}: ${entry.value}\n'),
                      ),
                ],
              ),
            if (batteryLevel != null)
              Column(
                children: [
                  const Text('Battery Level',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      )),
                  Text(batteryLevel.toString())
                ],
              ),
            if (platformVersion != null)
              Column(
                children: [
                  const Text('Platform Version',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      )),
                  Text(platformVersion.toString())
                ],
              )
          ],
        ),
      ),
    );
  }
}
