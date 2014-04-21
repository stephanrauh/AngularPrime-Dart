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

library angularfaces_demo1;

import 'package:angularprime_dart/core/pui-module.dart';
import 'package:angular/angular.dart';

class MyAppModule extends PuiModule {
  MyAppModule() {
    type(CalculatorController);
  }

  /**
   * This method is can be overwritten to accomodate more complex situations. By default,
   * ngBootstrag is called with the single parameter <code>this</code>.
   */
  void bootStrap() {
    super.bootStrap();
    // equivalent to ngBootstrap(module: this);
  }

}

void main() {
  new MyAppModule();
  // ngBootstap is called automatically by the PuiModule class
  //ngBootstrap(module: new MyAppModule());
}


@NgController(selector: '[calculatorController]', publishAs: 'ctrl')
class CalculatorController {

  String number1 = "42";
  String number2 = "24";
  
  String get sum => add();
  
  set sum(String sum) {}

  String add() {
    int n1 = int.parse(number1);
    int n2 = int.parse(number2);
    return (n1+n2).toString();
  }
}

