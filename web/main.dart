import 'package:angular/angular.dart';
import 'package:di/di.dart';
import 'package:angularprime_dart/puiInput/pui-input.dart';
import 'package:angularprime_dart/core/pui-module.dart';
import 'puiInputDemoController.dart';

class MyAppModule extends PuiModule {
  MyAppModule() {
    type(PuiInputDemoController);
  }
}

void main() {
  ngBootstrap(module: new MyAppModule());
}
