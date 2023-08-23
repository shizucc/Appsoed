import 'package:get/get.dart';

import '../controller/gensoedmerch_controller.dart';

class GensoedMerchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GensoedMerchController>(
      () => GensoedMerchController(),
    );
  }
}
