import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel("test.flutter/battery");
  String _batteryLevel = "-";

  Future<void> _getBatteryLevel() async {
    try {
      int batteryLevel = await platform.invokeMethod("getBatteryLevel");
      _batteryLevel = "$batteryLevel %";
    } catch (e) {
      _batteryLevel = "Error ${e.toString()}";
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _batteryLevel,
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
                onPressed: _getBatteryLevel,
                child: const Text("Get Battery Level"))
          ],
        ),
      ),
    );
  }
}
