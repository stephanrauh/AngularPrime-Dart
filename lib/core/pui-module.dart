library angularprime_dart;

import 'package:angular/angular.dart';
import 'package:di/di.dart';
import 'package:angularprime_dart/puiInput/pui-input.dart';
import 'package:angularprime_dart/puiButton/pui-button.dart';
import 'package:angularprime_dart/puiPanel/pui-panel.dart';

/**
 * AngularPrime-Dart applications can get access to every PUI component by deriving from this class.
 * Alternatively, you can add the components you need manually.
 */
class PuiModule extends Module {
  PuiModule() {
    type(PuiInputTextComponent);
    type(PuiButtonComponent);
    type(PuiPanelComponent);
  }
}
