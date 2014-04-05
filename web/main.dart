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

library showcase;

import '../lib/core/pui-module.dart';
import 'package:angular/angular.dart';
import 'dart:html';
part 'puiInputDemoController.dart';
part 'puiButtonDemoController.dart';
part 'pui-datatable/puiDatatableDemoController.dart';

class MyAppModule extends PuiModule {
  MyAppModule() {
    type(PuiInputDemoController);
    type(PuiButtonDemoController);
    type(PuiDatatableDemoController);
  }
}

void main() {
  new MyAppModule();
  //ngBootstrap(module: new MyAppModule());
}
