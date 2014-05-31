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
part of showcase;

@Controller(selector: '[puiDatatableDemo]', publishAs: 'ctrl')
class PuiDatatableDemoController {

  String cityRegExp = "([0-9])+";
  String secondCity="";

  Car currentCar=null;

  String get editAreaVisibilityStyle => (currentCar==null) ? "display:none" : "";

  List<Car> carTable;

  PuiDatatableDemoController(){
    carTable = [
                 new Car('Honda', 'Civic', 2008, 'silver', this),
                 new Car('Carriage', 'Stanhope', 332, 'black', this),
                 new Car('Volvo', 'V40', 2002, 'green', this),
                 new Car('Opel', 'Corsa', 1997, 'red', this),
                 new Car('Opel', 'Kadett', 1990, 'white', this)
               ];
  }

  List<Car> emptyCarTable = [];

  addCar() {
    int idx = carTable.length % 4;
    if (idx == 0)      carTable.add(new Car('Scoda',   'Octavia', (2000 + idx), 'silver', this));
    else if (idx == 1) carTable.add(new Car('Renault', 'R4',      (1970 + idx), 'red', this));
    else if (idx == 1) carTable.add(new Car('BMW',     'E30',     (1980 + idx), 'blue', this));
    else if (idx == 2) carTable.add(new Car('Volvo',   'V70',     (2006 + idx), 'red', this));
    else if (idx == 3) carTable.add(new Car('Fiat',    'Panda',   (2003 + idx), 'black', this));
  }

  deleteCar(Car c)
  {
    carTable.remove(c);
  }

  editCar(Car c)
  {
    currentCar=c;
  }

  int get currentYear => 2014;
  
  int leseJahr() { return 2014; }

}

