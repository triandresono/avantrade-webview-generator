import 'package:avantrade_webview_generator/presentation/secret_generator/argument/secret_generator_argument.dart';
import 'package:avantrade_webview_generator/presentation/secret_generator/constant/secret_generator_constant.dart';
import 'package:avantrade_webview_generator/presentation/secret_generator/model/secret_generator_model.dart';
import 'package:get/get.dart';

class SecretGeneratorController extends GetxController {
  final SecretGeneratorConstant constant;
  final SecretGeneratorArgument argument;
  final SecretGeneratorModel model;
  SecretGeneratorController({
    required this.argument,
    required this.model,
    required this.constant,
  });
}
