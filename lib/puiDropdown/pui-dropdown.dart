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
library puiDropdown;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angularprime_dart/core/pui-base-component.dart';

/**
 * <pui-input> adds AngularDart to an input field styled by PrimeFaces.
 */
@NgComponent(
    selector: 'pui-dropdown',
    templateUrl: 'packages/angularprime_dart/puiDropdown/pui-dropdown.html',
    cssUrl: 'packages/angularprime_dart/puiDropdown/pui-dropdown.css',
    applyAuthorStyles: true,
    publishAs: 'cmp'
)
class PuiDropdownComponent extends PuiBaseComponent implements NgShadowRootAware  {
  /** The <pui-input> field as defined in the HTML source code. */ 
  Element puiInputElement;
 
  /** The <input> field in the shadow DOM displaying the component if the drop-down menu is editable. */
  InputElement shadowyInputField;
  
  /** The <input> field in the shadow DOM displaying the component if the drop-down menu is not editable. */
  LabelElement shadowySelection;
  
  /** This panel contains the list of predefined values. */
  DivElement dropDownPanel;
  
  /** put the predefined values into this container */
  UListElement dropDownItems;

  
  /** <pui-dropdown> fields require an ng-model attribute. */
  @NgTwoWay("ng-model")
  String ngmodel;
  
  /** The clear text value that's displayed to the user (instead of the internal ng-model) */
  String displayedValue;
  
  /** Is it an editable field, or is it restricted to the predefined list of options? */
  @NgOneWay("editable")
  bool editable;
  
  /** prevent endless loop caused by watches watching other watches */
  bool dontWatch=false;
  
  /** The scope is needed to add watches. */
  Scope scope;
  
  Map<String, String> predefinedOptions = new Map<String, String>();
  
 
  /**
   * Initializes the component by setting the <pui-dropdown> field and setting the scope.
   */
  PuiDropdownComponent(this.scope, this.puiInputElement) {
  }

  /**
   * Make the global CSS styles available to the shadow DOM, copy the user-defined attributes from
   * the HTML source code into the shadow DOM and see to it that model updates result in updates of the shadow DOM.
   * 
   * @Todo Find out, which attributes are modified by Angular, and set a watch updating only the attributes that have changed. 
   */
  void onShadowRoot(ShadowRoot shadowRoot) {
    shadowyInputField = shadowRoot.getElementsByTagName("input")[0];
    shadowySelection = shadowRoot.getElementsByTagName("label")[0];
    shadowySelection.parent.onClick.listen((Event) => toggleOptionBox());
    dropDownPanel = shadowRoot.getElementsByClassName("pui-dropdown-panel")[0];
    dropDownItems = shadowRoot.getElementsByClassName('pui-dropdown-items')[0];
    
    if (editable==true) {
      shadowySelection.style.display="none";
      shadowySelection.classes.add("ui-helper-hidden");
    }
    else {
      shadowyInputField.style.display="none";
      shadowyInputField.classes.add("ui-helper-hidden");
    }
    
    var children = puiInputElement.children;
    children.forEach((Element option) => add(option));
//    copyAttributesToShadowDOM(puiInputElement, shadowyInputField, scope);
    scope.$watch(()=>ngmodel, (newVar, oldVar) => updateDisplayedValue());
    scope.$watch(()=>displayedValue, (newVar, oldVar) => updateNgModel());
  }
  
  updateNgModel() {
    if (!dontWatch)
    {
      dontWatch=true;
     if (predefinedOptions.containsValue(displayedValue))
     {
       predefinedOptions.forEach((K, V) => (ngmodel=V==displayedValue?K:ngmodel));
     }
     else
       ngmodel=displayedValue;
    }
    else dontWatch=false;
  }
  
  
  updateDisplayedValue() {
    if (dontWatch)
    {
      dontWatch=false;
      return;      
    }
    dontWatch=true;
    if (predefinedOptions.containsKey(ngmodel))
      displayedValue=predefinedOptions[ngmodel];
    else
      displayedValue="";
  }
  
  add(Element option) {
    String v = option.value;
    String description = option.innerHtml;
    LIElement li = new LIElement();
    li.attributes["data-label"] =description;
    li.classes.add('pui-dropdown-item pui-dropdown-list-item ui-corner-all pui-dropdown-label');
    li.innerHtml=description;
    li.onClick.listen((Event) => select(li, v));
    dropDownItems.children.add(li);
    predefinedOptions[v]=description;
    
  }
  
  select(LIElement selectedLIElement, String v) {
    dropDownItems.children.forEach((LIElement li) => li.classes.remove("ui-state-highlight"));
    ngmodel=v;
    selectedLIElement.classes.add('ui-state-highlight');
    
  }
  
  void toggleOptionBox()
  {
    String s = dropDownPanel.style.display;
    String v = dropDownPanel.style.visibility;
    
    if (s.contains("none")) {
      dropDownPanel.style.display="block";
    }
    else {
      dropDownPanel.style.display="none";
    }
  }
}

