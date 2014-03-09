library angularprime_dart;

import 'dart:html';

class PuiBaseComponent {
  void copyAttributes(Element puiInputElement, InputElement shadowyInputField) {
    puiInputElement.attributes.forEach((String key, String value) =>
        addAttributeTo(shadowyInputField, key, value));
  }

  void addAttributeTo(InputElement inputfield, String key, String value) {
    var s = inputfield.attributes[key];
    if (s == null) {
      inputfield.attributes[key] = value;
      print("$key = $value");
    } else {
      inputfield.attributes[key] = "$s $value";
    }
  }
}
