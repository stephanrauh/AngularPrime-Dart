library angularprime_dart;

import 'dart:html' as dom;
import 'package:angular/angular.dart';


@NgComponent(
    selector: 'puiinput',
    templateUrl: '../lib/experimental/inputtext.html',
    cssUrl: '../lib/experimental/inputtext.css',
    publishAs: 'cmp'
)
class AInputtextComponent implements NgAttachAware  {
  dom.Element element;
  
  String _caption=null;
  
  @NgAttr('caption')
  set caption(String value) {
    _caption=value;
  }
  
  get caption { 
    return _caption; 
  }
  
  String _id=null;
  
  get id
  {
    if (_id==null)
    {
      _id = this.hashCode.toString();
    }
    return _id;
  }
  
  @NgOneWay('model')
  String model;
  
  dom.Element captionElem;
  dom.InputElement inputField;


  AInputtextComponent(this.element) {
    print('Constructor called: ' + this.runtimeType.toString());
    
  }

  @override
  void attach() {
    print("Attaching: $caption / $model / $id");
  }
}