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
import 'package:angularprime_dart/puiPanel/pui-panel.dart';
import 'package:angularprime_dart/puiAccordion/pui-accordion.dart';
import 'package:angularprime_dart/puiTabview/pui-tabview.dart';
import 'package:angularprime_dart/puiTabview/pui-tab.dart';


import 'package:angularprime_dart/puiInput/pui-input.dart';
import 'package:angularprime_dart/puiButton/pui-button.dart';
import 'package:angularprime_dart/puiCheckbox/pui-checkbox.dart';
import 'package:angularprime_dart/puiDropdown/pui-dropdown.dart';
import 'package:angularprime_dart/puiTextarea/pui-textarea.dart';
import 'package:angularprime_dart/puiRadiobuttons/pui-radiobutton.dart';

import 'dart:html';


/**
 * AngularPrime-Dart applications can get access to every PUI component by deriving from this class.
 * Alternatively, you can add the components you need manually.
 */
class PuiModule extends Module {
  static NodeList nodesToBeWatched = null;

  /** Analyses each pui component of the DOM tree and add register attributes to be watched. */
  static void findNodesToBeWatched()
  {
    List<String> puiElements = ['pui-panel','pui-accordion', 'pui-input', 'pui-button', 'pui-checkbox', 'pui-dropdown'];
    List<HtmlElement> myComponents = puiElements.fold(null, (List<HtmlElement> list, String puiType) => addTags(list, puiType));
    myComponents.forEach((HtmlElement n) => registerAttributesToBeWatched(n));
  }

  /** Scans the entire document for a particular component type. */
  static List<HtmlElement> addTags(List<HtmlElement> initial, String puiType) {
    NodeList list = window.document.getElementsByTagName(puiType);
    List<Element> result = initial;
    if (null==result) result = new List<HtmlElement>();
    list.forEach((HtmlElement n) => result.add(n));
    return result;
  }

  static void registerAttributesToBeWatched(HtmlElement puiComponent)
  {
    String watches = "";
    puiComponent.attributes.forEach((String key, String value) { if (value.contains("{{") && value.contains("}}")) watches+=" "+innerExpression(value);});
    if (watches.length>0)
    {
      puiComponent.attributes["pui-toBeWatched"]=watches.trim();
    }
  }

  static String innerExpression(String value) {
    int start = value.indexOf("{{");
    int end = value.indexOf("}}", start);
    if (start>=0 && end>start)
    {
      return value.substring(start+2, end);
    }
    else return "";
  }



  PuiModule() {

    findNodesToBeWatched();

    type(PuiPanelComponent);
    type(PuiAccordionComponent);
    type(PuiTabviewComponent);
    type(PuiTabComponent);

    type(PuiInputTextComponent);
    type(PuiButtonComponent);
    type(PuiCheckboxComponent);
    type(PuiDropdownComponent);
//    type(PuiRadiobuttonComponent);
//    type(PuiTextareaComponent);
  }
}
