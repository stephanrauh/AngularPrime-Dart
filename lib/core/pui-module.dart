/**
 * (C) 2014 Stephan Rauh http://www.beyondjava.net
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
library angularprime_dart;

import 'package:angular/angular.dart';
import 'package:di/di.dart';
import 'package:angularprime_dart/puiInput/pui-input.dart';
import 'package:angularprime_dart/puiButton/pui-button.dart';
import 'package:angularprime_dart/puiPanel/pui-panel.dart';
import 'package:angularprime_dart/puiCheckbox/pui-checkbox.dart';

/**
 * AngularPrime-Dart applications can get access to every PUI component by deriving from this class.
 * Alternatively, you can add the components you need manually.
 */
class PuiModule extends Module {
  PuiModule() {
    type(PuiInputTextComponent);
    type(PuiButtonComponent);
    type(PuiPanelComponent);
    type(PuiCheckboxComponent);
  }
}
