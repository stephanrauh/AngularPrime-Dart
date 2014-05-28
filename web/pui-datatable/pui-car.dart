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

class Car {
  final Map<String, String> brands = {
     "Honda"   : "Honda",
     "Volvo"   : "Volvo",
     "Carriage": "Carriage",
     "Benz"    : "Benz",
     "Opel"    : "Opel",
     "VW"      : "VW",
     "Fiat"    : "Fiat",
     "Seat"    : "Seat"
  };

  Map<String, Map<String, String>> mapOfMatchingTypes = new Map<String, Map<String, String>>();

  final Map<String, String> types = {
     "Jazz"                      : "Honda",
     "Civic"                     : "Honda",
     "Accord"                    : "Honda",
     "C30"                       : "Volvo",
     "V40"                       : "Volvo",
     "V60"                       : "Volvo",
     "V70"                       : "Volvo",
     "Stanhope"                  : "Carriage",
     "Patent-Motorwagen Nummer 1": "Benz",
     "Kadett"                    : "Opel",
     "Corsa"                     : "Opel",
     "Astra"                     : "Opel",
     "Vectra"                    : "Opel",
     "Insignia"                  : "Opel",
     "Golf"                      : "VW",
     "Passat"                    : "VW",
     "Punto"                     : "Fiat",
     "Panda"                     : "Fiat",
     "León"                      : "Seat"
  };

