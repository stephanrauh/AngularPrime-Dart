library angularprime_dart;

import 'package:angular/angular.dart';
import 'package:di/di.dart';
import 'package:angularprime_dart/puiInput/pui-input.dart';


class PuiModule extends Module {
  PuiModule() {
    type(PuiInputTextComponent);
  }
}
