import 'package:get/get.dart';

abstract class GetxState extends GetxController {
  GetxState() {
    _triggerAsyncStart();
  }
  final List<Worker> disposables = [];

  @override
  void onClose() {
    for (var e in disposables) {
      e.dispose();
    }
    super.onClose();
  }

  void _triggerAsyncStart() async {
    await Future.delayed(const Duration(milliseconds: 200));
    (this).onCreateConstructor();
  }

  void onCreateConstructor() {}
}
