library angularprime_dart;

import 'dart:html';
import 'package:angular/angular.dart';


/**
 * This class encapsulates common behaviour of the components of AngularPrime-Dart.
 * Most notably, the values of the attributes of the PUI template and the HTML code written by the 
 * user are merged into the shadow tree.
 * 
 * @Todo The merger should happen when the model changes. Current, it's triggered by the users key strokes.   
 */
class PuiBaseComponent {
  
  /** Stores the attributes originally defined by the user. */
  Map<String, String> originalValues;
 
  /** 
   * Copies every attribute from the updated <pui-input> - which contains the current model values - 
   * to the shadow tree.
   */
  void updateAttributesInShadowDOM(Element puiInputElement, InputElement shadowyInputField, Scope scope) {
    
    puiInputElement.attributes.forEach((String key, String value) =>
        updateAttributeInShadowDOM(shadowyInputField, key, value));
  }

  /** 
   * Copies a single attribute from the updated <pui-input> - which contains the current model values - 
   * to the shadow tree.
   */
  void updateAttributeInShadowDOM(InputElement inputfield, String key, String value) {
    if (originalValues.containsKey(key)) {
      String s = originalValues[key];
      if (s == null) {
        inputfield.attributes[key] = value;
      } else {
        inputfield.attributes[key] = "$s $value";
      }
    }
  }

  /** 
    * Copies every attribute from the updated <pui-input> - which contains the current model values - 
    * to the shadow tree, and creates the map of original attribute values.
    */

  void copyAttributesToShadowDOM(Element puiInputElement, InputElement shadowyInputField, Scope scope) {
     originalValues = new Map();

     puiInputElement.attributes.forEach((String key, String value) =>
         addAttributeToShadowDOM(shadowyInputField, key, value));
     
//     scope.$watch(()=>puiInputElement.attributes["ng-model"], (newVar, oldVar) => 
//          updateAttributesInShadowDOM(puiInputElement, shadowyInputField, scope));

   }
  /** 
    * Copies a single attribute from the updated <pui-input> - which contains the current model values - 
    * to the shadow tree, and adds to the map of original attribute values.
    */
 void addAttributeToShadowDOM(InputElement inputfield, String key, String value) {
    var s = inputfield.attributes[key];
    if (s != null && s.substring(0, 4) == "cmp.") {
      return;
    }
    originalValues[key] = s;
    if (s == null) {
      inputfield.attributes[key] = value;
    } else {
      inputfield.attributes[key] = "$s $value";
    }
  }
}

