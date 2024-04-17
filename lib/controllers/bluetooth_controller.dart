import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  List<BluetoothDevice> _bondedDevices = [];

  Future scanDevices() async {
    // Start scanning
    flutterBlue.startScan(timeout: const Duration(seconds: 5));
    // List<BluetoothDevice> devices = await flutterBlue.bondedDevices;
    // Start scanning

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });
    print('subscription: $subscription');
    // Stop scanning
    // _bondedDevices.addAll(devices);
    flutterBlue.stopScan();
    update();
  }

  // get bonded devices
  List<BluetoothDevice> get bondedDevices => _bondedDevices;
  // scan result stream
  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;

  // connect to device
  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
    print("Tried to connect: ${flutterBlue.connectedDevices}");
  }
}
