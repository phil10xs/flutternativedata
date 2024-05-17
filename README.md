# Flutter Native Data plugin (Swift, Kotlin)
<?code-excerpt path-base="example/lib"?>

[![pub package]()](https://pub.dev/packages/flutternativedata)

A new Flutter plugin project that allows you get all native data in one place. 
Introducing FlutterNativeData, the ultimate Flutter plugin for accessing vital native device information effortlessly. 

With methods like getPackageInfo(), getDeviceInfo(), getMemoryInfo(), and getPlatformVersion(), streamline your development process and enhance user experiences with seamless access to critical platform-specific data. 

Elevate your Flutter apps with FlutterNativeData – your all-in-one solution for native data retrieval.

|             | Android | iOS   |
|-------------|---------|-------|
| **Support** | SDK 16+ | 12.0+ | 

![The example app running in Andriod](https://github.com/phil10xs/flutternativedata/blob/main/lib/demo/FND-Plugin-Android.gif?raw=true)

![The example app running in iOS](https://github.com/phil10xs/flutternativedata/blob/main/lib/demo/FND-Plugin-iOS.gif?raw=true)

![The example app running in iOS](https://github.com/flutter/packages/blob/main/packages/video_player/video_player/doc/demo_ipod.gif?raw=true)


## Example
<?code-excerpt "basic.dart (basic-example)"?>
```dart

/// Stateful widget to fetch and then display video content.
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
                    style: const TextStyle(
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
                    style: const TextStyle(
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
```

## Usage
The following section contains usage information that goes beyond what is included in the documentation in order to give a more elaborate overview of the plugin.

This is not complete as of now. You can contribute to this section by [opening a pull request](https://github.com/flutter/packages/pulls).