  final Map<String, String> photographies = {
     "Jazz"                      : """<a title="By DaimlerChrysler AG [GFDL (http://www.gnu.org/copyleft/fdl.html) or CC-BY-SA-3.0 (http://creativecommons.org/licenses/by-sa/3.0/)], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3APatent-Motorwagen_Nr.1_Benz_2.jpg"><img width="256" alt="Patent-Motorwagen Nr.1 Benz 2" src="//upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Patent-Motorwagen_Nr.1_Benz_2.jpg/256px-Patent-Motorwagen_Nr.1_Benz_2.jpg"/></a>""",
     "Civic"                     : """<a title="von Haro (Eigenes Werk) [GFDL (http://www.gnu.org/copyleft/fdl.html) oder CC-BY-SA-3.0-2.5-2.0-1.0 (http://creativecommons.org/licenses/by-sa/3.0)], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3ACivic.jpg"><img width="256" alt="Civic" src="//upload.wikimedia.org/wikipedia/commons/thumb/2/2b/Civic.jpg/256px-Civic.jpg"/></a>""",
     "Accord"                    : """<a title="By Matthias93 (Own work) [CC-BY-SA-3.0 (http://creativecommons.org/licenses/by-sa/3.0)], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3AHonda_Accord_(2008)_rear.JPG"><img width="256" alt="Honda Accord (2008) rear" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/43/Honda_Accord_%282008%29_rear.JPG/256px-Honda_Accord_%282008%29_rear.JPG"/></a>""",
     "C30"                       : """<a title="von Gord Webster from Victoria, Canada (The new ride - a titanium gray 2011 Volvo C30) [CC-BY-SA-2.0 (http://creativecommons.org/licenses/by-sa/2.0)], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3AVolvo_C30_Facelift.jpg"><img width="256" alt="Volvo C30 Facelift" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/13/Volvo_C30_Facelift.jpg/256px-Volvo_C30_Facelift.jpg"/></a>""",
     "V40"                       : """<a title="von Andy / Andrew Fogg from near Cambridge, UK (one last wash 1  Uploaded by Oxyman) [CC-BY-2.0 (http://creativecommons.org/licenses/by/2.0)], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3AVolvo_v40_(104202196).jpg"><img width="256" alt="Volvo v40 (104202196)" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Volvo_v40_%28104202196%29.jpg/256px-Volvo_v40_%28104202196%29.jpg"/></a>""",
     "V60"                       : """<a title="von Renéke (Eigenes Werk) [CC-BY-SA-3.0 (http://creativecommons.org/licenses/by-sa/3.0)], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3ADashboard_Volvo_V60.jpg"><img width="256" alt="Dashboard Volvo V60" src="//upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Dashboard_Volvo_V60.jpg/256px-Dashboard_Volvo_V60.jpg"/></a>""",
     "V70"                       : """<a title="von User Just zis Guy, you know? on en.wikipedia [Für die Lizenz, siehe], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3A1998_Volvo_V70.jpg"><img width="256" alt="1998 Volvo V70" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/43/1998_Volvo_V70.jpg/256px-1998_Volvo_V70.jpg"/></a>""",
     "Stanhope"                  : """<a title="By Roland Zumbühl, Arlesheim [GFDL (http://www.gnu.org/copyleft/fdl.html) or CC-BY-SA-3.0 (http://creativecommons.org/licenses/by-sa/3.0/)], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3ASchweizer_Postkutsche_Gotthardpass.jpg"><img width="256" alt="Schweizer Postkutsche Gotthardpass" src="//upload.wikimedia.org/wikipedia/commons/5/51/Schweizer_Postkutsche_Gotthardpass.jpg"/></a>""",
     "Patent-Motorwagen Nummer 1": """<a title="von Aisano (Selbst fotografiert) [FAL], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3ABenz-Patent-Motorwagen_1886%2C_2.jpg"><img width="256" alt="Benz-Patent-Motorwagen 1886, 2" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Benz-Patent-Motorwagen_1886%2C_2.jpg/256px-Benz-Patent-Motorwagen_1886%2C_2.jpg"/></a>""",
     "Corsa"                     : """<a title="By LSDSL (Own work) [CC-BY-SA-3.0 (http://creativecommons.org/licenses/by-sa/3.0)], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3AOpel_Corsa_Mule_02.jpg"><img width="128" alt="Opel Corsa Mule 02" src="//upload.wikimedia.org/wikipedia/commons/c/c8/Opel_Corsa_Mule_02.jpg"/></a>""",
     "Astra"                     : """<a title="By M 93 (Own work) [CC-BY-SA-3.0-de (http://creativecommons.org/licenses/by-sa/3.0/de/deed.en)], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3AOpel_Astra_(J)_%E2%80%93_Frontansicht%2C_21._Juni_2011%2C_Heiligenhaus.jpg"><img width="256" alt="Opel Astra (J) – Frontansicht, 21. Juni 2011, Heiligenhaus" src="//upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Opel_Astra_%28J%29_%E2%80%93_Frontansicht%2C_21._Juni_2011%2C_Heiligenhaus.jpg/256px-Opel_Astra_%28J%29_%E2%80%93_Frontansicht%2C_21._Juni_2011%2C_Heiligenhaus.jpg"/></a>""",
     "Vectra"                    : """<a title="By Ecogarf (Own work) [GFDL (http://www.gnu.org/copyleft/fdl.html) or CC-BY-SA-3.0-2.5-2.0-1.0 (http://creativecommons.org/licenses/by-sa/3.0)], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3AVec_C2006.jpg"><img width="256" alt="Vec C2006" src="//upload.wikimedia.org/wikipedia/commons/6/6d/Vec_C2006.jpg"/></a>""",
     "Insignia"                  : """<a title="By Vascori2 (Own work) [CC-BY-SA-3.0 (http://creativecommons.org/licenses/by-sa/3.0)], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3AOpel_Insignia_facelift.jpg"><img width="256" alt="Opel Insignia facelift" src="//upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Opel_Insignia_facelift.jpg/256px-Opel_Insignia_facelift.jpg"/></a>""",
     "Kadett"                    : """<a title="By Rudolf Stricker (Own work) [Attribution], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3AOpel_Kadett_C_City_front_20081127.jpg"><img width="256" alt="Opel Kadett C City front 20081127" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Opel_Kadett_C_City_front_20081127.jpg/256px-Opel_Kadett_C_City_front_20081127.jpg"/></a>""",
     "Golf"                      : """<a title="By Lothar Spurzem (Own work) [CC-BY-SA-2.0-de (http://creativecommons.org/licenses/by-sa/2.0/de/deed.en)], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3AVW_Golf%2C_Bj._1974_(Spu).jpg"><img width="256" alt="VW Golf, Bj. 1974 (Spu)" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/12/VW_Golf%2C_Bj._1974_%28Spu%29.jpg/256px-VW_Golf%2C_Bj._1974_%28Spu%29.jpg"/></a>""",
     "Passat"                    : """<a title="By IFCAR (Own work) [Public domain], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3A2012_Volkswagen_Passat_SEL_TDI_--_08-31-2011.jpg"><img width="256" alt="2012 Volkswagen Passat SEL TDI -- 08-31-2011" src="//upload.wikimedia.org/wikipedia/commons/thumb/a/a9/2012_Volkswagen_Passat_SEL_TDI_--_08-31-2011.jpg/256px-2012_Volkswagen_Passat_SEL_TDI_--_08-31-2011.jpg"/></a>""",
     "Punto"                     : """<a title="von Thomas doerfer (Eigenes Werk) [GFDL (http://www.gnu.org/copyleft/fdl.html) oder CC-BY-SA-3.0 (http://creativecommons.org/licenses/by-sa/3.0/)], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3AFiat_Punto_55.JPG"><img width="256" alt="Fiat Punto 55" src="//upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Fiat_Punto_55.JPG/256px-Fiat_Punto_55.JPG"/></a>""",
     "Panda"                     : """<a title="von Meditberprod (Eigenes Werk) [CC-BY-SA-3.0 (http://creativecommons.org/licenses/by-sa/3.0)], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3AFiat-Panda_2003.jpg"><img width="256" alt="Fiat-Panda 2003" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/10/Fiat-Panda_2003.jpg/256px-Fiat-Panda_2003.jpg"/></a>""",
     "León"                      : """<a title="von Zorro86 (Eigenes Werk) [CC-BY-3.0 (http://creativecommons.org/licenses/by/3.0)], via Wikimedia Commons" href="http://commons.wikimedia.org/wiki/File%3ASeat_Leon_Frontansicht.jpg"><img width="256" alt="Seat Leon Frontansicht" src="//upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Seat_Leon_Frontansicht.jpg/256px-Seat_Leon_Frontansicht.jpg"/></a>""",
  };


