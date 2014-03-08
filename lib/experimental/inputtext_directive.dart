library angularprime_dart;

import 'dart:html' as dom;
import 'package:angular/angular.dart';


@NgDirective(
    selector: '[puiinput2]'
)
class AInputtextDirective {
  dom.Element element;
  
  @NgOneWay('caption')
  String caption;
  
  @NgOneWay('bean')
  String bean;
  
  @NgOneWay('value')
  String value;
  
  dom.Element captionElem;
  dom.InputElement inputField;


  AInputtextDirective(this.element) {
    print('Constructor called');
    caption = element.getAttribute('caption');
    bean = element.getAttribute('bean');
    value = element.getAttribute('value');
    
    captionElem = new dom.SpanElement();
    captionElem.innerHtml=caption;
    element.append(captionElem);
    inputField = new dom.InputElement();
    inputField.setAttribute('ng-model', bean);
    inputField.name=bean;
    inputField.value=value;
    
    element.append(inputField);
    
  }

  _createTemplate() {
    assert(caption != null);
  }

}

class AInputtextModel {
  String caption;
  String model;

  AInputtextModel(this.caption, this.model);
}