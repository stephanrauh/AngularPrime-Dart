import 'package:angular/angular.dart';
import 'package:di/di.dart';
import 'package:angularprime_dart/experimental/inputtext.dart';
import 'puiInputDemoController.dart';

class MyAppModule extends Module {
  MyAppModule() {
    type(AInputtextComponent);
    type(PuiInputDemoController);
  }
}

void main() {
  ngBootstrap(module: new MyAppModule());
}
