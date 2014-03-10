library angularprime_dart;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angularprime_dart/core/pui-base-component.dart';

/**
 * <pui-input> adds AngularDart to an input field style by PrimeFaces.
 */
@NgComponent(
    selector: 'pui-input',
    templateUrl: 'packages/angularprime_dart/puiInput/pui-input.html',
    cssUrl: 'packages/angularprime_dart/puiInput/pui-input.css',
    publishAs: 'cmp'
)
class PuiInputTextComponent extends PuiBaseComponent implements NgShadowRootAware  {
  /** The <pui-input> field as defined in the HTML source code. */ 
  Element puiInputElement;
 
  /** The <input> field in the shadow DOM displaying the component. */
  InputElement shadowyInputField;
  
  /** <pui-input> fields require an ng-model attribute. */
  @NgTwoWay("ng-model")
  String ngmodel;
  
  /**
   * Initializes the component by setting the <pui-input> field.
   */
  PuiInputTextComponent(this.puiInputElement) {
  }

  /**
   * Make the global CSS styles available to the shadow DOM, copy the user-defined attributes from
   * the HTML source code into the shadow DOM and see to it that model updates result in updates of the shadow DOM.
   * 
   * @Todo Find out, which attributes are modified by Angular, and set a watch updating only the attributes that have changed. 
   */
  void onShadowRoot(ShadowRoot shadowRoot) {
    shadowRoot.applyAuthorStyles = true;
    shadowyInputField = shadowRoot.getElementsByTagName("input")[0];
    copyAttributesToShadowDOM(puiInputElement, shadowyInputField);
    shadowyInputField.onKeyUp.listen((KeyboardEvent e)=>updateAttributesInShadowDOM(puiInputElement, shadowyInputField));
  }
  
  
}

