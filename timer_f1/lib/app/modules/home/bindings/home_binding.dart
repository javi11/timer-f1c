import 'package:get/get.dart';
import 'package:timer_f1/app/modules/bluetooth/controllers/bluetooth_controller.dart';
import 'package:timer_f1/app/modules/usb_device/controllers/usb_device_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<BluetoothController>(
      () => BluetoothController(),
    );
    Get.lazyPut<UsbDeviceController>(
      () => UsbDeviceController(),
    );
  }
}