  String brand;
  String type;
  int    _year;
  String color;
  String colorcode;
  String week;
  String city;
  String zipcode;
  String deliveryDate;
  String time;
  String email="lorem@ipsum.com";

  PuiDatatableDemoController _parent;

  Car(this.brand, this.type, this._year, this.color, this._parent);

  String toString()
  {
    return "$brand $type $year $color";
  }

  int toNumber(year){
    if (year is String) {
      return int.parse(year);
    }
    else return year;
  }

  int get year => _year;

  set year(dynamic newYear)
  {
    if (newYear.runtimeType== String)
    {
      _year=int.parse(newYear);
    }
    else if (newYear.runtimeType==int)
    {
      _year=newYear;
    }
  }

  String get image {
    String result="";
    if (null!=type)
    {
      if (photographies.containsKey(type))
      {
        result=photographies[type];
      }
    }
    return result;
  }

  Map<String, String> matchingTypes()
  {
    if (mapOfMatchingTypes.containsKey(brand)){
      return mapOfMatchingTypes[brand];
    }

    Map<String, String> m = new Map<String, String>();
    types.forEach((String key, String value) {
      if (value == brand) {
        m[key]=key;
      }
    });
    mapOfMatchingTypes[brand]=m;
    return m;
  }

  void editCar()
  {
    _parent.editCar(this);
  }

  void deleteCar()
  {
    _parent.deleteCar(this);
  }
}
