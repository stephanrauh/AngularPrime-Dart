library angularprime_dart;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angularprime_dart/core/pui-base-component.dart';


@NgComponent(
    selector: 'pui-input',
    templateUrl: 'packages/angularprime_dart/puiInput/pui-input.html',
    cssUrl: 'packages/angularprime_dart/puiInput/pui-input.css',
    publishAs: 'cmp'
)
class PuiInputTextComponent extends PuiBaseComponent implements NgAttachAware, NgShadowRootAware  {
  Element puiInputElement;
 
  InputElement shadowyInputField;
  
  @NgTwoWay("ng-model")
  String ngmodel;


  PuiInputTextComponent(this.puiInputElement) {
//    print('Constructor called: ' + this.runtimeType.toString());
  }

  @override
  void attach() {
    // print("Attaching: ");
  }
  void onShadowRoot(ShadowRoot shadowRoot) {
    shadowRoot.applyAuthorStyles = true;
    shadowyInputField = shadowRoot.getElementsByTagName("input")[0];
    copyAttributes(puiInputElement, shadowyInputField);
  }
}

