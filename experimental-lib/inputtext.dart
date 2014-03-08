library angularprime_dart;

import 'dart:html' as dom;
import 'package:angular/angular.dart';


@NgComponent(
    selector: '[puiinput]',
    templateUrl: '../experimental-lib/inputtext.html',
    cssUrl: '../experimental-lib/inputtext.css',
    publishAs: 'cmp'
)
class AInputtextComponent {
  dom.Element element;
  
  String _caption;
  
  @NgAttr('caption')
  set caption(String value) {
    _caption=value;
  }
  
  get caption { return _caption; }
  
  String _id=null;
  
  get id
  {
    if (_id==null)
    {
      _id = this.hashCode.toString();
    }
    return _id;
  }
  
  @NgOneWay('bean')
  String bean;
  
  @NgTwoWay('value')
  String value;
  
  dom.Element captionElem;
  dom.InputElement inputField;


  AInputtextComponent(this.element) {
    print('Constructor called');
//    caption = element.getAttribute('caption');
//    bean = element.getAttribute('bean');
//    value = element.getAttribute('value');
    
//    captionElem = new dom.SpanElement();
//    captionElem.innerHtml=caption;
//    element.append(captionElem);
//    inputField = new dom.InputElement();
//    inputField.setAttribute('ng-model', bean);
//    inputField.name=bean;
//    inputField.value=value;
    
//    element.append(inputField);
    
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