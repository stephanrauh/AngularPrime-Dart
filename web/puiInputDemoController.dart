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
import 'package:angular/angular.dart';

@NgController(selector: '[puiInputDemo]', publishAs: 'ctrl')
class PuiInputDemoController {

  String firstField = "first model value";
  String secondField = "second model value";
  String thirdField = "third model value";
  bool firstBoolean = true;
  bool secondBoolean=true;
  bool thirdBoolean=false;
  List<Car> carTable = [
                         new Car('Honda', 'Civic', '2008', 'silver'),
                         new Car('Volvo', 'V40', '2002', 'green'),
                         new Car('Opel', 'Corsa', '1997', 'red'),
                         new Car('Opel', 'Kadett', '1990', 'white')
                                       ];

  List<Car> emptyCarTable = [];

  get thirdFieldStyle {
    if (thirdField.isNotEmpty)
      return "background-color:#FF0";
    else return
        "background-color:#F00";
  }
}

class Car {
  String brand;
  String type;
  String year;
  String color;
  Car(this.brand, this.type, this.year, this.color);
}
