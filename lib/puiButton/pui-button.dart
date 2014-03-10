library puiButton;

import 'dart:html';
import 'package:angular/angular.dart';

@NgComponent(
    selector: 'pui-button',
    templateUrl: 'packages/angularprime_dart/puiButton/pui-button.html',
    cssUrl: 'packages/angularprime_dart/puiButton/pui-button.css',
    publishAs: 'cmp'
)
class PuiButtonComponent extends NgShadowRootAware {
    
  @NgAttr("onClick")
  String onClick;
  @NgAttr("value")
  String value;
  @NgAttr("icon")
  String icon;
  
  /** The scope is needed to add watches. */
  Scope scope;
  
  Element puiButton;
  
  ButtonElement button;
  
  PuiButtonComponent(this.scope, this.puiButton){}
  
//  void handleClick() {
//    actionListener();
//  }
  
  
  void onShadowRoot(ShadowRoot shadowRoot) {
    shadowRoot.applyAuthorStyles = true;
    button = shadowRoot.querySelector('button');
    
    
    // @Todo move the code to the HTML snippet
    if (icon == null) {
      button.classes.add('pui-button-text-only');
    }
    
    if (icon != null) {
      button.classes.add('pui-button-text-icon-left');
      
      SpanElement iconSpan = new SpanElement();
      iconSpan.classes.add('pui-button-icon-left');
      iconSpan.classes.add('ui-icon');
      iconSpan.classes.add('ui-icon-'+icon);

      button.children.insert(0,iconSpan);
    }
        
//    button.onMouseEnter.listen((event) => button.classes.add('ui-state-hover'));
//    button.onMouseLeave.listen((event) => button.classes.remove('ui-state-hover'));
  }
    
}